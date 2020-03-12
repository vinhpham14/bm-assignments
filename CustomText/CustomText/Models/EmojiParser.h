//
//  EmojiParser.h
//  CustomText
//
//  Created by LAP12230 on 3/9/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmojiParser : NSObject

- (NSAttributedString *)convertFromString:(NSAttributedString *)attStr;

- (NSAttributedString *)revertFromString:(NSAttributedString *)attStr;

@end

NS_ASSUME_NONNULL_END
