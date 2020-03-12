//
//  EmojiTextView.m
//  CustomText
//
//  Created by LAP12230 on 3/6/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "EmojiTextView.h"
#import "EmojiParser.h"


@interface EmojiTextView ()

@property (nonatomic, strong) EmojiParser *emojiParser;

@end


@implementation EmojiTextView


#pragma mark - Life Cycles

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self internalInit];
    }
    
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    return self;
}


- (void)dealloc {
    
}


#pragma mark - Custom Setters, Getters

- (EmojiParser *)emojiParser {
    if (!_emojiParser) {
        _emojiParser = [[EmojiParser alloc] init];
    }
    
    return _emojiParser;
}


- (void)insertText:(NSString *)text {
    
}


- (void)deleteBackward {
    
}


#pragma mark - Overrided Methods

- (void)internalInit {
    [super internalInit];
    // self.rawText = NSMutableString.new;
    self.delegate = self;
}


- (void)textViewDidChangeValueHandler:(NSNotification *)notification{
    [super textViewDidChangeValueHandler:notification];
    self.attributedText = [self.emojiParser convertFromString:self.attributedText];
}


#pragma mark - Private Methods

- (NSRange)visibleTextRange {
    
    if (self.text.length <= 0) return NSMakeRange(0, 0);
    
    CGSize size = self.bounds.size;
    CGPoint origin = self.bounds.origin;
    
    UITextPosition *leftTopPosition = [self closestPositionToPoint:origin];
    UITextPosition *rightBottomPosition = [self closestPositionToPoint:CGPointMake(origin.x + size.width, origin.y + size.height)];
    
    NSUInteger location = [self offsetFromPosition:self.beginningOfDocument toPosition:leftTopPosition];
    NSUInteger length = MIN([self offsetFromPosition:leftTopPosition toPosition:rightBottomPosition] + 1,
                            self.text.length);
    
    return NSMakeRange(location, length);
}


#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return true;
}


@end
