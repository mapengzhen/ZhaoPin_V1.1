//
//  currentRecommendViewController.h
//  Zhaopin
//
//  Created by Ibokan on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"
@interface currentRecommendViewController : UIViewController<NSURLConnectionDataDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UITableView *detailTableView;
    UIPageControl *pageControl;
    //request时，用到的变量
    NSURLConnection *connection;
    NSMutableData *_data;
    NSMutableDictionary *jobnumberDictionay;//发送“申请”时，读取的job_number
    NSMutableArray *numberOfRows;
    NSMutableArray *numberOfSection;
    NSMutableDictionary *jobDictionary;//ji记录申请的job
    NSMutableArray *jobArray;//记录申请后的jobname
    NSMutableArray *NEWJobArray;//用于推到详细界面，进行传值
}
@property(nonatomic,retain)GDataXMLElement *root;
@property(nonatomic,retain)NSMutableArray *titleArray;//存取cell的btn，用来判断是不是选中申请的职位
@property(nonatomic,retain)GDataXMLElement*uiticket;//uiticket参数是前一个页面传过来的参数
//发送网络请求的方法
- (void)sendRequest;
//设置view的内容
- (void)setViewContent;
-(NSString *)md5:(NSString *)mystr;
- (NSString *) getMD5String:(NSString *)myurl;
@property (retain, nonatomic) IBOutlet UITableView *MytableView;
@property (retain, nonatomic) IBOutlet UIScrollView *MyScorllView;
- (IBAction)askForJobs:(id)sender;
- (IBAction)MyCollect:(id)sender;
- (IBAction)Myaction:(id)sender;
- (IBAction)MysimilarJob:(id)sender;

@end
