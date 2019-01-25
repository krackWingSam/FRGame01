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

-(BOOL)checkValidTouch:(FRTouchObject *)touch {
    //TODO: check is same tile?
    
    FRTouchObject *lastTouch = [array_Touches lastObject];
    
    // not side position
    if (abs((int)lastTouch.x - (int)touch.x) > 1)
        return NO;
    if (abs((int)lastTouch.y - (int)touch.y) > 1)
        return NO;
    
    // same position with old object
    for (FRTouchObject *obj in array_Touches) {
        if ([obj isEqual:touch])
            return NO;
    }
    
    return YES;
}

-(BOOL)checkRemovableTouch:(FRTouchObject *)touch {
    if ([array_Touches count] < 2)
        return NO;
    
    FRTouchObject *previousTouch = [array_Touches objectAtIndex:[array_Touches count]-2];
    
    // same position with old object
    if ([previousTouch isEqual:touch])
        return YES;
    
    return NO;
}


#pragma mark - public
-(void)setFirstTouch:(FRTouchObject *)touch {
    [array_Touches removeAllObjects];
    
    if (touch.x == -1 || touch.y == -1)
        return;
    
    if (_debug)
        NSLog(@"set first add : %@", touch);
        
    [array_Touches addObject:touch];
}

-(BOOL)addNextTouch:(FRTouchObject *)touch {
    _currentTouch = touch;
    
    if (self.delegate)
        [self.delegate drawPathWithTouches:array_Touches withLastTouch:_currentTouch];
    
    if (touch.x == -1 || touch.y == -1)
        return NO;
    
    if ([self checkValidTouch:touch])
        [array_Touches addObject:touch];
    else if ([self checkRemovableTouch:touch])
        [array_Touches removeLastObject];
    else
        return NO;
    
    if (_debug) {
        NSLog(@"touches array start - ");
        for (FRTouchObject *obj in array_Touches)
            NSLog(@"%@", obj);
        NSLog(@"- touches array end ");
    }
    
    return YES;
}

-(BOOL)setLastTouch:(FRTouchObject *)touch {
    if ([self checkValidTouch:touch])
        [array_Touches addObject:touch];
    else
        return NO;
    
    if(_debug)
        NSLog(@"add ended : %@", touch);
    
    return YES;
}

-(void)cleanTouchsArray {
    [array_Touches removeAllObjects];
}


@end
