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
    
    if (self.length == 0) return self;
    
    CGFloat labelWidth = size.width;
    
    NSInteger line = 0;
    CGFloat lineWidth = 0;
    
    NSUInteger stopIndex = 0;
    NSUInteger insertDotsIndex = 0;
    
    NSString *pattern = @"(\\S+)|(\\s+)"; // All non-whitespaces characters OR all whitespaces.
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray * matches = [regex matchesInString:self.string options:0 range:NSMakeRange(0, self.length)];
    
    // Get width of triple dots
    NSDictionary *attributes = [self attributesAtIndex:self.length - 1 effectiveRange:0];
    NSAttributedString *tripleDots = [[NSAttributedString alloc] initWithString:@"..." attributes:attributes];
    CGFloat tripleDotsWidth = [tripleDots boundingRectWithSize:size options:0 context:nil].size.width;
    
    for (NSTextCheckingResult *result in matches) {
        
        NSUInteger length = NSMaxRange(result.range) - stopIndex;
        NSAttributedString *subString = [self attributedSubstringFromRange:NSMakeRange(stopIndex, length)];
        CGFloat subWidth = [subString boundingRectWithSize:CGSizeZero options:0 context:nil].size.width;
        
        NSRange nonWhitespaceRange = [result rangeAtIndex:1];
        if (!NSEqualRanges(nonWhitespaceRange, NSMakeRange(NSNotFound, 0))) {
            // Find valid index to add triple dots.
            if (lineWidth + subWidth + tripleDotsWidth < labelWidth) {
                insertDotsIndex = NSMaxRange(nonWhitespaceRange);
            }
            
            // Check if need new line.
            if (lineWidth + subWidth > labelWidth) {
                line += 1;
                lineWidth = 0;
            }
                
            // Check for stop.
            if (line == maxLine) break;
        }
        
        // Update loop.
        lineWidth += subWidth;
        stopIndex = NSMaxRange(result.range);
    }
    
    BOOL shouldAddTripleDots = stopIndex != self.length;
    if (shouldAddTripleDots) stopIndex = insertDotsIndex;
    NSMutableAttributedString *temp = [self attributedSubstringFromRange:NSMakeRange(0, stopIndex)].mutableCopy;
    
    [temp appendAttributedString: (shouldAddTripleDots ? tripleDots : NSAttributedString.new)];
    return temp.copy;
}


@end
