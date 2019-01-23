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
    BOOL isSelected = false;
    float cellWidth, cellHeight;
    cellWidth = viewSize.width / dimension.x;
    cellHeight = viewSize.height / dimension.y;
    
    if (location.x >= viewSize.width)
        location.x = viewSize.width-1;
    if (location.x <= 0)
        location.x = 0;
    
    if (location.y >= viewSize.height)
        location.y = viewSize.height-1;
    if (location.y <= 0)
        location.y = 0;
    
    int cellX = floor(location.x/cellWidth);
    int cellY = floor(location.y/cellHeight);
    
    float innerLocation_X = location.x - (cellWidth * cellX);
    float innerLocation_Y = location.y - (cellHeight * cellY);
    
    if (innerLocation_X > cellWidth/2 && innerLocation_Y > cellHeight/2) {
        // Quadrant 2
        if (innerLocation_Y < -innerLocation_X + 93.75 )
            isSelected = true;
    }
    else if (innerLocation_X < cellWidth/2 && innerLocation_Y > cellHeight/2) {
        // Quadrant 3
        if (innerLocation_Y < innerLocation_X + 31.25) {
            isSelected = true;
        }
    }
    else if (innerLocation_X < cellWidth/2 && innerLocation_Y < cellHeight/2) {
        // Quadrant 4
        if (innerLocation_Y > -innerLocation_X + 31.25 )
            isSelected = true;
    }
    else {
        // Quadrant 1
        if (innerLocation_Y > innerLocation_X - 31.25)
            isSelected = true;
    }
    
    CGPoint touchedPoint;
    if (isSelected)
        touchedPoint = CGPointMake(cellX, cellY);
    else
        touchedPoint = CGPointMake(-1, -1);
    
    FRTouchObject *newObj = [[FRTouchObject alloc] initWithPoint:touchedPoint withPosition:location];
    
    return newObj;
}


#pragma mark - Ovveriding
-(NSString *)description {
    return [[NSString alloc] initWithFormat:@"x : %ld, y : %ld", _x, _y ];
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
