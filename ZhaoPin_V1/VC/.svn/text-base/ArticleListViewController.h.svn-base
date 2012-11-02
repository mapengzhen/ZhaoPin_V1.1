//
//  ArticleListViewController.h
//  GuideToJobHunting
//
//  Created by Ibokan on 12-10-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Channel;

@interface ArticleListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate>
{
    NSMutableData *_data;// 从网络接口上取得的xml数据
    UIView *_connectionView;//网络连接状况说明视图
    UILabel *_connectionLabel;//网络连接状况说明label
    Channel *channel;
}

@property (assign, nonatomic) int ID;
@property (retain, nonatomic) IBOutlet UITableView *articleListTableView;

@end
