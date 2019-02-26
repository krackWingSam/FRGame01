//
//  FRTile.m
//  FRGame01
//
//  Created by AskStoryTeam on 25/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRTile.h"
#import "FRTileImageController.h"

static NSUInteger tileID;

@implementation FRTile

+(FRTile*)getRandomTile {
    FRTileType randomType = (arc4random() % 7) + 1;
    return [[FRTile alloc] initWithType:randomType];
}

-(id)initWithType:(FRTileType)type {
    if (self = [super init]) {
        _type = type;
        _tileID = tileID++;
    }
    return self;
}

-(UIImage *)getImage {
    FRTileImageController *controller = [FRTileImageController sharedController];
    NSString *key = [controller getKeyWithIndex:_type];
    return [controller getImageWithKey:key];
}

@end
