//
//  CollectionCell.m
//  MyZhilian
//
//  Created by Ibokan on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CollectionCell.h"
#import "PrettyKit.h"

@implementation CollectionCell
@synthesize titleLabel,companyLabel,dateLabel,countLabel,btn;




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.frame = CGRectMake(5, 5, 40, 40);
        self.btn.selected = NO;
        [self.contentView addSubview:self.btn];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 160, 17)];
        self.titleLabel.highlightedTextColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel release];
        
        self.companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 160, 20)];
        self.companyLabel.highlightedTextColor = [UIColor blackColor];
        self.companyLabel.font = [UIFont fontWithName:@"Arial" size:12.0];
        self.companyLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.companyLabel];
        [self.companyLabel release];
        
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 10, 90, 17)];
        self.dateLabel.highlightedTextColor = [UIColor blackColor];
        self.dateLabel.textColor = [UIColor grayColor];
       self.dateLabel.textAlignment = UITextAlignmentRight;
        self.dateLabel.font = [UIFont fontWithName:@"Arial" size:12.0];        
        [self.contentView addSubview:self.dateLabel];
        [self.dateLabel release];
        
        self.countLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 30, 90, 20)];
        self.countLabel.highlightedTextColor = [UIColor blackColor];
        self.countLabel.textColor = [UIColor grayColor];
        self.countLabel.textAlignment = UITextAlignmentRight;
        self.countLabel.font = [UIFont fontWithName:@"Arial" size:12.0];        
        [self.contentView addSubview:self.countLabel];
        [self.countLabel release];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
