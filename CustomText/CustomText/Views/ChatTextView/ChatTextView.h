//
//  ChatTextView.h
//  CustomText
//
//  Created by LAP12230 on 3/9/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaceholderTextView.h"
#import "EmojiParser.h"
#import "EmojiAttachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatTextView : PlaceholderTextView

- (void)addEmojiSet:(EmojiSet *)emojiSet;
- (void)setEmojiSetIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
