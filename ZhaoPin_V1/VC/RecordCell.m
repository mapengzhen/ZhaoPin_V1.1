//
//  RecordCell.m
//  Position-record
//
//  Created by Ibokan on 12-10-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell

@synthesize titleLabel,companyLabel,dateLabel,countLabel;

-(void)dealloc
{
    [titleLabel release];
    [companyLabel release];
    [dateLabel release];
    [countLabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 17)];
        titleLabel.highlightedTextColor = [UIColor blackColor];
        titleLabel.font = [UIFont fontWithName:@"Arial" size:16.0];
        [self.contentView addSubview:titleLabel];
        
        companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 200, 20)];
        companyLabel.highlightedTextColor = [UIColor blackColor];
        companyLabel.font = [UIFont fontWithName:@"Arial" size:12.0];
        companyLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:companyLabel];
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 10, 90, 17)];
        dateLabel.highlightedTextColor = [UIColor blackColor];
        dateLabel.textColor = [UIColor grayColor];
        dateLabel.textAlignment = UITextAlignmentRight;
        dateLabel.font = [UIFont fontWithName:@"Arial" size:12.0];        
        [self.contentView addSubview:dateLabel];
        
        countLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 30, 90, 20)];
        countLabel.highlightedTextColor = [UIColor blackColor];
        countLabel.textColor = [UIColor grayColor];
        countLabel.textAlignment = UITextAlignmentRight;
        countLabel.font = [UIFont fontWithName:@"Arial" size:12.0];        
        [self.contentView addSubview:countLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
