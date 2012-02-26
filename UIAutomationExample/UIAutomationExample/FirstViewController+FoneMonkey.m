//
//  FirstViewController+FoneMonkey.m
//  UIAutomationExample
//
//  Created by Adam Siton on 1/30/12.
//  Copyright (c) 2012 Any.do. All rights reserved.
//

#import "FirstViewController+FoneMonkey.h"
#import <objc/runtime.h>
#import "FoneMonkeyAPI.h"

@implementation FirstViewController (FoneMonkey)

+(void) load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(handleSwipeAtLocation:));
    Method replacedMethod = class_getInstanceMethod(self, @selector(fm_handleSwipeAtLocation:));	
    method_exchangeImplementations(originalMethod, replacedMethod);	
}

- (void) fm_handleSwipeAtLocation:(CGPoint)location
{
    [self fm_handleSwipeAtLocation:location];
    [FoneMonkeyAPI record:self.view command:@"swipe" args:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f",location.x], [NSString stringWithFormat:@"%f",location.y], nil]];
}

@end
