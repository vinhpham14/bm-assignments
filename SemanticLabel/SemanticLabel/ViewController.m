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
    self.label.fullWordTruncated = true;
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // NSLog(@"");
}


- (IBAction)buttonPrint:(id)sender {
    // NSLog(@"label self.text: %@", self.label.text);
}


- (IBAction)buttonChangeText:(id)sender {
    self.label.text = self.textField.text;
    self.normalLabel.text = self.textField.text;
}

@end
