//
//  FRTile.h
//  FRGame01
//
//  Created by AskStoryTeam on 25/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    FRTileType_1 = 1,
    FRTileType_2,
    FRTileType_3,
    FRTileType_4,
    FRTileType_5,
    FRTileType_6,
    FRTileType_7,
} FRTileType;

@interface FRTile : NSObject

@property (readonly) NSUInteger tileID;
@property (readonly) FRTileType type;

@end

NS_ASSUME_NONNULL_END
