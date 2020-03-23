//
//  PaddingLabel.m
//  SemanticLabel
//
//  Created by LAP12230 on 3/23/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "PaddingLabel.h"

@implementation PaddingLabel

- (void)setTextInsets:(UIEdgeInsets)edgeInsets {
    _textInsets = edgeInsets;
    [self setNeedsDisplay];
}

- (void)drawTextInRect:(CGRect)rect {
    CGRect rectWithInsets = UIEdgeInsetsInsetRect(rect, self.textInsets);
    [super drawTextInRect:rectWithInsets];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize sizeWithoutInsets = [super sizeThatFits:CGSizeMake(size.width - self.textInsets.left - self.textInsets.right,
                                                              size.height - self.textInsets.top - self.textInsets.bottom)];
    
    return CGSizeMake(sizeWithoutInsets.width + self.textInsets.left + self.textInsets.right,
                      sizeWithoutInsets.height + self.textInsets.top + self.textInsets.bottom);
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    return CGSizeMake(size.width + self.textInsets.left + self.textInsets.right,
                      size.height + self.textInsets.top + self.textInsets.bottom);
}

@end
