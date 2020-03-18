//
//  NSString+FullWordTruncated.m
//  SemanticLabel
//
//  Created by LAP12230 on 3/18/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "NSString+FullWordTruncated.h"

@implementation NSString (FullWordTruncated)

- (instancetype)stringThatFit:(CGSize)size numberOfLines:(NSUInteger)maxLine attributes:(NSDictionary *)attributes {
    
    CGFloat labelWidth = size.width;
    
    NSInteger line = 0;
    CGFloat lineWidth = 0;
    
    NSUInteger stopIndex = 0;
    NSUInteger insertDotsIndex = 0;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\S+" options:0 error:nil];
    NSArray * matches = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    CGFloat tripleDotWidth = [@"..." boundingRectWithSize:CGSizeZero options:0 attributes:attributes context:nil].size.width;
    for (NSTextCheckingResult *result in matches) {
        
        NSUInteger length = NSMaxRange(result.range) - stopIndex;
        NSString *subString = [self substringWithRange:NSMakeRange(stopIndex, length)];
        CGFloat subWidth = [subString boundingRectWithSize:CGSizeZero options:0 attributes:attributes context:nil].size.width;
        
        // Find valid index to add triple dots.
        if (lineWidth + subWidth + tripleDotWidth < labelWidth) {
            insertDotsIndex = NSMaxRange(result.range);
        }
        
        // Check if need new line.
        if (lineWidth + subWidth > labelWidth) {
            line += 1;
            lineWidth = 0;
        }
            
        // Update width.
        lineWidth += subWidth;
        
        // Check for stop.
        if (line == maxLine) break;
        stopIndex = NSMaxRange(result.range);
    }
    
    BOOL shouldAddTripleDots = [self rangeOfString:@"\\S+"
                                           options:NSRegularExpressionSearch
                                             range:NSMakeRange(stopIndex, self.length - stopIndex)].length != 0;
    
    if (shouldAddTripleDots) stopIndex = insertDotsIndex;
    NSString *threeDots = shouldAddTripleDots ? @"..." : @"";
    
    NSLog(@"result truncated: %@", [[self substringWithRange:NSMakeRange(0, stopIndex)] stringByAppendingString:threeDots]);
    return [[self substringWithRange:NSMakeRange(0, stopIndex)] stringByAppendingString:threeDots];
}

@end
