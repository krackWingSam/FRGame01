//
//  FRTouchObject.h
//  FRGame01
//
//  Created by AskStoryTeam on 07/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FRTouchObject : NSObject

+(FRTouchObject *)touchObjectWithDimension:(CGPoint)dimension withViewSize:(CGSize)viewSize withLocation:(CGPoint)location;
-(BOOL)isEqual:(FRTouchObject *)touch;

@property (readonly) NSInteger x;
@property (readonly) NSInteger y;
@property (readonly) CGPoint position;

@end

NS_ASSUME_NONNULL_END
