//
//  FRTile.m
//  FRGame01
//
//  Created by AskStoryTeam on 25/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRTile.h"

@implementation FRTile

-(id)initWithType:(FRTileType)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

@end
