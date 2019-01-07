//
//  FRTouchObject.m
//  FRGame01
//
//  Created by AskStoryTeam on 07/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRTouchObject.h"

@implementation FRTouchObject

+(FRTouchObject *)touchObjectWithDimension:(CGPoint)dimension withViewSize:(CGSize)viewSize withLocation:(CGPoint)location {
    float cellWidth, cellHeight;
    cellWidth = viewSize.width / dimension.x;
    cellHeight = viewSize.height / dimension.y;
    
    FRTouchObject *newObj = [[FRTouchObject alloc] initWithPoint:CGPointMake(location.x/cellWidth, location.y/cellHeight) withPosition:location];
    
    return newObj;
}


#pragma mark - public
-(FRTouchObject *)initWithPoint:(CGPoint)point withPosition:(CGPoint)position {
    if (self = [super init]) {
        _x = floor(point.x);
        _y = floor(point.y);
        _position = position;
    }
    return self;
}

-(BOOL)isEqual:(FRTouchObject *)touch {
    BOOL equal = NO;
    
    if (self.x == touch.x && self.y == touch.y)
        equal = YES;
    
    return equal;
}

@end
