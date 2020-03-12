//
//  EmojiParser.m
//  CustomText
//
//  Created by LAP12230 on 3/9/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "EmojiParser.h"
#import "EmojiAttachment.h"
#import "ReplacementInfo.h"

@implementation EmojiParser

#pragma mark - Public Methods

- (NSAttributedString *)convertFromString:(NSAttributedString *)attStr {
    
    if (attStr.length == 0) return nil;
    
    NSDictionary *attributes = [attStr attributesAtIndex:0 effectiveRange:nil];
    
    NSAttributedString *attStrWithoutEmoji = [self revertFromString:attStr];
    
    // NSArray *words = [attStrWithoutEmoji.string componentsSeparatedByCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    
    NSArray *words = [self substringsCanBeAnEmoticonInString:attStr.string];
    
    NSMutableArray<ReplacementInfo *> *replacements = NSMutableArray.new;
    
    // Find and cache emoji
    for (NSString *word in words) {
        
        EmojiAttachment *attachment = [[EmojiAttachment alloc] initWithEmojiCode:word];
        [attachment alignEmojiWithAttributes:attributes];
        
        if (!attachment) continue;
        
        ReplacementInfo *info = ReplacementInfo.new;
        NSAttributedString *emoji = [self attributedStringFromAttachment:attachment currentAttributes:attributes];
        
        info.beforeString = [[NSAttributedString alloc] initWithString:word];
        info.afterString = emoji;
        
        [replacements addObject:info];
    }
    
    // Replacing
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithAttributedString:attStrWithoutEmoji];
    for (ReplacementInfo *info in replacements) {
        
        NSRange wordRange = [result.string rangeOfString:info.beforeString.string
                                                 options:NSLiteralSearch];
        
        if (wordRange.length != 0) {
            [result replaceCharactersInRange:wordRange withAttributedString:info.afterString];
        }
    }
    
    return result;
}


- (NSAttributedString *)revertFromString:(NSAttributedString *)attStr {
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithAttributedString:attStr];
    
    [result enumerateAttribute:NSAttachmentAttributeName
                       inRange:NSMakeRange(0, attStr.length - 1)
                       options:0
                    usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        
        if ([value isKindOfClass:EmojiAttachment.class]) {
            EmojiAttachment *emoji = (EmojiAttachment *)value;
            [result replaceCharactersInRange:range withString:emoji.rawString];
            [result removeAttribute:NSAttachmentAttributeName range:range];
        }
        
    }];
    
    return result;
}


#pragma mark - Private Methods

- (NSAttributedString *)attributedStringFromAttachment:(NSTextAttachment *)attachment currentAttributes:(NSDictionary *)attrs {
    
    NSMutableDictionary *newAttrs = [NSMutableDictionary dictionaryWithDictionary:attrs];
    
    [newAttrs removeObjectForKey:NSAttachmentAttributeName];
     
    newAttrs[NSAttachmentAttributeName] = attachment;
    newAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:30];
    
    unichar c = NSAttachmentCharacter;
    NSString *replacementStr = [NSString stringWithCharacters:&c length:1];
    
    return [[NSAttributedString alloc] initWithString:replacementStr attributes:newAttrs];
}


- (NSArray *)substringsCanBeAnEmoticonInString:(NSString *)str {
    
    NSString *pattern = @"([:;8bX$][03aozxsdhptBPDQHUG'@><*\\(\\)\\=|]+)|(\\-[a-z]+)";
    NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                    options:NSRegularExpressionAllowCommentsAndWhitespace
                                                                      error:nil];
    
    NSMutableArray *stringArr = NSMutableArray.new;
    
    NSArray *matches = [reg matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    for (NSTextCheckingResult *result in matches) {
        NSString *matchedStr = [str substringWithRange:result.range];
        [stringArr addObject:matchedStr];
    }
    
    return stringArr;
}

@end
