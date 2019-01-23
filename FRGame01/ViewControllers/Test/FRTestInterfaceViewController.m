//
//  FRTestInterfaceViewController.m
//  FRGame01
//
//  Created by AskStoryTeam on 07/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRTestInterfaceViewController.h"
#import "FRBoardPreference.h"
#import "FRTouchPathController.h"
#import "FRBoardView.h"
#import "FRPathView.h"

@interface FRTestInterfaceViewController () <UITextFieldDelegate> {
    IBOutlet FRBoardView *view_Interface;
    IBOutlet FRPathView *view_Path;
    
    IBOutlet UIView *view_Option;
    IBOutlet UIScrollView *view_OptionScroll;
    IBOutlet UIView *view_Content;
    IBOutlet UITextField *tf_Dimension_X;
    IBOutlet UITextField *tf_Dimension_Y;
    IBOutlet UISwitch *switch_ShowPathView;
    IBOutlet UISwitch *switch_ShowInteractionView;
    
    IBOutlet UISwitch *switch_Debug;
    
    FRBoardPreference *boardPreference;
    FRTouchPathController *pathController;
}

@end

@implementation FRTestInterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [view_Option setFrame:self.view.frame];
    UIColor *backgroundColor = [view_Option backgroundColor];
    CGFloat r,g,b,a;
    [backgroundColor getRed:&r green:&g blue:&b alpha:&a];
    backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:0.8f];
    [view_Option setBackgroundColor:backgroundColor];
    
    [view_Content setFrame:CGRectMake(0, 0, self.view.frame.size.width, view_Content.frame.size.height)];
    [view_OptionScroll addSubview:view_Content];
    [view_OptionScroll setBackgroundColor:backgroundColor];
    [view_OptionScroll setContentSize:view_Content.frame.size];
    
    boardPreference = [FRBoardPreference sharedPreference];
    pathController = [FRTouchPathController sharedController];
    
    [self action_DoneEditProperties:nil];
    
    //set protocol
    [[FRTouchPathController sharedController] setDelegate:view_Path];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Animations
-(void)showOptionView {
    [view_Option setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:view_Option];
    [UIView animateWithDuration:0.2f animations:^{
        [self->view_Option setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

-(void)hideOptionView {
    [UIView animateWithDuration:0.2f animations:^{
        [self->view_Option setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    } completion:^(BOOL finished) {
        [self->view_Option removeFromSuperview];
    }];
}


#pragma mark - IBActions
-(IBAction)action_EditProperties:(id)sender {
    [self showOptionView];
}

-(IBAction)action_DoneEditProperties:(id)sender {
    //set options in Board Preference
    [pathController setDebug:[switch_Debug isOn]];
    
    [boardPreference setDimensionX:[tf_Dimension_X.text integerValue]];
    [boardPreference setDimensionY:[tf_Dimension_Y.text integerValue]];
    
    [view_Interface setDebug:[switch_Debug isOn]];
    [view_Interface initInterface];
    [view_Path initInterface];
    
    [view_Interface setNeedsDisplay];
    
    if ([switch_ShowPathView isOn])
        [view_Path setHidden:NO];
    else
        [view_Path setHidden:YES];

    if ([switch_ShowInteractionView isOn])
        [view_Interface setHidden:NO];
    else
        [view_Interface setHidden:YES];
    
    [self hideOptionView];
}

-(IBAction)action_TouchBackground:(id)sender {
    [tf_Dimension_X resignFirstResponder];
    [tf_Dimension_Y resignFirstResponder];
}


@end
