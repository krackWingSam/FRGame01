//
//  FRTileController.h
//  FRGame01
//
//  Created by AskStoryTeam on 25/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FRTileController : NSObject

+(FRTileController*)sharedController;

-(void)initTileMap;

@end

NS_ASSUME_NONNULL_END
