//
//  FirstViewController.h
//  UIAutomationExample
//
//  Created by Adam Siton on 12/26/11.
//  Copyright (c) 2011 Any.do. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipableView.h"

@interface FirstViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, SwipableViewDelegate> {
    IBOutlet UITextField *emailTextField;
    IBOutlet UIButton *addButton;
    IBOutlet UIButton *clearButton;
    IBOutlet UITableView *emailsTableView;
    
    NSMutableArray *emails;
}

-(IBAction)addButtonClicked:(id)sender;
-(IBAction)clearButtonClicked:(id)sender;

@end
