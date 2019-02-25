//
//  TileImageController.h
//  FRGame01
//
//  Created by 강상우 on 25/02/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define KEY_IMAGE_TILE_1 @"t_1"
#define KEY_IMAGE_TILE_2 @"t_2"
#define KEY_IMAGE_TILE_3 @"t_3"
#define KEY_IMAGE_TILE_4 @"t_4"
#define KEY_IMAGE_TILE_5 @"t_5"
#define KEY_IMAGE_TILE_6 @"t_6"
#define KEY_IMAGE_TILE_7 @"t_7"



@interface TileImageController : NSObject

+(TileImageController *)sharedController;

-(UIImage *)getImageWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
