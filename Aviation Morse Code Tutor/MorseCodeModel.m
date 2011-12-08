//
//  MorseCodeModel.m
//  Aviation Morse Code Tutor
//
//  Created by Jonathan Anderson on 12/8/11.
//  Copyright (c) 2011 WOMA LLC. All rights reserved.
//

#import "MorseCodeModel.h"

NSDictionary *textToMorse;
NSDictionary *morseToText;

@interface MorseCodeModel()
@property (nonatomic, strong) NSString *morse;
@property (nonatomic, strong) NSDate *tapBegTime;
@property (nonatomic, strong) NSDate *tapEndTime;
@property (nonatomic) double ditThreshold;
@property (nonatomic) double dahThreshold;
@end

@implementation MorseCodeModel

@synthesize morse = _morse;
@synthesize tapBegTime = _tapBegTime;
@synthesize tapEndTime = _tapEndTime;
@synthesize ditThreshold = _ditThreshold;
@synthesize dahThreshold = _dahThreshold;

+ (void)initialize {
    if (!morseToText) {
        morseToText = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"1", @".----",
                       @"2", @"..---",
                       @"3", @"...--",
                       @"4", @"....-",
                       @"5", @".....",
                       @"6", @"-....",
                       @"7", @"--...",
                       @"8", @"---..",
                       @"9", @"----.",
                       @"0", @"-----",
                       @"A", @".-",
                       @"B", @"-...",
                       @"C", @"-.-.",
                       @"D", @"-..",
                       @"E", @".",
                       @"F", @"..-.",
                       @"G", @"--.",
                       @"H", @"....",
                       @"I", @"..",
                       @"J", @".---",
                       @"K", @"-.-",
                       @"L", @".-..",
                       @"M", @"--",
                       @"N", @"-.",
                       @"O", @"---",
                       @"P", @".--.",
                       @"Q", @"--.-",
                       @"R", @".-.",
                       @"S", @"...",
                       @"T", @"-",
                       @"U", @"..-",
                       @"V", @"...-",
                       @"W", @".--",
                       @"X", @"-..-",
                       @"Y", @"-.--",
                       @"Z", @"--..",
                       nil];
    }
    if (!textToMorse) {
        textToMorse = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @".----", @"1",
                       @"..---", @"2",
                       @"...--", @"3",
                       @"....-", @"4",
                       @".....", @"5",
                       @"-....", @"6",
                       @"--...", @"7",
                       @"---..", @"8",
                       @"----.", @"9",
                       @"-----", @"0",
                       @".-"   , @"A",
                       @"-..." , @"B",
                       @"-.-." , @"C",
                       @"-.."  , @"D",
                       @"."    , @"E",
                       @"..-." , @"F",
                       @"--."  , @"G",
                       @"...." , @"H",
                       @".."   , @"I",
                       @".---" , @"J",
                       @"-.-"  , @"K",
                       @".-.." , @"L",
                       @"--"   , @"M",
                       @"-."   , @"N",
                       @"---"  , @"O",
                       @".--." , @"P",
                       @"--.-" , @"Q",
                       @".-."  , @"R",
                       @"..."  , @"S",
                       @"-"    , @"T",
                       @"..-"  , @"U",
                       @"...-" , @"V",
                       @".--"  , @"W",
                       @"-..-" , @"X",
                       @"-.--" , @"Y",
                       @"--.." , @"Z",
                       nil];
    }
}

+ (NSString *)textToMorse:(NSString *)text {
    NSString *result = @"";
    NSRange range;
    range.length = 1;
    range.location = 0;
    for (int i=0; i<[text length]; i++) {
        range.location = i;
        NSString *nextChar = [text substringWithRange:range];
        NSString *morseLetter = [textToMorse objectForKey:nextChar];
        if ([result length])
            result = [result stringByAppendingString:@" "];
        result = [result stringByAppendingString:morseLetter];
    }
    return result;
}
+ (NSString *)morseToText:(NSString *)morse {
    
    NSString *result = @"";
    NSString *morseLetter = @"";
    
    NSRange range;
    range.length = 1;
    range.location = 0;
    
    for (int i=0; i<[morse length]; i++) {
        range.location = i;
        NSString *nextChar = [morse substringWithRange:range];
        if ([nextChar isEqualToString:@"."] || [nextChar isEqualToString:@"-"]) {
            morseLetter = [morseLetter stringByAppendingString:nextChar];
        } else if ([nextChar isEqualToString:@" "]) {
            NSString *textLetter = [morseToText objectForKey:morseLetter];
            if (!textLetter) textLetter = @"?";
            result = [result stringByAppendingString:textLetter];
            morseLetter = @"";
        } else {
            NSLog(@"nextChar = >%@<",nextChar);
            morseLetter = @"";
        }
    }
    if ([morseLetter length]) {
        NSString *textLetter = [morseToText objectForKey:morseLetter];
        if (!textLetter) textLetter = @"?";
        result = [result stringByAppendingString:textLetter];
    }
    return result;
}

- (NSString *)morse {
    if (!_morse) _morse = [[NSString alloc] init];
    return _morse;
}
- (double)ditThreshold {
    if (!_ditThreshold) _ditThreshold = 0.20;
    return  _ditThreshold;
}
- (double)dahThreshold {
    if (!_dahThreshold) _dahThreshold = 0.50;
    return  _dahThreshold;
}
- (void)reset {
    self.morse = nil;
    self.tapBegTime = nil;
    self.tapEndTime = nil;
}
- (void)tapStart {
    self.tapBegTime = [NSDate date];
    NSTimeInterval timeSinceLastTap;
    
    if (self.tapEndTime) {
        timeSinceLastTap = [self.tapBegTime timeIntervalSinceDate:self.tapEndTime];
        if (timeSinceLastTap > self.dahThreshold)
            self.morse = [self.morse stringByAppendingString:@" "];
    }
}
- (void)tapEnd {
    self.tapEndTime = [NSDate date];
    NSTimeInterval timeSinceLastTap = [self.tapEndTime timeIntervalSinceDate:self.tapBegTime];
    if (timeSinceLastTap < self.ditThreshold) {
        self.morse = [self.morse stringByAppendingString:@"."];
    } else {
        self.morse = [self.morse stringByAppendingString:@"-"];
    }
    NSLog(@"TapInterval = %g (%@)",timeSinceLastTap,self.morse);
}
- (NSString *)displayMorse {
    return self.morse;
}
- (NSString *)displayText {
    return [MorseCodeModel morseToText:self.morse];
}

@end
