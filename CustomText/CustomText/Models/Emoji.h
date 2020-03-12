//
//  Emoji.h
//  CustomText
//
//  Created by LAP12230 on 3/9/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Emoji : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSAttributedString *attributedString;

- (instancetype)initWithCode:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
