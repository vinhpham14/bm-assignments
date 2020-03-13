//
//  EmojiAttachment.m
//  CustomText
//
//  Created by LAP12230 on 3/9/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "EmojiAttachment.h"

@implementation EmojiAttachment

#pragma mark - Initializtions


- (instancetype)initWithCode:(NSString *)code image:(UIImage *)image {
    self = [super init];
    
    if (self) {
        _rawString = code;
        self.image = image;
    }
    
    return self;
}


#pragma mark - Convenience Init

+ (instancetype)attachmentWithCode:(NSString *)code image:(UIImage *)image {
    return [[self alloc] initWithCode:code image:image];
}


#pragma mark - Public Methods

- (void)alignEmojiWithAttributes:(NSDictionary *)attributes {
    UIFont *font = attributes[NSFontAttributeName];
    if (font) {
        CGFloat topPadding = (font.lineHeight - font.capHeight) / 2;
        self.bounds = CGRectMake(0, -topPadding, font.lineHeight, font.lineHeight);
    }
}


@end
