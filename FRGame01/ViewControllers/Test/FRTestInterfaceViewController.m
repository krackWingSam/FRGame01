//
//  FRTestInterfaceViewController.m
//  FRGame01
//
//  Created by AskStoryTeam on 07/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRTestInterfaceViewController.h"
#import "FRInterfaceView.h"

@interface FRTestInterfaceViewController () <UITextFieldDelegate> {
    
    IBOutlet FRInterfaceView *interfaceView;
    
    IBOutlet UIView *optionView;
    IBOutlet UITextField *tf_Dimension_X;
    IBOutlet UITextField *tf_Dimension_Y;
    IBOutlet UISwitch *switch_Debug;
}

@end

@implementation FRTestInterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [optionView setFrame:self.view.frame];
    UIColor *backgroundColor = [optionView backgroundColor];
    CGFloat r,g,b,a;
    [backgroundColor getRed:&r green:&g blue:&b alpha:&a];
    backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:0.5f];
    [optionView setBackgroundColor:backgroundColor];
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
    [optionView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:optionView];
    [UIView animateWithDuration:0.2f animations:^{
        [self->optionView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

-(void)hideOptionView {
    [UIView animateWithDuration:0.2f animations:^{
        [self->optionView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    } completion:^(BOOL finished) {
        [self->optionView removeFromSuperview];
    }];
}


#pragma mark - IBActions
-(IBAction)action_EditProperties:(id)sender {
    [self showOptionView];
}

-(IBAction)action_DoneEditProperties:(id)sender {
    //TODO: set options in interface view
    [interfaceView setDimension_X:[tf_Dimension_X.text integerValue]];
    [interfaceView setDimension_Y:[tf_Dimension_Y.text integerValue]];
    [interfaceView setDebug:[switch_Debug isOn]];
    [interfaceView initInterface];
    
    [interfaceView setNeedsDisplay];
    
    [self hideOptionView];
}

-(IBAction)action_TouchBackground:(id)sender {
    [tf_Dimension_X resignFirstResponder];
    [tf_Dimension_Y resignFirstResponder];
}


@end
