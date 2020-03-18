//
//  SemanticLabel.m
//  SemanticLabel
//
//  Created by LAP12230 on 3/15/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "SemanticLabel.h"
#import "NSString+FullWordTruncated.h"
#import "NSAttributedString+FullWordTruncated.h"


@interface SemanticLabel ()

@property (nonatomic, strong) NSString *fullText;
@property (nonatomic, strong) NSAttributedString *fullAttributedText;

@end

@implementation SemanticLabel

@synthesize fullWordTruncated = _fullWordTruncated;

#pragma mark - Custom Setters, Setters

- (BOOL)isFullWordTruncated {
    return _fullWordTruncated;
}

- (void)setFullWordTruncated:(BOOL)fullWordTruncated {
    _fullWordTruncated = fullWordTruncated;
    self.text = self.fullText;
}


#pragma mark - Overrided Methods

- (void)setText:(NSString *)text {
    self.fullText = text;
    if (self.fullWordTruncated) {
        text = [text stringThatFit:self.bounds.size
                     numberOfLines:self.numberOfLines
                        attributes:@{NSFontAttributeName : self.font}];
    }
    [super setText:text];
}


- (NSString *)text {
    return self.fullText;
}


- (void)setAttributedText:(NSAttributedString *)attributedText {
    self.fullAttributedText = attributedText;
    if (self.fullWordTruncated) {
        attributedText = [attributedText stringThatFit:self.bounds.size
                                         numberOfLines:self.numberOfLines];
    }
    [super setAttributedText:attributedText];
}


- (NSAttributedString *)attributedText {
    return self.fullAttributedText;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}


#pragma mark - Private methods


@end
