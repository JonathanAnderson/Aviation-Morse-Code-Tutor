//
//  MorseCodePlayer.h
//  Aviation Morse Code Tutor
//
//  Created by Jonathan Anderson on 12/8/11.
//  Copyright (c) 2011 WOMA LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MorseCodePlayer : NSObject
- (void)playMorse:(NSString *)morse;
- (void)reset;
@end
