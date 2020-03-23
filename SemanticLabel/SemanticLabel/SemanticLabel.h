//
//  SemanticLabel.h
//  SemanticLabel
//
//  Created by LAP12230 on 3/15/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface SemanticLabel : UILabel

@property (nonatomic, assign, getter=isEnabledWordTruncated) BOOL enabledWordTruncated;

@end

NS_ASSUME_NONNULL_END
