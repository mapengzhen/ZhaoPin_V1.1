//
//  JobTableViewController.h
//  Zhaopin
//
//  Created by Ibokan on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadMoreTableFooterView.h"


@interface JobTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIPickerViewDataSource,UIPickerViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,UIAlertViewDelegate,LoadMoreTableFooterDelegate>

@property (retain, nonatomic) IBOutlet UITableView *jobTable;       //职位列表
@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;      //搜索栏

@property (retain, nonatomic) IBOutlet UIButton *experienceBtn;     //按钮
@property (retain, nonatomic) IBOutlet UIButton *salaryRangeBtn;
@property (retain, nonatomic) IBOutlet UIButton *releaseTimeBtn;
@property (retain, nonatomic) UIPickerView *experience;             //工作经验
@property (retain, nonatomic) UIPickerView *salaryRange;            //月薪范围
@property (retain, nonatomic) UIPickerView *releaseTime;            //发布时间  
@property (retain, nonatomic) NSArray *experienceArr;               //工作经验选项
@property (retain, nonatomic) NSArray *salaryRangeArr;              //月薪范围选项
@property (retain, nonatomic) NSArray *releaseTimeArr;              //发布时间选项
@property (retain, nonatomic) UIToolbar *experienceBar;
@property (retain, nonatomic) UIToolbar *salaryRangeBar;
@property (retain, nonatomic) UIToolbar *releaseTimeBar;

@property (retain, nonatomic)NSMutableDictionary *parameterDic;     //参数
@property (retain, nonatomic)NSString *urlString;
@property (assign, nonatomic)int curPage;                           //加载页数
@property (retain, nonatomic)NSString *workingExp;                  //工作经验
@property (retain, nonatomic)NSString *data_refresh;                //发布时间
@property (retain, nonatomic)NSString *salaryfrom;                  //月薪开始范围
@property (retain, nonatomic)NSString *salaryto;                    //月薪结束范围
@property (retain, nonatomic)NSString *key;

@property (retain, nonatomic)NSMutableArray *jobArr;
@property (retain, nonatomic)NSMutableArray *moreJobArr;
@property (retain, nonatomic)NSMutableData *jobArrData;
@property (retain, nonatomic)NSMutableData *moreJobData;
@property (retain, nonatomic)NSMutableData *applyJobData;
@property (retain, nonatomic)NSURLConnection *jobArrConnection;     //职位搜索 
@property (retain, nonatomic)NSURLConnection *moreJobArrConnection; 
@property (retain, nonatomic)NSURLConnection *applyJobConnection;   //申请职位
@property (retain, nonatomic)NSString *loadMoreUrlString;

@property (retain, nonatomic)NSMutableArray *cellButtonIsSelectArr; //记录职位被选中       
@property (retain, nonatomic)NSString *jobNumber;
@property (retain, nonatomic)NSString *uticket;
@property (retain, nonatomic)UIAlertView *noSignUp;

@property (retain, nonatomic)LoadMoreTableFooterView *loadMoreView;
@property (assign, nonatomic)BOOL isLoadingMore;

@end
