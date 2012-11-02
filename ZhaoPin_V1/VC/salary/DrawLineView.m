//
//  DrawLineView.m
//  workGuider
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DrawLineView.h"

@implementation DrawLineView

-(void)initWithArray:(NSMutableArray *)arr value:(BOOL)isValue
{
    points = [[NSMutableArray alloc]initWithArray:arr];
    value = isValue;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef contex = UIGraphicsGetCurrentContext();
    //获得上下文
    if(value == YES)
    {
        CGContextSetStrokeColorWithColor(contex, [UIColor blueColor].CGColor);
    }
    else
    {
        CGContextSetStrokeColorWithColor(contex, [UIColor redColor].CGColor);
    }
    CGContextSetLineWidth(contex, 2);
    
    for(int i=0;i<[points count]-1;i++)
    {
        CGPoint pointm = [[points objectAtIndex:i] CGPointValue];
        CGPoint pointn = [[points objectAtIndex:i+1] CGPointValue];
        CGContextMoveToPoint(contex, pointm.x, pointm.y);
        CGContextAddLineToPoint(contex, pointn.x, pointn.y);
    }
    
    CGContextStrokePath(contex);
}

-(void)dealloc
{
    points = nil;
    [super dealloc];
}


@end
