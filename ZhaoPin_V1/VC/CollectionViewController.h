//
//  CollectionViewController.h
//  GuideToJobHunting
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableData *_data;// 存放从网络接口上取得的xml数据
    NSMutableArray *_List;//用于存放解析xml数据得到的数据
    NSMutableArray *_selectedRow;//
    NSString *uticket;
}

@property (retain, nonatomic) IBOutlet UITableView *collectionTableView;

@end
