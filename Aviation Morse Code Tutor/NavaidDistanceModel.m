//
//  NavaidDistanceModel.m
//  Aviation Morse Code Tutor
//
//  Created by Jonathan Anderson on 12/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NavaidDistanceModel.h"
#import <CoreLocation/CoreLocation.h>

@interface NavaidDistanceModel()
@property (nonatomic, strong) CLLocation *myLocation;
@end


@implementation NavaidDistanceModel
@synthesize myLocation = _myLocation;
- (CLLocation *)myLocation {
    if (!_myLocation) _myLocation = [[CLLocation alloc] initWithLatitude:37.7858 longitude:-122.4064];
    return _myLocation;
}
@end
