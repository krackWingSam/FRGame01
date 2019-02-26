//
//  FRBoardPreference.h
//  FRGame01
//
//  Created by AskStoryTeam on 08/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



#define FR_DEFAULT_DIMENSION 6

@interface FRBoardPreference : NSObject

+(FRBoardPreference*)sharedPreference;

@property (nonatomic) NSUInteger dimensionX;
@property (nonatomic) NSUInteger dimensionY;
@property (readonly) float cellWidth;
@property (readonly) float cellHeight;

@end

NS_ASSUME_NONNULL_END
