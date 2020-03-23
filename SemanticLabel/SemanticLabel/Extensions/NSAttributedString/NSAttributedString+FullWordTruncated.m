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
    
    // All non-whitespaces characters OR all whitespaces except newlines OR newlines.
    NSString *pattern = @"(\\S+)|([^\\S\\n\\r]+)|([\\n\\r])";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray * matches = [regex matchesInString:self.string options:0 range:NSMakeRange(0, self.length)];
    
    // Get width of triple dots.
    NSDictionary *attributes = [self attributesAtIndex:self.length - 1 effectiveRange:0];
    NSAttributedString *tripleDots = [[NSAttributedString alloc] initWithString:@"..." attributes:attributes];
    CGFloat tripleDotsWidth = [tripleDots boundingRectWithSize:size options:0 context:nil].size.width;
    
    // Get needed attributes for calculating height of lines
    NSDictionary *dictionary = [self attributesAtIndex:0 effectiveRange:nil];
    UIFont *font = dictionary[NSFontAttributeName];
    NSParagraphStyle *paragraphStyle = dictionary[NSParagraphStyleAttributeName];
    if (!font) font = [UIFont systemFontOfSize:UIFont.systemFontSize];
    if (!paragraphStyle) paragraphStyle = NSParagraphStyle.defaultParagraphStyle;
    
    NSInteger totalLines = 0;
    CGFloat totalHeight = font.lineHeight;
    CGFloat lineWidth = 0;
    CGFloat labelWidth = size.width;
    
    NSUInteger stopIndex = 0;
    NSUInteger insertDotsIndex = 0;
    
    // NOTE:
    // According to regex pattern:
    // Group 1: Match non-whitespaces characters (\S).
    // Group 2: Match all whitespaces except newlines.
    // Group 3: Match newlines (\n \r).
    for (NSTextCheckingResult *result in matches) {
        
        NSUInteger length = NSMaxRange(result.range) - stopIndex;
        NSAttributedString *subString = [self attributedSubstringFromRange:NSMakeRange(stopIndex, length)];
        CGSize subSize = [subString boundingRectWithSize:CGSizeZero options:0 context:nil].size;
        BOOL willIncreaseLineCount = false;
        
        NSRange nonWhitespaceRange = [result rangeAtIndex:1];
        NSRange newLinesRange = [result rangeAtIndex:3];
        
        if (!NSEqualRanges(newLinesRange, NSMakeRange(NSNotFound, 0))) {

            willIncreaseLineCount = true;
            
        } else if (!NSEqualRanges(nonWhitespaceRange, NSMakeRange(NSNotFound, 0))) {
            
            // Find valid index to add triple dots.
            if (lineWidth + subSize.width + tripleDotsWidth < labelWidth) {
                insertDotsIndex = NSMaxRange(nonWhitespaceRange);
            }
            
            // Check if need new line.
            if (lineWidth + subSize.width > labelWidth)
                willIncreaseLineCount = true;
            
        }
        
        // Move to next line and stop if needed.
        if (willIncreaseLineCount) {
            
            totalLines += 1;
            totalHeight += paragraphStyle.lineSpacing + font.lineHeight;
            
            lineWidth = 0;
            
            if (totalLines == expectedNumberOfLines) break;
            if (totalHeight > size.height) break;
        }
        
        // Update loop.
        lineWidth += subSize.width;
        stopIndex = NSMaxRange(result.range);
    }
    
    BOOL shouldAddTripleDots = stopIndex != self.length;
    if (shouldAddTripleDots) stopIndex = insertDotsIndex;
    NSMutableAttributedString *temp = [self attributedSubstringFromRange:NSMakeRange(0, stopIndex)].mutableCopy;
    
    if (actualNumberOfLines) *actualNumberOfLines = totalLines;
    [temp appendAttributedString: (shouldAddTripleDots ? tripleDots : NSAttributedString.new)];
    return temp.copy;
}

@end
