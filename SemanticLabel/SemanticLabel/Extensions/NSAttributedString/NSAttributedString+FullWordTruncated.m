//
//  NSAttributedString+FullWordTruncated.m
//  SemanticLabel
//
//  Created by LAP12230 on 3/18/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "NSAttributedString+FullWordTruncated.h"

@implementation NSAttributedString (FullWordTruncated)

- (instancetype)stringThatFit:(CGSize)size numberOfLines:(NSUInteger)maxLine {
    
    CGFloat labelWidth = size.width;
    
    NSInteger line = 0;
    CGFloat lineWidth = 0;
    
    NSUInteger stopIndex = 0;
    NSUInteger insertDotsIndex = 0;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\S+" options:0 error:nil];
    NSArray * matches = [regex matchesInString:self.string options:0 range:NSMakeRange(0, self.length)];
    
    NSDictionary *attributes = [self attributesAtIndex:self.length - 1 effectiveRange:0];
    NSAttributedString *tripleDots = [[NSAttributedString alloc] initWithString:@"..." attributes:attributes];
    CGFloat tripleDotsWidth = [tripleDots boundingRectWithSize:size options:0 context:nil].size.width;
    
    for (NSTextCheckingResult *result in matches) {
        
        NSUInteger length = NSMaxRange(result.range) - stopIndex;
        NSAttributedString *subString = [self attributedSubstringFromRange:NSMakeRange(stopIndex, length)];
        CGFloat subWidth = [subString boundingRectWithSize:CGSizeZero options:0 context:nil].size.width;
        
        // Find valid index to add triple dots.
        if (lineWidth + subWidth + tripleDotsWidth < labelWidth) {
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
    
    BOOL shouldAddTripleDots = [self.string rangeOfString:@"\\S+"
                                                  options:NSRegularExpressionSearch
                                                    range:NSMakeRange(stopIndex, self.length - stopIndex)].length != 0;
    
    if (shouldAddTripleDots) stopIndex = insertDotsIndex;
    NSMutableAttributedString *temp = [self attributedSubstringFromRange:NSMakeRange(0, stopIndex)].mutableCopy;
    
    [temp appendAttributedString: (shouldAddTripleDots ? tripleDots : nil)];
    return temp.copy;
}


@end
