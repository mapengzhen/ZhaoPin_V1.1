//
//  MarkedJob.h
//  GuideToJobHunting
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarkedJob : NSObject

@property (nonatomic, retain) NSString *number;//
@property (nonatomic, retain) NSString *title;//标题
@property (nonatomic, retain) NSString *city;//
@property (nonatomic, assign) int count;//
@property (nonatomic, retain) NSString *companyNumber;//
@property (nonatomic, retain) NSString *companyName;//
@property (nonatomic, assign) int status;//
@property (nonatomic, retain) NSString *date;//

@end
