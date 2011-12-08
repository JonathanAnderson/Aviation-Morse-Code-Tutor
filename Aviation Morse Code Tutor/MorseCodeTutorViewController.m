//
//  MorseCodeTutorViewController.m
//  Aviation Morse Code Tutor
//
//  Created by Jonathan Anderson on 12/8/11.
//  Copyright (c) 2011 WOMA LLC. All rights reserved.
//

#import "MorseCodeTutorViewController.h"
#import "MorseCodeModel.h"

@interface MorseCodeTutorViewController()
@property (nonatomic, strong) MorseCodeModel *morseCodeModel;
@end

@implementation MorseCodeTutorViewController

@synthesize morseCodeModel = _morseCodeModel;
- (MorseCodeModel *)morseCodeModel {
    if (!_morseCodeModel) _morseCodeModel = [[MorseCodeModel alloc] init];
    return _morseCodeModel;
}

@end
