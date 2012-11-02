//
//  Channel.h
//  GuideToJobHunting
//
//  Created by Ibokan on 12-10-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject

@property (nonatomic, assign) int ID;//channel的id 
@property (nonatomic, assign) int totalCount;//总共有多少篇文章
@property (nonatomic, retain) NSString *name;//channel的名字
@property (nonatomic, retain) NSMutableArray *articles;//存放所有文章的数组，数组中的文章只能取得title和id

//初始化channel的方法
- (id)initWithID:(int)aID 
      totalCount:(int)aTotalCount 
            name:(NSString *)aName 
        articles:(NSMutableArray *)aArticles;

//通过解析xml数据来创建对象的方法
- (id)initByXMLData:(NSData *)aData;

@end
