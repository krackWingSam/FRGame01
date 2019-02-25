//
//  TileImageController.m
//  FRGame01
//
//  Created by 강상우 on 25/02/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "TileImageController.h"

@interface TileImageController() {
    NSDictionary *dic_Image;
}

@end


@implementation TileImageController

+(TileImageController *)sharedController {
    static TileImageController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[TileImageController alloc] init];
    });
    return sharedController;
}

-(id)init {
    if (self = [super init]) {
        [self initImages];
    }
    return self;
}

-(void)initImages {
    if (!dic_Image) {
        NSArray *names = @[KEY_IMAGE_TILE_1, KEY_IMAGE_TILE_2, KEY_IMAGE_TILE_3, KEY_IMAGE_TILE_4, KEY_IMAGE_TILE_5, KEY_IMAGE_TILE_6, KEY_IMAGE_TILE_7];
        NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
        for (NSString *name in names) {
            NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
            [tempDic setObject:image forKey:name];
        }
    }
}

-(UIImage *)getImageWithKey:(NSString *)key {
    [self initImages];
    
    return [dic_Image objectForKey:key];
}

@end
