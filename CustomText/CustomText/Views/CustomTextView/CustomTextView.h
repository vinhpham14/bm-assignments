//
//  CustomTextView.h
//  CustomText
//
//  Created by LAP12230 on 3/3/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTextView : UITextView <UITextViewDelegate>

#pragma mark - Placeholder
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIFont *placeholderFont;


#pragma mark - Internal init
- (void)internalInit;


#pragma mark - KVO
- (void)textViewDidChangeValueHandler:(NSNotification *)notification;

@end

NS_ASSUME_NONNULL_END

