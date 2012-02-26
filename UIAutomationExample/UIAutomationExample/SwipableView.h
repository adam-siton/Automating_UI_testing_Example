//
//  SwipableView.h
//  UIAutomationExample
//
//  Created by Adam Siton on 1/30/12.
//  Copyright (c) 2012 Any.do. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SwipableViewDelegate <NSObject>

-(void) didSwipeAtLocation:(CGPoint)location;

@end

@interface SwipableView : UIView

@property (nonatomic, assign) NSObject<SwipableViewDelegate> *swipableDelegate;

@end
