//
//  DrawLineView.h
//  workGuider
//
//  Created by Ibokan on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawLineView : UIView
{
    NSMutableArray *points;
    
    BOOL value;
}

-(void)initWithArray:(NSMutableArray *)arr value:(BOOL)isValue;

@end
