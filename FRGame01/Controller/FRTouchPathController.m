//
//  FRTouchPathController.m
//  FRGame01
//
//  Created by AskStoryTeam on 07/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRTouchPathController.h"

@interface FRTouchPathController () {
    NSMutableArray *array_Touches;
}

@end


@implementation FRTouchPathController

+(FRTouchPathController*)sharedController {
    static FRTouchPathController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[FRTouchPathController alloc] init];
    });
    return sharedController;
}

-(FRTouchPathController *)init {
    if (self = [super init]) {
        array_Touches = [[NSMutableArray alloc] init];
        _touchs = array_Touches;
    }
    return self;
}


#pragma mark - public
-(void)setFirstTouch:(FRTouchObject *)touch {
    array_Touches = [[NSMutableArray alloc] init];
    
    [array_Touches addObject:touch];
}

-(void)addNextTouch:(FRTouchObject *)touch {
    FRTouchObject *lastTouch = [array_Touches lastObject];
    
    // not side position
    if (abs((int)lastTouch.x - (int)touch.x) + abs((int)lastTouch.y - (int)touch.y) > 2)
        return;
    
    // same position with old object
    for (FRTouchObject *obj in array_Touches) {
        if ([obj isEqual:touch])
            return;
    }
    
    [array_Touches addObject:touch];
}


@end
