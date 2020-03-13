//
//  ChatTextView.m
//  CustomText
//
//  Created by LAP12230 on 3/9/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "ChatTextView.h"
#import "EmojiAttachment.h"

@implementation ChatTextView

#pragma mark - Overrided Methods

- (void)insertText:(NSString *)text {
    [super insertText:text];
    [self updateTextToEmoji];
}


- (void)deleteBackward {
    [super deleteBackward];
    [self updateTextToEmoji];
}


- (void)paste:(id)sender {
    
    // Caching attributes
    NSMutableDictionary *cachedAttributes = self.typingAttributes.mutableCopy;
    NSInteger preLocation = self.selectedRange.location;
    
    NSAttributedString *rawString = [[NSAttributedString alloc] initWithString:UIPasteboard.generalPasteboard.string
                                                                    attributes:cachedAttributes];
    NSMutableAttributedString *parsingText = [self convertToEmoji:rawString].mutableCopy;
    
    // Update text
    [self.textStorage replaceCharactersInRange:self.selectedRange withAttributedString:parsingText];
    self.selectedRange = NSMakeRange(preLocation + parsingText.length, 0);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
}


- (void)copy:(id)sender {

    if (self.selectedRange.length == 0) return;

    NSAttributedString *targetString = [self.attributedText attributedSubstringFromRange:self.selectedRange];
    NSString *rawString = [self revertFromEmoji:targetString].string;
    
    UIPasteboard.generalPasteboard.string = rawString;
}


- (void)cut:(id)sender {
    
    [self copy:sender];
    [self.textStorage replaceCharactersInRange:self.selectedRange withString:@""];
    
    // Update cursor
    self.selectedRange = NSMakeRange(self.selectedRange.location, self.selectedRange.length);
}


#pragma mark - Private Methods

- (void)setSelectedRange:(NSRange)selectedRange {
    [super setSelectedRange:selectedRange];
}


- (NSAttributedString *)currentWord:(NSRange *)wordRange {
    
    NSRange cursorRange = self.selectedRange;
    NSRange leftRange = [self.text rangeOfCharacterFromSet:NSCharacterSet.whitespaceAndNewlineCharacterSet
                                                   options:NSBackwardsSearch
                                                     range:NSMakeRange(0, cursorRange.location)];
    
    if (leftRange.location == NSNotFound && leftRange.length == 0) {
        leftRange.location = 0;
    }
    
    NSRange wRange = [self.text rangeOfString:@"[^ \n]+"
                                      options:NSRegularExpressionSearch
                                        range:NSMakeRange(leftRange.location, self.text.length - leftRange.location)];
    
    wordRange->length = wRange.length;
    wordRange->location = wRange.location;
    
    if (wRange.length == 0 && wRange.location == NSNotFound) return nil;
    return [self.attributedText attributedSubstringFromRange:wRange];
}


- (NSRange)currentCheckingRange {
    
    NSCharacterSet *chars = NSCharacterSet.whitespaceAndNewlineCharacterSet;
    NSRange cursorRange = self.selectedRange;
    
    NSInteger left = cursorRange.location - 1;
    NSInteger right = NSMaxRange(self.selectedRange);
    
    BOOL continueLeft = true;
    BOOL continueRight = true;
    
    if (right == self.text.length) {
        right = self.text.length - 1;
        continueRight = false;
    }
    
    if (left < 0) {
        left = 0;
        continueLeft = false;
    } else if ([chars characterIsMember:[self.text characterAtIndex:left]] && left != 0) {
        left -= 1;
    }
    
    while (continueRight || continueLeft) {
        
        if (left > 0 && ![chars characterIsMember:[self.text characterAtIndex:left]]) {
            left -= 1;
        } else {
            continueLeft = false;
        }
        
        if (right < self.text.length - 1 && ![chars characterIsMember:[self.text characterAtIndex:right]]) {
            right += 1;
        } else {
            continueRight = false;
        }
        
    }
    
    return NSMakeRange(left, right - left + 1);
}


- (void)updateTextToEmoji {
    NSRange range = [self currentCheckingRange];
    [self updateEmojiInRange:range];
}


