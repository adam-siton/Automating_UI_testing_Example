//
//  FirstViewController.m
//  UIAutomationExample
//
//  Created by Adam Siton on 12/26/11.
//  Copyright (c) 2011 Any.do. All rights reserved.
//

#import "FirstViewController.h"

#pragma mark -
#pragma mark Private Declarations

@interface FirstViewController (Private)

-(void) handleSwipeAtLocation:(CGPoint)location;

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Email", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    emails = [[NSMutableArray alloc] init];
    
    ((SwipableView *)self.view).swipableDelegate = self;
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    //[emailsTableView addGestureRecognizer:swipeRecognizer];
    [self.view addGestureRecognizer:swipeRecognizer];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark -
#pragma mark Actions

-(IBAction)addButtonClicked:(id)sender
{
    if (emailTextField.text.length > 0) {
        // Insert the email at the begining of the array to display it first
        [emails insertObject:emailTextField.text atIndex:0];
        emailTextField.text = nil;
        [emailTextField resignFirstResponder];
        [emailsTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }
}

-(IBAction)clearButtonClicked:(id)sender
{
    [emails removeAllObjects];
    [emailsTableView reloadData];
}

#pragma mark -
#pragma mark Gestures

/*
-(void) swipeRecognized:(UISwipeGestureRecognizer *)swipeGesture
{
    CGPoint location = [swipeGesture locationInView:emailsTableView];
    NSIndexPath *swipedIndex = [emailsTableView indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell = [emailsTableView cellForRowAtIndexPath:swipedIndex];
    NSString *swipedEmail = [emails objectAtIndex:swipedIndex.row];
    
    // Animate swiping the cell and after completion - remove it.
    UIView *swipeLine = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMidY(swipedCell.bounds), 0, 1)];
    swipeLine.backgroundColor = [UIColor lightGrayColor];
    [swipedCell addSubview:swipeLine];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect newRect = swipeLine.frame;
        newRect.size.width = CGRectGetMaxX(swipedCell.bounds) - 20;
        swipeLine.frame = newRect;
    }completion:^(BOOL finished) {
        [swipeLine removeFromSuperview];
        [emails removeObject:swipedEmail];
        [emailsTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:swipedIndex] withRowAnimation:UITableViewRowAnimationBottom];
    }];
}
*/



-(void) swipeRecognized:(UISwipeGestureRecognizer *)swipeGesture
{
    CGPoint location = [swipeGesture locationInView:emailsTableView];
    [self handleSwipeAtLocation:location];
}

-(void) handleSwipeAtLocation:(CGPoint)location
{
    NSIndexPath *swipedIndex = [emailsTableView indexPathForRowAtPoint:location];
    UITableViewCell *swipedCell = [emailsTableView cellForRowAtIndexPath:swipedIndex];
    NSString *swipedEmail = [emails objectAtIndex:swipedIndex.row];
    
    // Animate swiping the cell and after completion - remove it.
    UIView *swipeLine = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMidY(swipedCell.bounds), 0, 1)];
    swipeLine.backgroundColor = [UIColor lightGrayColor];
    [swipedCell addSubview:swipeLine];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect newRect = swipeLine.frame;
        newRect.size.width = CGRectGetMaxX(swipedCell.bounds) - 20;
        swipeLine.frame = newRect;
    }completion:^(BOOL finished) {
        [swipeLine removeFromSuperview];
        [emails removeObject:swipedEmail];
        [emailsTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:swipedIndex] withRowAnimation:UITableViewRowAnimationBottom];
    }];
}


#pragma mark -
#pragma mark SwipableViewDelegate

-(void) didSwipeAtLocation:(CGPoint)location
{
    [self handleSwipeAtLocation:location];
}

#pragma mark -
#pragma mark UITableViewDelegate methods

-(int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return emails.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"emailCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [emails objectAtIndex:indexPath.row];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
