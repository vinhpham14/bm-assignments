//
//  ViewController.m
//  CustomText
//
//  Created by LAP12230 on 3/3/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "ViewController.h"
#import "ChatTextView.h"
#import <UIKit/UIKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ChatTextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.placeholder = @"Placeholder";
    self.textView.placeholderColor = UIColor.lightGrayColor;
    self.textView.font = [UIFont systemFontOfSize:30];
}


@end

