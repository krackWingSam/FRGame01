//
//  FRBoardPreference.m
//  FRGame01
//
//  Created by AskStoryTeam on 08/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRBoardPreference.h"

@implementation FRBoardPreference

+(FRBoardPreference*)sharedPreference {
    static FRBoardPreference *sharedPreference = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPreference = [[FRBoardPreference alloc] init];
    });
    return sharedPreference;
}

-(void)setDimensionX:(NSUInteger)dimensionX {
    _dimensionX = dimensionX;
    //TODO: set cellWidth or cellHeight using window size
}

-(void)setDimensionY:(NSUInteger)dimensionY {
    _dimensionY = dimensionY;
}

@end
