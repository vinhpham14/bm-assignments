//
//  ViewController.m
//  SemanticLabel
//
//  Created by LAP12230 on 3/15/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "ViewController.h"
#import "SemanticLabel.h"
#import "NSAttributedString+FullWordTruncated.h"
#import "PaddingLabel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet SemanticLabel *label;
@property (weak, nonatomic) IBOutlet UILabel *normalLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet PaddingLabel *paddingLabel;
@property (weak, nonatomic) IBOutlet UILabel *sampleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.numberOfLines = 20;
    self.label.lineBreakMode = NSLineBreakByTruncatingTail;
    self.label.enabledWordTruncated = true;
    self.label.textColor = UIColor.greenColor;
    self.label.text = @"longtext longtext\nlongtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext longtext ";
    
    
    // ============
    self.paddingLabel.textInsets = UIEdgeInsetsMake(10, 10, 10, 20);
    self.paddingLabel.numberOfLines = 0;
    self.paddingLabel.text = @"text";
    // [self.paddingLabel sizeToFit];
    
    self.sampleLabel.numberOfLines = 0;
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}


- (IBAction)buttonPrint:(id)sender {
    // NSAttributedString *newString = [[NSAttributedString alloc] initWithString:@"asdf"];
    // NSLog(@"%@", newString);
    // [newString stringThatFit:CGSizeMake(40, 50) expectedNumberOfLines:4 actualNumberOfLines:nil];
    // self.paddingLabel.textInsets = UIEdgeInsetsMake(50, 10, 10, 20);
    [self.paddingLabel sizeToFit];
}


- (IBAction)buttonChangeText:(id)sender {
    self.label.text = self.textField.text;
    self.normalLabel.text = self.textField.text;
    self.paddingLabel.text = self.textField.text;
    self.sampleLabel.text= self.textField.text;
}

- (IBAction)didTapChangeFrameButton:(id)sender {
    
    CGSize newSize = CGSizeMake(100, 21);
    CGRect newFrame = self.label.frame;
    newFrame.size = newSize;
    
    self.label.frame = newFrame;
}

@end
