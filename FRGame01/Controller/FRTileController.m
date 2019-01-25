//
//  FRTileController.m
//  FRGame01
//
//  Created by AskStoryTeam on 25/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRTileController.h"

@implementation FRTileController

+(FRTileController*)sharedController {
    static FRTileController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[FRTileController alloc] init];
    });
    return sharedController;
}

@end
