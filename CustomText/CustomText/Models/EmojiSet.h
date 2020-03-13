//
//  EmojiSet.h
//  CustomText
//
//  Created by LAP12230 on 3/13/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmojiSet : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * regexPattern;
@property (nonatomic, strong) NSDictionary * emojiDictionary;

- initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary regexPattern:(NSString *)pattern;

@end

NS_ASSUME_NONNULL_END
