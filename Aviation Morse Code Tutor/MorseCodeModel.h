//
//  MorseCodeModel.h
//  Aviation Morse Code Tutor
//
//  Created by Jonathan Anderson on 12/8/11.
//  Copyright (c) 2011 WOMA LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MorseCodeModel : NSObject

+ (NSString *)textToMorse:(NSString *)text;
+ (NSString *)morseToText:(NSString *)morse;

- (NSString *)displayMorse;
- (NSString *)displayText;
- (void)tapStart;
- (void)tapEnd;
- (void)reset;


@end
