//
//  ViewController.m
//  SemanticLabel
//
//  Created by LAP12230 on 3/15/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "ViewController.h"
#import "SemanticLabel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet SemanticLabel *label;
@property (weak, nonatomic) IBOutlet UILabel *normalLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.numberOfLines = 1;
    self.label.lineBreakMode = NSLineBreakByTruncatingTail;
    self.label.enabledWordTruncated = true;
    self.label.textColor = UIColor.greenColor;
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}


- (IBAction)buttonPrint:(id)sender {
    NSLog(@"print: %@", self.label.attributedText);
    NSLog(@"print green color: %@", UIColor.greenColor);
    [self.label setNeedsLayout];
    [self.label layoutIfNeeded];
}


- (IBAction)buttonChangeText:(id)sender {
    self.label.text = self.textField.text;
    self.normalLabel.text = self.textField.text;
}

- (IBAction)didTapChangeFrameButton:(id)sender {
    
    CGSize newSize = CGSizeMake(100, 21);
    CGRect newFrame = self.label.frame;
    newFrame.size = newSize;
    
    self.label.frame = newFrame;
}

@end
