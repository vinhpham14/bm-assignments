//
//  Emoji.m
//  CustomText
//
//  Created by LAP12230 on 3/9/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "Emoji.h"

@implementation Emoji

#pragma mark - Initilizations

- (instancetype)initWithCode:(NSString *)code {
    self = [super init];
    if (self) {
        NSString *imageName = [self.class emojiDictionary][code];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            _image = image;
            _code = code;
            _attributedString = [self emojiAttributedStringWithCode:code image:image];
        } else return nil;
    }
    
    return self;
}


#pragma mark - Private Methods

- (NSAttributedString *)emojiAttributedStringWithCode:(NSString *)code image:(UIImage *)image {
    
    unichar c = NSAttachmentCharacter;
    NSString *replacement = [NSString stringWithCharacters:&c length:code.length];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    
    NSDictionary *attrs = @{ NSAttachmentAttributeName: attachment };
    
    return [[NSAttributedString alloc] initWithString:replacement attributes:attrs];
}


#pragma mark - Class Methods

+ (NSDictionary<NSString *, NSString *> *)emojiDictionary {
    return @{
        @":D": @"1",
        @"b-)": @"2",
        @":')": @"3",
        @":))": @"4",
        @"8-)": @"5",
        @":)": @"6",
        @":B": @"7",
        @":-*": @"8",
        @":3": @"9",
        @";-d": @"10",
        @":P": @"11",
        @"X-P": @"12",
        @"8-P": @"13",
        @"X-|": @"14",
        @"X-)": @"15",
        @";0=": @"16",
        @";(": @"17",
        @":(": @"18",
        @"XQ": @"19",
        @";Q": @"20",
        @":((": @"21",
        @":-((": @"22",
        @";-s": @"23",
        @":-h": @"24",
        @"8-0": @"25",
        @"8-|": @"26",
        @"8-a": @"27",
        @":-a": @"28",
        @":'P": @"29",
        @":'B": @"30",
        @"8-(": @"31",
        @";-HUG": @"32",
        @";p": @"33",
        @";-h": @"34",
        @";|(": @"35",
        @":|": @"36",
        @"8(": @"37",
        @";-x": @"38",
        @":0": @"39",
        @":z": @"40",
        @":h": @"41",
        @":@": @"42",
        @":s": @"43",
        @";s": @"44",
        @":t": @"45",
        @"Xt": @"46",
        @";t": @"47",
        @":-t": @"48",
        @"$-)": @"49",
        @":d)": @"50",
        @"$x)": @"51",
        @"8oD": @"52",
        @"$xD": @"53",
        @"/-shit": @"54",
        @"/-ghost": @"55",
        @"/-kiss": @"56",
        @"/-lipsti": @"57",
        @"/-ring": @"58",
        @"/-rose": @"59",
        @"/-fade": @"60",
        @"/-banana": @"61",
        @"/-hambur": @"62",
        @"/-eggpla": @"63",
        @"/-wine": @"64",
        @"/-popcor": @"65",
        @"/-coffee": @"66",
        @"/-cake": @"67",
        @"/-beach": @"68",
        @"/-camp": @"69",
        @"/-hotel": @"70",
        @"/-moutai": @"71",
        @"/-firewo": @"72",
        @"/-bomb": @"73",
        @"/-heart": @"74",
        @"/-break": @"75",
        @"/-light": @"76",
        @"/-strong": @"77",
        @"/-weak": @"78",
        @"/-ok": @"79",
        @"/-left": @"80",
        @"/-right": @"81",
        @"/-luck": @"82",
        @"/-vic": @"83",
        @"/-punch": @"84",
        @"/-up": @"85",
        @"/-loveu": @"86",
        @"/-middle": @"87",
        @"/-pray": @"88",
    };
}

@end
