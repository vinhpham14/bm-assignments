//
//  EmojiItem.m
//  CustomText
//
//  Created by LAP12230 on 3/5/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

#import "EmojiItem.h"

@implementation EmojiItem

- (instancetype)initWithId:(NSString *)id code:(NSString *)code {
    self = [super init];
    if (self) {
        _id = id;
        _code = code;
    }
    
    return self;
}


- (BOOL)isEqual:(id)other
{
    if ([other isKindOfClass:self.class]) {
        EmojiItem *item = (EmojiItem *)other;
        return [self.code isEqual:item.code];
    }
    
    return false;
}


+ (NSArray<EmojiItem *> *)defaultEmojis {
    return @[
        [[EmojiItem alloc] initWithId:@"1"  code:@":D"],
        [[EmojiItem alloc] initWithId:@"2"  code:@"b-)"],
        [[EmojiItem alloc] initWithId:@"3"  code:@":')"],
        [[EmojiItem alloc] initWithId:@"4"  code:@":))"],
        [[EmojiItem alloc] initWithId:@"5"  code:@"8-)"],
        [[EmojiItem alloc] initWithId:@"6"  code:@":)"],
        [[EmojiItem alloc] initWithId:@"7"  code:@":B"],
        [[EmojiItem alloc] initWithId:@"8"  code:@":-*"],
        [[EmojiItem alloc] initWithId:@"9"  code:@":3"],
        [[EmojiItem alloc] initWithId:@"10" code:@";-d"],
        [[EmojiItem alloc] initWithId:@"11" code:@":P"],
        [[EmojiItem alloc] initWithId:@"12" code:@"X-P"],
        [[EmojiItem alloc] initWithId:@"13" code:@"8-P"],
        [[EmojiItem alloc] initWithId:@"14" code:@"X-|"],
        [[EmojiItem alloc] initWithId:@"15" code:@"X-)"],
        [[EmojiItem alloc] initWithId:@"16" code:@";0="],
        [[EmojiItem alloc] initWithId:@"17" code:@";("],
        [[EmojiItem alloc] initWithId:@"18" code:@":("],
        [[EmojiItem alloc] initWithId:@"19" code:@"XQ"],
        [[EmojiItem alloc] initWithId:@"20" code:@";Q"],
        [[EmojiItem alloc] initWithId:@"21" code:@":(("],
        [[EmojiItem alloc] initWithId:@"22" code:@":-(("],
        [[EmojiItem alloc] initWithId:@"23" code:@";-s"],
        [[EmojiItem alloc] initWithId:@"24" code:@":-h"],
        [[EmojiItem alloc] initWithId:@"25" code:@"8-0"],
        [[EmojiItem alloc] initWithId:@"26" code:@"8-|"],
        [[EmojiItem alloc] initWithId:@"27" code:@"8-a"],
        [[EmojiItem alloc] initWithId:@"28" code:@":-a"],
        [[EmojiItem alloc] initWithId:@"29" code:@":'P"],
        [[EmojiItem alloc] initWithId:@"30" code:@":'B"],
        [[EmojiItem alloc] initWithId:@"31" code:@"8-("],
        [[EmojiItem alloc] initWithId:@"32" code:@";-HUG"],
        [[EmojiItem alloc] initWithId:@"33" code:@";p"],
        [[EmojiItem alloc] initWithId:@"34" code:@";-h"],
        [[EmojiItem alloc] initWithId:@"35" code:@";|("],
        [[EmojiItem alloc] initWithId:@"36" code:@":|"],
        [[EmojiItem alloc] initWithId:@"37" code:@"8("],
        [[EmojiItem alloc] initWithId:@"38" code:@";-x"],
        [[EmojiItem alloc] initWithId:@"39" code:@":0"],
        [[EmojiItem alloc] initWithId:@"40" code:@":z"],
        [[EmojiItem alloc] initWithId:@"41" code:@":h"],
        [[EmojiItem alloc] initWithId:@"42" code:@":@"],
        [[EmojiItem alloc] initWithId:@"43" code:@":s"],
        [[EmojiItem alloc] initWithId:@"44" code:@";s"],
        [[EmojiItem alloc] initWithId:@"45" code:@":t"],
        [[EmojiItem alloc] initWithId:@"46" code:@"Xt"],
        [[EmojiItem alloc] initWithId:@"47" code:@";t"],
        [[EmojiItem alloc] initWithId:@"48" code:@":-t"],
        [[EmojiItem alloc] initWithId:@"49" code:@"$-)"],
        [[EmojiItem alloc] initWithId:@"50" code:@":d)"],
        [[EmojiItem alloc] initWithId:@"51" code:@"$x)"],
        [[EmojiItem alloc] initWithId:@"52" code:@"8oD"],
        [[EmojiItem alloc] initWithId:@"53" code:@"$xD"],
        [[EmojiItem alloc] initWithId:@"54" code:@"/-shit"],
        [[EmojiItem alloc] initWithId:@"55" code:@"/-ghost"],
        [[EmojiItem alloc] initWithId:@"56" code:@"/-kiss"],
        [[EmojiItem alloc] initWithId:@"57" code:@"/-lipstick"],
        [[EmojiItem alloc] initWithId:@"58" code:@"/-ring"],
        [[EmojiItem alloc] initWithId:@"59" code:@"/-rose"],
        [[EmojiItem alloc] initWithId:@"60" code:@"/-fade"],
        [[EmojiItem alloc] initWithId:@"61" code:@"/-banana"],
        [[EmojiItem alloc] initWithId:@"62" code:@"/-hamburger"],
        [[EmojiItem alloc] initWithId:@"63" code:@"/-eggplant"],
        [[EmojiItem alloc] initWithId:@"64" code:@"/-wine"],
        [[EmojiItem alloc] initWithId:@"65" code:@"/-popcorn"],
        [[EmojiItem alloc] initWithId:@"66" code:@"/-coffee"],
        [[EmojiItem alloc] initWithId:@"67" code:@"/-cake"],
        [[EmojiItem alloc] initWithId:@"68" code:@"/-beach"],
        [[EmojiItem alloc] initWithId:@"69" code:@"/-camp"],
        [[EmojiItem alloc] initWithId:@"70" code:@"/-hotel"],
        [[EmojiItem alloc] initWithId:@"71" code:@"/-moutain"],
        [[EmojiItem alloc] initWithId:@"72" code:@"/-fireworks"],
        [[EmojiItem alloc] initWithId:@"73" code:@"/-bomb"],
        [[EmojiItem alloc] initWithId:@"74" code:@"/-heart"],
        [[EmojiItem alloc] initWithId:@"75" code:@"/-break"],
        [[EmojiItem alloc] initWithId:@"76" code:@"/-light"],
        [[EmojiItem alloc] initWithId:@"77" code:@"/-strong"],
        [[EmojiItem alloc] initWithId:@"78" code:@"/-weak"],
        [[EmojiItem alloc] initWithId:@"79" code:@"/-ok"],
        [[EmojiItem alloc] initWithId:@"80" code:@"/-left"],
        [[EmojiItem alloc] initWithId:@"81" code:@"/-right"],
        [[EmojiItem alloc] initWithId:@"82" code:@"/-luck"],
        [[EmojiItem alloc] initWithId:@"83" code:@"/-vic"],
        [[EmojiItem alloc] initWithId:@"84" code:@"/-punch"],
        [[EmojiItem alloc] initWithId:@"85" code:@"/-up"],
        [[EmojiItem alloc] initWithId:@"86" code:@"/-loveu"],
        [[EmojiItem alloc] initWithId:@"87" code:@"/-middle"],
        [[EmojiItem alloc] initWithId:@"88" code:@"/-pray"],
    ];
}

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
