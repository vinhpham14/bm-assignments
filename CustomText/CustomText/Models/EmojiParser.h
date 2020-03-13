//
//  EmojiParser.h
//  CustomText
//
//  Created by LAP12230 on 3/13/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "EmojiSet.h"
#import "EmojiAttachment.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmojiParser : NSObject

@property (nonatomic, strong) NSMutableArray<EmojiSet *> *emojiSets;

@property (nonatomic, readonly) EmojiSet *currentEmojiSet;
@property (nonatomic, readonly) NSString *currentSetName;
@property (nonatomic, assign) NSUInteger currentEmojiIndex;


#pragma mark - Convert

- (NSAttributedString *)revertFromEmoji:(NSAttributedString *)attStr;
- (NSAttributedString *)revertFromEmoji:(NSAttributedString *)attStr locationCursorInString:(NSInteger *)locationCursor;


#pragma mark - Revert

- (NSAttributedString *)convertToEmoji:(NSAttributedString *)attStr;
- (NSAttributedString *)convertToEmoji:(NSAttributedString *)attStr locationCursorInWord:(NSInteger *)locationCursor;


@end

NS_ASSUME_NONNULL_END

