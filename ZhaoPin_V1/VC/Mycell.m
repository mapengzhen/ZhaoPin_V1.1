//
//  Mycell.m
//  day9-30SearchJobViewController
//
//  Created by Ibokan on 12-10-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Mycell.h"

@implementation Mycell
@synthesize btn =_btn;
@synthesize labelCompany = _labelCompany,labelDate = _labelDate,labelTitle = _labelTitle,labelAddress = _labelAddress;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //选中标识，设为一个button
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.selected = NO;
        [self.btn setBackgroundImage:[UIImage imageNamed:@"search_result_unselected@2x.png"] forState:UIControlStateNormal];
        [self.btn setBackgroundImage:[UIImage imageNamed:@"search_result_selected@2x.png"] forState:UIControlStateSelected];
        self.btn.frame = CGRectMake(10, 15, 20, 20);
        //[self.btn addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
        //工作名字
        self.labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(35, 5, 160, 15)];
        self.labelTitle.backgroundColor = [UIColor clearColor];
        //self.labelTitle.text = @"hello";
        self.labelTitle.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:self.labelTitle];
        //公司名称
        self.labelCompany = [[UITextField alloc]initWithFrame:CGRectMake(35, 20, 160, 15)];
        self.labelCompany.backgroundColor = [UIColor clearColor];
        self.labelCompany.font = [UIFont boldSystemFontOfSize:12];
        
        self.labelCompany.userInteractionEnabled = NO;
        [self addSubview:self.labelCompany];
        //日期
        self.labelDate = [[UITextField alloc]initWithFrame:CGRectMake(220, 5, 60, 15)];
        self.labelDate.backgroundColor = [UIColor clearColor];
        self.labelDate.font = [UIFont boldSystemFontOfSize:10];
        self.labelDate.userInteractionEnabled = NO;
        [self addSubview:self.labelDate];
        //地址
        self.labelAddress = [[UITextField alloc]initWithFrame:CGRectMake(220, 20, 100, 15)];
        self.labelAddress.backgroundColor = [UIColor clearColor];
        self.labelAddress.userInteractionEnabled = NO;
        self.labelAddress.font = [UIFont boldSystemFontOfSize:10];
        [self addSubview:self.labelAddress];
    }
    return self;
}
-(void)changeImage:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
