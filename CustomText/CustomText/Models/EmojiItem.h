//
//  EmojiItem.h
//  CustomText
//
//  Created by LAP12230 on 3/5/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmojiItem : NSObject

@property (nonatomic, readonly) NSString *id;
@property (nonatomic, readonly) NSString *code;

- (instancetype)initWithId:(NSString *)id code:(NSString *)code;

+ (NSArray<EmojiItem *> *)defaultEmojis;

@end

NS_ASSUME_NONNULL_END
