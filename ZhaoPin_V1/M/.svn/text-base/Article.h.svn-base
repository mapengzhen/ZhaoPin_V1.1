//
//  Article.h
//  GuideToJobHunting
//
//  Created by Ibokan on 12-10-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (nonatomic, assign) int ID;//id
@property (nonatomic, retain) NSString *author;//作者
@property (nonatomic, retain) NSString *title;//标题
@property (nonatomic, retain) NSString *subTilte;//子标题
@property (nonatomic, retain) NSString *startDate;//创建日期
@property (nonatomic, retain) NSString *content;//文章内容

//初始化article的方法
- (id)initWithID:(int)aID 
          author:(NSString *)aAuthor 
           title:(NSString *)aTitle 
        subTitle:(NSString *)aSubTitle 
       startDate:(NSString *)aStartDate 
         content:(NSString *)aContent;

//通过解析xml数据来创建对象的方法
- (id)initByXMLData:(NSData *)aData;

@end
