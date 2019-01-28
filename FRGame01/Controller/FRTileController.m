//
//  FRTileController.m
//  FRGame01
//
//  Created by AskStoryTeam on 25/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRTileController.h"
#import "FRBoardPreference.h"
#import "FRTile.h"

@interface FRTileController () {
    NSMutableArray *tileArray;
    NSUInteger dimensionX, dimensionY;
}

@end


@implementation FRTileController

+(FRTileController*)sharedController {
    static FRTileController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[FRTileController alloc] init];
    });
    return sharedController;
}

-(id)init {
    if (self = [super init]) {
        [self initTileMap];
    }
    return self;
}

-(void)initTileMap {
    dimensionX = [[FRBoardPreference sharedPreference] dimensionX];
    dimensionY = [[FRBoardPreference sharedPreference] dimensionY];
    
    tileArray = [[NSMutableArray alloc] initWithCapacity:dimensionX];
    for (int i=0 ; i<dimensionY ; i++) {
        NSMutableArray *xArray = [[NSMutableArray alloc] initWithCapacity:dimensionY];
        [tileArray addObject:xArray];
    }
}

-(void)fillTileMap {
    
}

@end
