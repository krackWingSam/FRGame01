//
//  FRInterfaceView.h
//  FRGame01
//
//  Created by AskStoryTeam on 07/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define FRINTERFACE_DEFAULT_DIMENSION 6

@interface FRInterfaceView : UIView

-(void)initInterface;

@property BOOL debug;
@property NSInteger dimension_X;
@property NSInteger dimension_Y;

@property (readonly) CGFloat cellWidth;
@property (readonly) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