- (void)updateEmojiInRange:(NSRange)range {
    
    if (range.length == 0) return;
    
    // Caching cursor position
    NSInteger locationCursorInWord = self.selectedRange.location - range.location;
    
    // Get emoji
    NSAttributedString *word = [self.attributedText attributedSubstringFromRange:range];
    NSAttributedString *emojiText = [self convertToEmoji:word locationCursorInWord:&locationCursorInWord];
    [self.textStorage replaceCharactersInRange:range withAttributedString:emojiText];
    
    // Update cursor position
    self.selectedRange = NSMakeRange(range.location + locationCursorInWord, self.selectedRange.length);
}


- (NSAttributedString *)revertFromEmoji:(NSAttributedString *)attStr {
    return [self revertFromEmoji:attStr locationCursorInWord:nil];
}


- (NSAttributedString *)revertFromEmoji:(NSAttributedString *)attStr locationCursorInWord:(NSInteger *)locationCursor {
    
    __block NSInteger cursor = locationCursor ? *locationCursor : 0;
    NSMutableAttributedString *editedStr = [[NSMutableAttributedString alloc] initWithAttributedString:attStr];
    
    [editedStr enumerateAttribute:NSAttachmentAttributeName
                          inRange:NSMakeRange(0, editedStr.length)
                          options:0
                       usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:EmojiAttachment.class]) {
            EmojiAttachment *emoji = (EmojiAttachment *)value;
            [editedStr replaceCharactersInRange:range withString:emoji.rawString];
            [editedStr removeAttribute:NSAttachmentAttributeName range:range];
            
            // Update location cursor in word
            if (range.location + range.length <= cursor) {
                NSInteger offset = emoji.rawString.length - 1;
                cursor += offset;
            }
        }
    }];
    
    if (locationCursor) *locationCursor = cursor;
    return editedStr;
}


- (NSAttributedString *)convertToEmoji:(NSAttributedString *)attStr locationCursorInWord:(NSInteger *)locationCursor {
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:[self revertFromEmoji:attStr locationCursorInWord:locationCursor]];
    NSInteger cursor = locationCursor ? *locationCursor : 0;
    
    NSString *pattern = @"([:;8bX$][03aozxsdhptBPDQHUG'@><*\\(\\)\\-=|]+)|(/\\-[a-z]+)";
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                         options:0
                                                                           error:nil];
    
    NSArray *matches = [reg matchesInString:text.string
                                    options:0
                                      range:NSMakeRange(0, text.length)];
    
    for (NSTextCheckingResult *result in matches.reverseObjectEnumerator) {
        
        NSString * word = [text attributedSubstringFromRange:result.range].string;
        EmojiAttachment *attachment = [[EmojiAttachment alloc] initWithEmojiCode:word];
        
        if (attachment) {
            
            // Caching old attributes
            NSDictionary *oldAttributes = [text attributesAtIndex:result.range.location effectiveRange:nil];
            
            [attachment alignEmojiWithAttributes:oldAttributes];
            NSAttributedString *emoji = [NSAttributedString attributedStringWithAttachment:attachment];
            
            // Replace and recover attributes
            [text replaceCharactersInRange:result.range withAttributedString:emoji];
            [text addAttributes:oldAttributes range:NSMakeRange(result.range.location, 1)];
            
            // Update location cursor in word
            // Case: cursor not inside the replacing word.
            if (cursor > NSMaxRange(result.range) - 1) {
                NSInteger offset = 1 - result.range.length;
                cursor += offset;
            }
            
            // Case: cursor inside or next to the replacing word.
            else if (result.range.location <= cursor
                       && cursor <= NSMaxRange(result.range) - 1) {
                
                // Case: before the replacing word.
                if (cursor == result.range.location) {
                    cursor = result.range.location;
                }
                // Case: inside
                else {
                    cursor = result.range.location + 1;
                }
            }
            
        }
    }
    
    if (locationCursor) *locationCursor = cursor;
    return text;
}


- (NSAttributedString *)convertToEmoji:(NSAttributedString *)attStr {
    return [self convertToEmoji:attStr locationCursorInWord:nil];
}

@end
