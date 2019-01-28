//
//  FRBoardPreference.m
//  FRGame01
//
//  Created by AskStoryTeam on 08/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRBoardPreference.h"


@interface FRBoardPreference () {
    CGRect windowFrame;
}

@end



@implementation FRBoardPreference

+(FRBoardPreference*)sharedPreference {
    static FRBoardPreference *sharedPreference = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPreference = [[FRBoardPreference alloc] init];
    });
    return sharedPreference;
}

-(id)init {
    if (self = [super init]) {
        windowFrame = [[UIScreen mainScreen] bounds];
    }
    return self;
}

-(void)setDimensionX:(NSUInteger)dimensionX {
    _dimensionX = dimensionX;
    
    _cellWidth = windowFrame.size.width / dimensionX;
}

-(void)setDimensionY:(NSUInteger)dimensionY {
    _dimensionY = dimensionY;
    
    _cellHeight = windowFrame.size.height / dimensionY;
}

@end
