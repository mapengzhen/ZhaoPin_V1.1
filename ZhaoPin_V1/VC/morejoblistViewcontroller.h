//
//  morejoblistViewcontroller.h
//  day10-3SearchJob
//
//  Created by Ibokan on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"
@interface morejoblistViewcontroller : UITableViewController<NSURLConnectionDataDelegate>
{
    //请求数据时用到的
    NSURLConnection *connection;
    NSMutableData *_data;
    UITableView *table;
}
@property(nonatomic,retain)NSMutableArray *job;
@property(nonatomic,retain)NSString *jobnumber;

@property(nonatomic,retain)GDataXMLElement *root;
//发送网络请求的方法
- (void)sendRequest;
//设置view的内容
- (void)setViewContent;
-(NSString *)md5:(NSString *)mystr;
- (NSString *) getMD5String:(NSString *)myurl;
@end
