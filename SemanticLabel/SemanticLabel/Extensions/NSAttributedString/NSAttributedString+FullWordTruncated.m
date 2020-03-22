//
//  NSAttributedString+FullWordTruncated.m
//  SemanticLabel
//
//  Created by LAP12230 on 3/18/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "NSAttributedString+FullWordTruncated.h"

@implementation NSAttributedString (FullWordTruncated)

- (instancetype)stringThatFit:(CGSize)size expectedNumberOfLines:(NSUInteger)expectedNumberOfLines actualNumberOfLines:(NSUInteger * __nullable)actualNumberOfLines {
    
    if (self.length == 0) return self;
    
    CGFloat labelWidth = size.width;
    
    NSInteger line = 0;
    CGFloat lineWidth = 0;
    
    NSUInteger stopIndex = 0;
    NSUInteger insertDotsIndex = 0;
    
    // All non-whitespaces characters OR all whitespaces except newlines OR newlines
    NSString *pattern = @"(\\S+)|([^\\S\\n\\r]+)|([\\n\\r])";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray * matches = [regex matchesInString:self.string options:0 range:NSMakeRange(0, self.length)];
    
    // Get width of triple dots
    NSDictionary *attributes = [self attributesAtIndex:self.length - 1 effectiveRange:0];
    NSAttributedString *tripleDots = [[NSAttributedString alloc] initWithString:@"..." attributes:attributes];
    CGFloat tripleDotsWidth = [tripleDots boundingRectWithSize:size options:0 context:nil].size.width;
    
    // NOTE:
    // According to regex pattern:
    // Group 1: Match non-whitespaces characters (\S)
    // Group 2: Match all whitespaces except newlines
    // Group 3: Match newlines (\n \r)
    for (NSTextCheckingResult *result in matches) {
        
        NSUInteger length = NSMaxRange(result.range) - stopIndex;
        NSAttributedString *subString = [self attributedSubstringFromRange:NSMakeRange(stopIndex, length)];
        CGFloat subWidth = [subString boundingRectWithSize:CGSizeZero options:0 context:nil].size.width;
        BOOL willIncreaseLineCount = false;
        
        NSRange nonWhitespaceRange = [result rangeAtIndex:1];
        NSRange newLinesRange = [result rangeAtIndex:3];
        
        if (!NSEqualRanges(newLinesRange, NSMakeRange(NSNotFound, 0))) {
            
            willIncreaseLineCount = true;
            
        } else if (!NSEqualRanges(nonWhitespaceRange, NSMakeRange(NSNotFound, 0))) {
            
            // Find valid index to add triple dots.
            if (lineWidth + subWidth + tripleDotsWidth < labelWidth) {
                insertDotsIndex = NSMaxRange(nonWhitespaceRange);
            }
            
            // Check if need new line.
            if (lineWidth + subWidth > labelWidth)
                willIncreaseLineCount = true;
            
        }
        
        // Add lines and stop loop if enough lines.
        if (willIncreaseLineCount) {
            line += 1;
            lineWidth = 0;
            if (line == expectedNumberOfLines) break;
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
