//
//  Article.m
//  GuideToJobHunting
//
//  Created by Ibokan on 12-10-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Article.h"
#import "GDataXMLNode.h"//一定要导入该头文件，并且向工程里导入libxml2.dylib框架，工程的buildsetting里还要做相应修改，将search paths里的header search paths 值修改为/usr/include/libxml2/**

@implementation Article
@synthesize ID;
@synthesize author;
@synthesize title;
@synthesize subTilte;
@synthesize startDate;
@synthesize content;

//实现根据文章id初始化article的方法
- (id)initWithID:(int)aID 
          author:(NSString *)aAuthor 
           title:(NSString *)aTitle 
        subTitle:(NSString *)aSubTitle 
       startDate:(NSString *)aStartDate 
         content:(NSString *)aContent
{
    self = [super init];
    if (self) {
        self.ID = aID;
        self.author = aAuthor;
        self.title = aTitle;
        self.subTilte = aSubTitle;
        self.startDate = aStartDate;
        self.content = aContent;
    }
    return self;
}

//实现通过解析xml数据来创建对象的方法
- (id)initByXMLData:(NSData *)aData
{
    self = [super init];
    if (self) {
        // 开始解析获得的数据
        GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:aData options:0 error:nil];
        GDataXMLElement *root = [document rootElement];
        //将解析得到的数据赋给self属性值
        self.ID = [[[[root nodesForXPath:@"article/id" error:nil]objectAtIndex:0]stringValue]intValue];
        self.author = [[[root nodesForXPath:@"article/author" error:nil] objectAtIndex:0]stringValue];
        self.title = [[[root nodesForXPath:@"article/title" error:nil] objectAtIndex:0]stringValue];
        self.subTilte = [[[root nodesForXPath:@"article/subtitle" error:nil] objectAtIndex:0]stringValue];
        self.startDate = [[[root nodesForXPath:@"article/startdate" error:nil] objectAtIndex:0]stringValue];
        self.content = [[[root nodesForXPath:@"article/content" error:nil] objectAtIndex:0]stringValue];
        [document release];
    }
    return self;
}

//重写dealloc方法，释放内存
- (void)dealloc
{
    self.author = nil;
    self.title = nil;
    self.subTilte = nil;
    self.startDate = nil;
    self.content = nil;
    [super dealloc];
}

@end
