//
//  MorseCodeTutorViewController.m
//  Aviation Morse Code Tutor
//
//  Created by Jonathan Anderson on 12/8/11.
//  Copyright (c) 2011 WOMA LLC. All rights reserved.
//

#import "MorseCodeTutorViewController.h"
#import "MorseCodeModel.h"
#import "MorseCodePlayer.h"

@interface MorseCodeTutorViewController()
@property (nonatomic, strong) MorseCodeModel *morseCodeModel;
@property (nonatomic, strong) MorseCodePlayer *morseCodePlayer;
@end

@implementation MorseCodeTutorViewController
@synthesize text = _text;
@synthesize code = _code;

@synthesize morseCodeModel = _morseCodeModel;
@synthesize morseCodePlayer = _morseCodePlayer;
- (MorseCodeModel *)morseCodeModel {
    if (!_morseCodeModel) _morseCodeModel = [[MorseCodeModel alloc] init];
    return _morseCodeModel;
}
- (MorseCodePlayer *)morseCodePlayer {
    if (!_morseCodePlayer) _morseCodePlayer = [[MorseCodePlayer alloc] init];
    return _morseCodePlayer;
}

- (IBAction)tapStart {
    [self.morseCodeModel tapStart];
}
- (IBAction)tapEnd {
    [self.morseCodeModel tapEnd];
    self.text.text = [self.morseCodeModel displayText];
    self.code.text = [self.morseCodeModel displayMorse];
}
- (IBAction)play {
    NSString *morse = [self.morseCodeModel displayMorse];
    if (morse && [morse length])
        [self.morseCodePlayer playMorse:morse];    
}
- (IBAction)reset {
    [self.morseCodeModel reset];
    [self.morseCodePlayer reset];
    self.text.text = @"";
    self.code.text = @"";
}

@end
