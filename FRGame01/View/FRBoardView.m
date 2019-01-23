//
//  FRInterfaceView.m
//  FRGame01
//
//  Created by AskStoryTeam on 07/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRBoardView.h"
#import "FRBoardPreference.h"
#import "FRTouchPathController.h"


@interface FRBoardView () {
    FRBoardPreference *boardPreference;
    FRTouchPathController *pathController;
}

@end


@implementation FRBoardView

-(void)awakeFromNib {
    [super awakeFromNib];
}

-(void)initInterface {
    pathController = [FRTouchPathController sharedController];
    boardPreference = [FRBoardPreference sharedPreference];
    
    _dimension_X = boardPreference.dimensionX;
    _dimension_Y = boardPreference.dimensionY;
    
    _cellWidth = self.frame.size.width / _dimension_X;
    _cellHeight = self.frame.size.width / _dimension_Y;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (_debug) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth = 1.f;
        
        //draw x-axis
        for (int i=0 ; i<_dimension_Y+1 ; i++) {
            [path moveToPoint:CGPointMake(0, _cellHeight * i)];
            [path addLineToPoint:CGPointMake(self.frame.size.width, _cellHeight * i)];
        }
        
        //draw y-axis
        for (int i=0 ; i<_dimension_X+1 ; i++) {
            [path moveToPoint:CGPointMake(_cellWidth * i, 0)];
            [path addLineToPoint:CGPointMake(_cellWidth * i, self.frame.size.width)];
        }
        [path stroke];
        
        //switch path for switch color
        path = [UIBezierPath bezierPath];
        [[UIColor colorWithRed:0.f green:1.f blue:0.f alpha:0.5f] set];
        //draw square
        for (int x=0 ; x<_dimension_X ; x++) {
            for (int y=0 ; y<_dimension_Y ; y++) {
                float startPointX = _cellWidth * x;
                float startPointY = (_cellHeight * y) + _cellHeight / 2;
                float movePointX = (_cellWidth * x) + _cellWidth / 2;
                float movePointY = _cellHeight * y;
                
                [path moveToPoint:CGPointMake(startPointX, startPointY)];
                [path addLineToPoint:CGPointMake(movePointX, movePointY)];
                
                movePointX = _cellWidth * (x + 1);
                movePointY = (_cellHeight * y) + (_cellHeight / 2);
                
                [path addLineToPoint:CGPointMake(movePointX, movePointY)];
                
                movePointX = (_cellWidth * x) + (_cellWidth / 2);
                movePointY = _cellHeight * (y + 1);
                
                [path addLineToPoint:CGPointMake(movePointX, movePointY)];
                
                movePointX = _cellWidth * x;
                movePointY = _cellHeight * y + _cellHeight / 2;
                
                [path addLineToPoint:CGPointMake(movePointX, movePointY)];
            }
        }
        
        [path stroke];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    FRTouchObject *firstTouch = [FRTouchObject touchObjectWithDimension:CGPointMake(_dimension_X, _dimension_Y) withViewSize:self.frame.size withLocation:[[touches anyObject] locationInView:self]];
    
    if (firstTouch)
        [pathController setFirstTouch:firstTouch];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    FRTouchObject *nextTouch = [FRTouchObject touchObjectWithDimension:CGPointMake(_dimension_X, _dimension_Y) withViewSize:self.frame.size withLocation:[[touches anyObject] locationInView:self]];
    
    if (nextTouch)
        [pathController addNextTouch:nextTouch];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    FRTouchObject *lastTouch = [FRTouchObject touchObjectWithDimension:CGPointMake(_dimension_X, _dimension_Y) withViewSize:self.frame.size withLocation:[[touches anyObject] locationInView:self]];
    
    if (lastTouch)
        [pathController setLastTouch:lastTouch];
}

@end