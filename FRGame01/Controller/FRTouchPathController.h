//
//  FRTouchPathController.h
//  FRGame01
//
//  Created by AskStoryTeam on 07/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRTouchObject.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FRTouchPathControllerDelegate <NSObject>

-(void)drawPathWithTouches:(NSArray *)touches withLastTouch:(FRTouchObject *)lastTouch;

@end



@interface FRTouchPathController : NSObject

+(FRTouchPathController*)sharedController;

-(void)setFirstTouch:(FRTouchObject *)touch;
-(BOOL)addNextTouch:(FRTouchObject *)touch;
-(BOOL)setLastTouch:(FRTouchObject *)touch;
-(void)cleanTouchsArray;

@property (readonly) FRTouchObject *currentTouch;
@property (readonly) NSMutableArray *touchs;
@property BOOL debug;

@property id<FRTouchPathControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
