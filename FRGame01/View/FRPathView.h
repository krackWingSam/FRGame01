//
//  FRPathView.h
//  FRGame01
//
//  Created by AskStoryTeam on 07/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRTouchPathController.h"


NS_ASSUME_NONNULL_BEGIN

@interface FRPathView : UIView  <FRTouchPathControllerDelegate>

@property BOOL debug;
@property NSInteger dimension_X;
@property NSInteger dimension_Y;

@property (readonly) CGFloat cellWidth;
@property (readonly) CGFloat cellHeight;

-(void)initInterface;

@end

NS_ASSUME_NONNULL_END
