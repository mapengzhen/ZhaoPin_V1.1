//
//  ArticleDetailViewController.h
//  GuideToJobHunting
//
//  Created by Ibokan on 12-10-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleDetailViewController : UIViewController<NSURLConnectionDataDelegate> //异步获取数据使用的代理 
{
    NSMutableData *_data;// 从网络接口上取得的xml数据
}

@property (assign, nonatomic) int ID;//从上一个界面传过来的ID
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;//文章标题
@property (retain, nonatomic) IBOutlet UILabel *startDateLabel;//文章创建日期
@property (retain, nonatomic) IBOutlet UITextView *contentTextView;//文章内容

@end
