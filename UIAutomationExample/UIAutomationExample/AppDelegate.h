//
//  AppDelegate.h
//  UIAutomationExample
//
//  Created by Adam Siton on 12/26/11.
//  Copyright (c) 2011 Any.do. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
