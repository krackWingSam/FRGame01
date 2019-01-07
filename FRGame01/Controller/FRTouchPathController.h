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

@interface FRTouchPathController : NSObject

+(FRTouchPathController*)sharedController;

-(void)setFirstTouch:(FRTouchObject *)touch;
-(void)addNextTouch:(FRTouchObject *)touch;


@property (readonly) NSMutableArray *touchs;

@end

NS_ASSUME_NONNULL_END
