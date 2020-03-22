//
//  NSString+FullWordTruncated.m
//  SemanticLabel
//
//  Created by LAP12230 on 3/22/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "NSString+FullWordTruncated.h"

@implementation NSString (FullWordTruncated)

- (instancetype)stringThatFit:(CGSize)size attributes:(NSDictionary *)attributes expectedNumberOfLines:(NSUInteger)expectedNumberOfLines actualNumberOfLines:(NSUInteger * __nullable)actualNumberOfLines {
    
    // Validating
    if (self.length == 0) return self;
    
    UIFont *font = attributes[NSFontAttributeName];
    if (!font) return self;
    
    // All non-whitespaces characters OR all whitespaces except newlines OR newlines
    NSString *pattern = @"(\\S+)|([^\\S\\n\\r]+)|([\\n\\r])";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray * matches = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    // Get width of triple dots
    NSAttributedString *tripleDots = [[NSAttributedString alloc] initWithString:@"..." attributes:attributes];
    CGFloat tripleDotsWidth = [tripleDots boundingRectWithSize:size options:0 context:nil].size.width;
    
    CGFloat labelWidth = size.width;
    CGFloat lineWidth = 0;
    
    CGFloat totalHeight = 0;
    NSInteger totalLines = 0;
    NSUInteger stopIndex = 0;
    NSUInteger insertDotsIndex = 0;
    
    NSParagraphStyle *paragraphStyle = attributes[NSParagraphStyleAttributeName];
    if (!paragraphStyle) { paragraphStyle = NSParagraphStyle.defaultParagraphStyle; }
    
    // NOTE:
    // According to regex pattern:
    // Group 1: Match non-whitespaces characters (\S)
    // Group 2: Match all whitespaces except newlines
    // Group 3: Match newlines (\n \r)
    for (NSTextCheckingResult *result in matches) {
        
        NSUInteger length = NSMaxRange(result.range) - stopIndex;
        NSString *subString = [self substringWithRange:NSMakeRange(stopIndex, length)];
        CGSize subStringSize = [subString boundingRectWithSize:CGSizeZero options:0 attributes:attributes context:nil].size;
        BOOL willIncreaseLineCount = false;
        
        NSRange nonWhitespaceRange = [result rangeAtIndex:1];
        NSRange newLinesRange = [result rangeAtIndex:3];
        
        if (!NSEqualRanges(newLinesRange, NSMakeRange(NSNotFound, 0))) {
            
            willIncreaseLineCount = true;
            
        } else if (!NSEqualRanges(nonWhitespaceRange, NSMakeRange(NSNotFound, 0))) {
            
            // Find valid index to add triple dots.
            if (lineWidth + subStringSize.width + tripleDotsWidth < labelWidth) {
                insertDotsIndex = NSMaxRange(nonWhitespaceRange);
            }
            
            // Check if need new line.
            if (lineWidth + subStringSize.width > labelWidth)
                willIncreaseLineCount = true;
            
        }
        
        // Add lines and stop loop if enough lines.
        if (willIncreaseLineCount) {
            totalLines += 1;
            totalHeight += font.lineHeight + paragraphStyle.lineSpacing;
            lineWidth = 0;
            
            if (totalLines == expectedNumberOfLines) break;
            if (totalHeight > size.height) break;
        }
        
        // Update loop.
        lineWidth += subStringSize.width;
        stopIndex = NSMaxRange(result.range);
    }
    
    BOOL shouldAddTripleDots = stopIndex != self.length;
    if (shouldAddTripleDots) stopIndex = insertDotsIndex;
    NSString * result = [self substringWithRange:NSMakeRange(0, stopIndex)];
    
    if (actualNumberOfLines) *actualNumberOfLines = totalLines;
    return shouldAddTripleDots ? [result stringByAppendingFormat:@"%@", tripleDots.string] : result;
}


@end
