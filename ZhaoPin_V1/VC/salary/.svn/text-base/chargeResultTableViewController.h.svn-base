//
//  chargeResultTableViewController.h
//  workGuider
//
//  Created by Ibokan on 12-10-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "salaryChargeTableViewController.h"
#import "DIYMenu.h"
#import "RNExpandingButtonBar.h"
#import "iCarousel.h"

@interface chargeResultTableViewController : UITableViewController<NSURLConnectionDataDelegate,DIYMenuDelegate,RNExpandingButtonBarDelegate,iCarouselDataSource,iCarouselDelegate>

{
    NSMutableArray *insertArr;
    NSMutableArray *resultArr;
    
    IBOutlet UILabel *lowLabel;
    IBOutlet UILabel *midlowLabel;
    IBOutlet UILabel *midLabel;
    IBOutlet UILabel *midhighLabel;
    IBOutlet UILabel *highLabel;
    
    IBOutlet UILabel *tabelLowLabel;
    IBOutlet UILabel *tabelMidlowLabel;
    IBOutlet UILabel *tabelMidLabel;
    IBOutlet UILabel *tabelMidhighLabel;
    IBOutlet UILabel *tabelHighLabel;
    
    UILabel *tabelLow;
    UILabel *tabelMidlow;
    UILabel *tabelMid;
    UILabel *tabelMidhigh;
    UILabel *tabelHigh;
    
    NSMutableArray *newResultArr;
    
    IBOutlet UIImageView *tableImageView;
    
    NSString *webStr;
    UIActivityIndicatorView *indicatorView;
    
    NSMutableArray *pointArr;
    
    float ny1;
    float ny2;
    float ny3;
    float ny4;
    float ny5;
    
    NSInteger selectTag;
    
    NSString *web;
}

@property (retain, nonatomic) IBOutlet UITextField *textTF1;

@property (retain, nonatomic) IBOutlet UITextField *textTF2;

@property(retain,nonatomic)NSMutableArray *saveArr;
@property(retain,nonatomic)NSMutableArray *saveArrID;

@property(retain,nonatomic)NSString *stringID;

@property(retain,nonatomic)salaryChargeTableViewController *salaryVC;

@property (nonatomic, strong) RNExpandingButtonBar *bar;
@property (retain, nonatomic) iCarousel *carousel;
@property(nonatomic,retain)NSMutableData *receivedData;

@property(assign,nonatomic)float y1;
@property(assign,nonatomic)float y2;
@property(assign,nonatomic)float y3;
@property(assign,nonatomic)float y4;
@property(assign,nonatomic)float y5;

@property(retain,nonatomic)NSString *str1;
@property(retain,nonatomic)NSString *str2;
@property(retain,nonatomic)NSString *str3;
@property(retain,nonatomic)NSString *str4;
@property(retain,nonatomic)NSString *str5;
@property(retain,nonatomic)NSString *str6;

- (IBAction)compare:(id)sender;

-(void)drowView:(float)m1 m2:(float)m2 m3:(float)m3 m4:(float)m4 m5:(float)m5;

@end
