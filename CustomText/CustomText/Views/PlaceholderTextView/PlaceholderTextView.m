//
//  CustomTextView.m
//  CustomText
//
//  Created by LAP12230 on 3/3/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "PlaceholderTextView.h"

@interface PlaceholderTextView ()

@property (nonatomic, strong) UITextView *placeholderTextView;

@end


@implementation PlaceholderTextView

#pragma mark - CUSTOM SETTERS, GETTERS

- (UITextView *)placeholderTextView {
    
    if (!_placeholderTextView) {
        _placeholderTextView = UITextView.new;
        _placeholderTextView.backgroundColor = UIColor.clearColor;
        _placeholderTextView.userInteractionEnabled = false;
        _placeholderTextView.font = self.font;
    }
    
    return _placeholderTextView;
}


- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeholderTextView.text = self.placeholder;
}


- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    _attributedPlaceholder = attributedPlaceholder;
    self.placeholderTextView.attributedText = self.attributedPlaceholder;
}


- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    self.placeholderTextView.font = self.placeholderFont;
}


- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.placeholderTextView.textColor = self.placeholderColor;
}


#pragma mark - OVERRIDED METHODS

- (void)setText:(NSString *)text {
    [super setText:text];
    
    if (self.text.length > 0) {
        self.placeholderTextView.hidden = true;
    } else {
        self.placeholderTextView.hidden = false;
    }
}


- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    self.placeholderTextView.textAlignment = self.textAlignment;
}


- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderTextView.font = font;
}


- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    [super setTextContainerInset:textContainerInset];
    self.placeholderTextView.textContainerInset = self.textContainerInset;
}


#pragma mark - LIFE CYCLES

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self internalInit];
    }
    
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self internalInit];
    }
    
    return self;
}


- (void)internalInit {
    [self addSubview:self.placeholderTextView];
    [self setupObservers];
}


- (void)setupObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewDidChangeValueHandler:)
                                                 name:UITextViewTextDidChangeNotification object:nil];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.placeholderTextView.frame = self.bounds;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - KVO

- (void)textViewDidChangeValueHandler:(NSNotification *)notification {
    if (notification.object == self) {
        if (self.text.length > 0) {
            self.placeholderTextView.hidden = true;
        } else {
            self.placeholderTextView.hidden = false;
        }
    }
}


@end

