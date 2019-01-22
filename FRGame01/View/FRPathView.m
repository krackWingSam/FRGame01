//
//  FRPathView.m
//  FRGame01
//
//  Created by AskStoryTeam on 07/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRPathView.h"
#import "FRBoardPreference.h"
#import "FRTouchPathController.h"


@interface FRPathView () {
    FRBoardPreference *boardPreference;
    FRTouchPathController *pathController;
}

@end


@implementation FRPathView

-(void)initInterface {
    pathController = [FRTouchPathController sharedController];
    boardPreference = [FRBoardPreference sharedPreference];
    
    _dimension_X = boardPreference.dimensionX;
    _dimension_Y = boardPreference.dimensionY;
    
    _cellWidth = self.frame.size.width / _dimension_X;
    _cellHeight = self.frame.size.width / _dimension_Y;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}

@end
