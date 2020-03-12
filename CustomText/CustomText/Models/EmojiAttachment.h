//
//  EmojiAttachment.h
//  CustomText
//
//  Created by LAP12230 on 3/9/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmojiAttachment : NSTextAttachment

@property (nonatomic, strong) NSString *rawString;

- (instancetype)initWithEmojiCode:(NSString *)code;

- (void)alignEmojiWithAttributes:(NSDictionary *)attributes;

@end

NS_ASSUME_NONNULL_END
