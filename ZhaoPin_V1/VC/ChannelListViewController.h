//
//  ChannelListViewController.h
//  GuideToJobHunting
//
//  Created by Ibokan on 12-10-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate>
{
    NSMutableData *_data;// 从网络接口上取得的xml数据
    NSMutableArray *channelList;//用于存放解析xml数据得到的数据
}

@property (retain, nonatomic) IBOutlet UITableView *channelListTableView;

@end
