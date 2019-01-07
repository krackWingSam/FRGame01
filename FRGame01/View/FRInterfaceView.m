//
//  FRInterfaceView.m
//  FRGame01
//
//  Created by AskStoryTeam on 07/01/2019.
//  Copyright © 2019 Fermata. All rights reserved.
//

#import "FRInterfaceView.h"
#import "FRTouchPathController.h"


@interface FRInterfaceView () {
    FRTouchPathController *pathController;
}

@end


@implementation FRInterfaceView

-(void)awakeFromNib {
    [super awakeFromNib];
}

-(void)initInterface {
    pathController = [FRTouchPathController sharedController];
    
    if (_dimension_X < 1)
        _dimension_X = FRINTERFACE_DEFAULT_DIMENSION;
    if (_dimension_Y < 1)
        _dimension_Y = FRINTERFACE_DEFAULT_DIMENSION;
    
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
        for (int i=0 ; i<_dimension_Y ; i++) {
            [path moveToPoint:CGPointMake(0, _cellHeight * (i+1))];
            [path addLineToPoint:CGPointMake(self.frame.size.width, _cellHeight * (i+1))];
        }
        
        //draw y-axis
        for (int i=0 ; i<_dimension_X ; i++) {
            [path moveToPoint:CGPointMake(_cellWidth * (i+1), 0)];
            [path addLineToPoint:CGPointMake(_cellWidth * (i+1), self.frame.size.width)];
        }
        
        [path stroke];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    FRTouchObject *firstTouch = [FRTouchObject touchObjectWithDimension:CGPointMake(_dimension_X, _dimension_Y) withViewSize:self.frame.size withLocation:[[touches anyObject] locationInView:self]];
    
    if (_debug)
        NSLog(@"first touch detected : %ld, %ld", firstTouch.x, firstTouch.y);
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    FRTouchObject *nextTouch = [FRTouchObject touchObjectWithDimension:CGPointMake(_dimension_X, _dimension_Y) withViewSize:self.frame.size withLocation:[[touches anyObject] locationInView:self]];
    
    if (_debug)
        NSLog(@"next touch detected : %ld, %ld", nextTouch.x, nextTouch.y);
    
    //TODO: check can moving next touch
    [pathController addNextTouch:nextTouch];
    
    NSLog(@"");
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touches end %@ : %@", touches, event);
}

@end
