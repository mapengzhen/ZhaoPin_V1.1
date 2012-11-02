//
//  Channel.m
//  GuideToJobHunting
//
//  Created by Ibokan on 12-10-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Channel.h"
#import "GDataXMLNode.h"
#import "Article.h"

@implementation Channel
@synthesize ID;
@synthesize totalCount;
@synthesize name;
@synthesize articles;

//实现channel的初始化方法
- (id)initWithID:(int)aID 
      totalCount:(int)aTotalCount 
            name:(NSString *)aName 
        articles:(NSMutableArray *)aArticles
{
    self = [super init];
    if (self) {
        self.ID = aID;
        self.totalCount = aTotalCount;
        self.name = aName;
        self.articles = aArticles;
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
        GDataXMLElement *channel = [[root children]objectAtIndex:0];
       //取出各个节点并存放入shuzu
        NSArray *totalCounts = [root nodesForXPath:@"channel/totalcount" error:nil];
        NSArray *names = [root nodesForXPath:@"channel/name" error:nil];
        NSArray *IDs = [root nodesForXPath:@"channel/articles/article/id" error:nil];
        NSArray *titles = [root nodesForXPath:@"channel/articles/article/title" error:nil];
        //将解析得到的数据赋给self属性值
        self.ID = [[[channel attributeForName:@"id"]stringValue]intValue];
        self.totalCount = [[[totalCounts objectAtIndex:0] stringValue]intValue];
        self.name = [[names objectAtIndex:0]stringValue];
        self.articles = [[NSMutableArray alloc]init];
        for (int i = 0; i< self.totalCount; i++) {
            Article *article = [[Article alloc]init];
            article.ID = [[[IDs objectAtIndex:i] stringValue]intValue];
            article.title = [[titles objectAtIndex:i] stringValue];
            [self.articles addObject:article];
            [article release];
        }
        [document release];
    }
    return self;
}

//重写dealloc方法，释放内存
- (void)dealloc
{
    self.name = nil;
    self.articles = nil;
    [super dealloc];
}

@end
