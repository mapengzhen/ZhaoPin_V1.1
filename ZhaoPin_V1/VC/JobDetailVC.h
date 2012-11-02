//
//  JobDetailVC.h
//  Zhaopin
//
//  Created by Ibokan on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MapViewController;

@interface JobDetailVC : UIViewController<UIAlertViewDelegate>
{
    NSMutableData *_data;// 存放从网络接口上取得的xml数据
    NSMutableArray *_List;//用于存放解析xml数据得到的数据
    NSString *uticket;
    MapViewController *mapViewC;
}
@property (nonatomic, retain)NSString *jobNumber;
@property (retain, nonatomic) IBOutlet UILabel *jobTitle;
@property (retain, nonatomic) IBOutlet UILabel *jobCity;
@property (retain, nonatomic) IBOutlet UILabel *work;
@property (retain, nonatomic) IBOutlet UILabel *salary;
@property (retain, nonatomic) IBOutlet UILabel *number;
@property (retain, nonatomic) IBOutlet UITextView *detail;
@property (retain, nonatomic) IBOutlet UIView *jobView;


@property (retain, nonatomic) IBOutlet UIView *companyView;
@property (retain, nonatomic) IBOutlet UILabel *companyTitle;
@property (retain, nonatomic) IBOutlet UILabel *companyType;
@property (retain, nonatomic) IBOutlet UILabel *companySize;
@property (retain, nonatomic) IBOutlet UILabel *companyKind;
@property (retain, nonatomic) IBOutlet UILabel *companyAddress;
@property (retain, nonatomic) IBOutlet UITextView *companyDetail;

@property (retain, nonatomic) IBOutlet UIButton *companyButton;
@property (retain, nonatomic) IBOutlet UIButton *jobButton;
@property (retain, nonatomic) IBOutlet UIButton *applyBtn;
@property (retain, nonatomic) IBOutlet UIButton *favoriteBtn;
@property (retain, nonatomic) IBOutlet UIButton *sameBtn;
@property (retain, nonatomic) IBOutlet UIButton *positionBtn;


-(void)passByValueAndInitGeocoder;

@end
