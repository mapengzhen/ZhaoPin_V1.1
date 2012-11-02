//
//  salaryChargeTableViewController.h
//  workGuider
//
//  Created by Ibokan on 12-10-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface salaryChargeTableViewController : UITableViewController<NSURLConnectionDataDelegate,iCarouselDataSource,iCarouselDelegate>

{
    IBOutlet UIButton *chargeButton;
    IBOutlet UITableView *tableV;
    UIActivityIndicatorView *indicatorView;
    
    NSInteger selectRow;
}

@property (retain, nonatomic) IBOutlet UITextField *salaryTF;
@property (retain, nonatomic) IBOutlet UITextField *addressTF;
@property (retain, nonatomic) IBOutlet UITextField *industryTF;
@property (retain, nonatomic) IBOutlet UITextField *qualityTF;
@property (retain, nonatomic) IBOutlet UITextField *workKindTF;
@property (retain, nonatomic) IBOutlet UITextField *workLevelTF;
@property (retain, nonatomic) IBOutlet UISwitch *experienceSwitch;
@property (retain, nonatomic) IBOutlet UILabel *workLevel;
@property (retain, nonatomic) IBOutlet UILabel *money;
@property(retain,nonatomic)NSString *netStr;

@property(retain,nonatomic)NSString *addressID;
@property(retain,nonatomic)NSString *industryID;
@property(retain,nonatomic)NSString *qualityID;
@property(retain,nonatomic)NSString *workKindID;
@property(retain,nonatomic)NSString *workLevelID;

@property(assign,readwrite)BOOL switchValue;
@property(nonatomic,retain)NSMutableData *receivedData;

@property(retain,nonatomic)NSMutableArray *citys;
@property(retain,nonatomic)NSMutableArray *citysID;
@property(retain,nonatomic)NSMutableArray *industrys;

@property(retain,nonatomic)NSMutableArray *corppropertys;

@property(retain,nonatomic)NSMutableArray *jobcats;

@property(retain,nonatomic)NSMutableArray *educations;

@property(retain,nonatomic)NSMutableArray *joblevels;

@property(retain,nonatomic)NSMutableArray *industrysID;

@property(retain,nonatomic)NSMutableArray *corppropertysID;

@property(retain,nonatomic)NSMutableArray *jobcatsID;

@property(retain,nonatomic)NSMutableArray *educationsID;

@property(retain,nonatomic)NSMutableArray *joblevelsID;

@property (retain, nonatomic) iCarousel *carousel;

@end
