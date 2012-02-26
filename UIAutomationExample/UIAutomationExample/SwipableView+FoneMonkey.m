//
//  SwipableView+FoneMonkey.m
//  UIAutomationExample
//
//  Created by Adam Siton on 1/30/12.
//  Copyright (c) 2012 Any.do. All rights reserved.
//

#import "SwipableView+FoneMonkey.h"
#import "FoneMonkeyAPI.h"

@implementation SwipableView (FoneMonkey)

- (void) playbackMonkeyEvent:(FMCommandEvent*)event
{
    if ([event.command isEqualToString:@"swipe"])
    {
        float x = [[event.args objectAtIndex:0] floatValue];
        float y = [[event.args objectAtIndex:1] floatValue];
        CGPoint location = CGPointMake(x, y);
        [self.swipableDelegate didSwipeAtLocation:location];
    }
    else {
        [super playbackMonkeyEvent:event];
    }
}

@end
