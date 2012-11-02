//
//  EmailDetailViewController.h
//  MyZhilian
//
//  Created by Ibokan on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmailDetailViewController :UIViewController<NSURLConnectionDataDelegate>
{
    NSMutableData *_data;// 存放从网络接口上取得的xml数据
    NSMutableArray *_List;//用于存放解析xml数据得到的数据
    NSString *uticket;
}
@property (nonatomic, retain) NSString *ID;
@property (retain, nonatomic) IBOutlet UILabel *subjectLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UILabel *companyLabel;
@property (retain, nonatomic) IBOutlet UITextView *bodyTextView;
@property (retain, nonatomic) IBOutlet UIScrollView *backScollView;


@end
