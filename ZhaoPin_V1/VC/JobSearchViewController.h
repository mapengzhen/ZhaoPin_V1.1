//
//  PPJobSearchViewController.h
//  PPZhiLian
//
//  Created by 马朋震 /Users/ibokan/Desktop/图片/523194.gif on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParameterViewController.h"
@interface JobSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,GetData,UITextFieldDelegate>
{
    //搜索条件和历史搜索的tableView
    UITableView *searchConditionTV;
    //输入关键字的输入框
    UITextField *keywordTF;
}

//cell上的标题数组
@property (nonatomic,retain) NSMutableArray *searchConditionTitles;
@property (nonatomic,retain) NSMutableArray *searchConditionDetailTitles;

//用户选择的搜索条件
@property (nonatomic,retain) NSMutableArray *selectedConditionArr;

//用户选择的搜索条件对应的参数
@property (nonatomic,retain) NSMutableArray *selectedParametersForConditions;

//用户选择条件后的请求链接
@property (nonatomic,retain) NSString *searchURL;

//返回用户选择的搜索条件对应的参数
@property (nonatomic,retain) NSMutableDictionary *selctedConditionAndParameterDic;

@property (nonatomic,retain) NSMutableArray *historysCells;

@property (nonatomic,retain) NSMutableArray *historysPara;

- (IBAction)back:(id)sender;
@end
