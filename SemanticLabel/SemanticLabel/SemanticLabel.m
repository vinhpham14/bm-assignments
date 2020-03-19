//
//  SemanticLabel.m
//  SemanticLabel
//
//  Created by LAP12230 on 3/15/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "SemanticLabel.h"
#import "NSAttributedString+FullWordTruncated.h"


@interface SemanticLabel ()

@property (nonatomic, strong) NSAttributedString *fullAttributedText;
@property (nonatomic, assign) BOOL shouldUpdateText;

@end

@implementation SemanticLabel

@synthesize enabledWordTruncated = _enabledWordTruncated;

#pragma mark - Custom Setters, Setters

- (BOOL)isEnabledWordTruncated {
    return _enabledWordTruncated;
}


- (void)setEnabledWordTruncated:(BOOL)fullWordTruncated {
    _enabledWordTruncated = fullWordTruncated;
    self.text = self.fullAttributedText.string;
}

#pragma mark - Overrided Methods

- (void)setText:(NSString *)text {
    [super setText:text];
    self.fullAttributedText = [super attributedText];
    
    if (self.isEnabledWordTruncated) [self truncateByWord];
}


- (NSString *)text {
    return [super text];
}


- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    self.fullAttributedText = [super attributedText];
    
    if (self.isEnabledWordTruncated) [self truncateByWord];
}


- (NSAttributedString *)attributedText {
    return [super attributedText];
}


- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    [super setAttributedText:self.fullAttributedText];
    if (self.isEnabledWordTruncated) [self truncateByWord];
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [super setAttributedText:self.fullAttributedText];
    if (self.isEnabledWordTruncated) [self truncateByWord];
}


#pragma mark - Private methods

- (void)truncateByWord {
    // Handle self-sizing with autolayout.
    CGSize fitInSize = self.constraints.count > 0 ? [self systemLayoutSizeFittingSize:UILayoutFittingExpandedSize] : self.bounds.size;
    NSAttributedString *attText = [self.fullAttributedText stringThatFit:fitInSize
                                                           numberOfLines:self.numberOfLines];
    [super setAttributedText:attText];
}

@end
