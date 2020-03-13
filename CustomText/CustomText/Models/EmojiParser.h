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

@protocol EmojiParserDataSource;

@interface EmojiParser : NSObject

@property (nonatomic, weak) id<EmojiParserDataSource> dataSource;


#pragma mark - Revert

- (NSAttributedString *)revertFromEmoji:(NSAttributedString *)attStr;
- (NSAttributedString *)revertFromEmoji:(NSAttributedString *)attStr locationCursorInString:(NSInteger *)locationCursor;


#pragma mark - Convert

- (NSAttributedString *)convertToEmoji:(NSAttributedString *)attStr;
- (NSAttributedString *)convertToEmoji:(NSAttributedString *)attStr locationCursorInWord:(NSInteger *)locationCursor;


#pragma mark - DataSource

- (void)reloadParsingDataSource;

@end


@protocol EmojiParserDataSource <NSObject>

@required

- (NSInteger)numberOfEmojiSetsInParser:(EmojiParser *)parser;

- (BOOL)emojiParser:(EmojiParser *)parser shouldIncludeEmojiSetAtIndex:(NSInteger)index;

- (EmojiSet *)emojiParser:(EmojiParser *)parser emojiSetForIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
