//
//  EmojiParser.m
//  CustomText
//
//  Created by LAP12230 on 3/13/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "EmojiParser.h"

@interface EmojiParser ()

@property (nonatomic, strong) EmojiSet *emojiSet;

@end


@implementation EmojiParser

#pragma mark - Inititalize

- (instancetype)init {
    self = [super init];
    if (self) {
        _emojiSets = NSMutableArray.new;
    }
    return self;
}


#pragma mark Custom Setters, Getters 

- (NSString *)currentSetName {
    return self.currentEmojiSet.name;
}

- (EmojiSet *)currentEmojiSet {
    NSUInteger count = self.emojiSets.count;
    NSUInteger index = self.currentEmojiIndex;
    
    if (count == 0 || index > count - 1) return nil;
    return self.emojiSets[index];
}


#pragma mark - Revert

- (NSAttributedString *)revertFromEmoji:(NSAttributedString *)attStr {
    NSInteger numb = 0;
    return [self revertFromEmoji:attStr locationCursorInString:&numb];
}


- (NSAttributedString *)revertFromEmoji:(NSAttributedString *)attStr locationCursorInString:(NSInteger *)locationCursor {
    
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


#pragma mark - Convert

- (NSAttributedString *)convertToEmoji:(NSAttributedString *)attStr {
    NSInteger numb = 0;
    return [self convertToEmoji:attStr locationCursorInWord:&numb];
}


- (NSAttributedString *)convertToEmoji:(NSAttributedString *)attStr locationCursorInWord:(NSInteger *)locationCursor {
    
    // Validate
    if (!self.currentEmojiSet) return attStr;
    
    NSAttributedString *stringWithoutEmoji = [self revertFromEmoji:attStr locationCursorInString:locationCursor];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:stringWithoutEmoji];
    NSInteger cursor = locationCursor ? *locationCursor : 0;
    
    NSString *pattern = self.currentEmojiSet.regexPattern;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                         options:0
                                                                           error:nil];
    
    NSArray *matches = [reg matchesInString:text.string
                                    options:0
                                      range:NSMakeRange(0, text.length)];
    
    for (NSTextCheckingResult *result in matches.reverseObjectEnumerator) {
        
        NSString * word = [text attributedSubstringFromRange:result.range].string;
        EmojiAttachment *attachment = [self generateEmojiAttachment:word];
        
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


#pragma mark - Private Methods

- (EmojiAttachment *) generateEmojiAttachment:(NSString *)code {
    
    NSDictionary *emojiDictionary = self.currentEmojiSet.emojiDictionary;
    
    NSString *imageName = emojiDictionary[code];
    UIImage *image = [UIImage imageNamed:imageName];
    
    EmojiAttachment *attachment;
    
    if (image) {
        attachment = [EmojiAttachment attachmentWithCode:code image:image];
    }
    
    return attachment;
}

@end
