//
//  FRPathView.m
//  FRGame01
//
//  Created by AskStoryTeam on 07/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRPathView.h"
#import "FRBoardPreference.h"


@interface FRPathView (){
    FRBoardPreference *boardPreference;
    FRTouchPathController *pathController;
    
    NSArray *_touches;
    FRTouchObject *_lastTouch;
}

@end


@implementation FRPathView

-(void)initInterface {
    pathController = [FRTouchPathController sharedController];
    boardPreference = [FRBoardPreference sharedPreference];
    
    _dimension_X = boardPreference.dimensionX;
    _dimension_Y = boardPreference.dimensionY;
    
    _cellWidth = self.frame.size.width / _dimension_X;
    _cellHeight = self.frame.size.width / _dimension_Y;
}


- (void)drawRect:(CGRect)rect {
    if (_touches == nil || _touches.count == 0)
        return;
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5.f;
    [[UIColor colorWithRed:0.f green:0.f blue:1.f alpha:0.5f] set];
    
    FRTouchObject *startObj = [_touches objectAtIndex:0];
    [path moveToPoint:CGPointMake(startObj.x * _cellWidth + _cellWidth/2, startObj.y * _cellHeight + _cellHeight/2)];
    
    for (int i=1 ; i<_touches.count ; i++) {
        FRTouchObject *targetobj = [_touches objectAtIndex:i];
        [path addLineToPoint:CGPointMake(targetobj.x * _cellWidth + _cellWidth/2, targetobj.y * _cellHeight + _cellHeight/2)];
    }
    
    [path addLineToPoint:CGPointMake(_lastTouch.position.x, _lastTouch.position.y)];
    
    [path stroke];
}


#pragma mark - FRTouchPathControllerDelegate
-(void)drawPathWithTouches:(NSArray *)touches withLastTouch:(FRTouchObject *)lastTouch {
    _touches = touches;
    _lastTouch = lastTouch;
    
    [self setNeedsDisplay];
}

@end
