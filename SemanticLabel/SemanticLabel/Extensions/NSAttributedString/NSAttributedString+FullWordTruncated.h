//
//  NSAttributedString+FullWordTruncated.h
//  SemanticLabel
//
//  Created by LAP12230 on 3/18/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (FullWordTruncated)

- (instancetype)stringThatFit:(CGSize)size expectedNumberOfLines:(NSUInteger)expectedNumberOfLines actualNumberOfLines:(NSUInteger * __nullable)actualNumberOfLines;

@end

NS_ASSUME_NONNULL_END
