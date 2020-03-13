//
//  EmojiSet.m
//  CustomText
//
//  Created by LAP12230 on 3/13/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "EmojiSet.h"

@implementation EmojiSet

- (id)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary regexPattern:(NSString *)pattern {
    self = [super self];
    if (self) {
        _name = name;
        _emojiDictionary = dictionary;
        _regexPattern = pattern;
    }
    
    return self;
}

@end
