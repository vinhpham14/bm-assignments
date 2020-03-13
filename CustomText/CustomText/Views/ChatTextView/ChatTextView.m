//
//  ChatTextView.m
//  CustomText
//
//  Created by LAP12230 on 3/9/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "ChatTextView.h"

@interface ChatTextView ()

@property (nonatomic, strong) EmojiParser * emojiParser;

@end


@implementation ChatTextView

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _emojiParser = EmojiParser.new;
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _emojiParser = EmojiParser.new;
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _emojiParser = EmojiParser.new;
    }
    return self;
}

#pragma mark - Emoji Parser

- (void)setDataSource:(id<EmojiParserDataSource>)dataSource {
    _dataSource = dataSource;
    self.emojiParser.dataSource = dataSource;
}


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
    NSMutableAttributedString *parsingText = [self.emojiParser convertToEmoji:rawString].mutableCopy;
    
    // Update text
    [self.textStorage replaceCharactersInRange:self.selectedRange withAttributedString:parsingText];
    self.selectedRange = NSMakeRange(preLocation + parsingText.length, 0);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
    [self updateTextToEmoji];
}


- (void)copy:(id)sender {

    if (self.selectedRange.length == 0) return;

    NSAttributedString *targetString = [self.attributedText attributedSubstringFromRange:self.selectedRange];
    NSString *rawString = [self.emojiParser revertFromEmoji:targetString].string;
    
    UIPasteboard.generalPasteboard.string = rawString;
}


- (void)cut:(id)sender {
    
    [self copy:sender];
    [self.textStorage replaceCharactersInRange:self.selectedRange withString:@""];
    
    // Update cursor
    self.selectedRange = NSMakeRange(self.selectedRange.location, self.selectedRange.length);
    [self updateTextToEmoji];
}


#pragma mark - Private Methods


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
    NSAttributedString *emojiText = [self.emojiParser convertToEmoji:word locationCursorInWord:&locationCursorInWord];
    [self.textStorage replaceCharactersInRange:range withAttributedString:emojiText];
    
    // Update cursor position
    self.selectedRange = NSMakeRange(range.location + locationCursorInWord, self.selectedRange.length);
}

@end
