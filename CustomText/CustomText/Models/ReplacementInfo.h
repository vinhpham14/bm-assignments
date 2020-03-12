//
//  ReplacementInfo.h
//  CustomText
//
//  Created by LAP12230 on 3/9/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReplacementInfo : NSObject

@property (nonatomic, strong) NSAttributedString *beforeString;
@property (nonatomic, strong) NSAttributedString *afterString;
@property (nonatomic, assign) NSRange range;

@end

NS_ASSUME_NONNULL_END
