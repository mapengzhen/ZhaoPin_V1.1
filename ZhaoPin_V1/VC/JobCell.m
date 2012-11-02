//
//  CellOfSearchResult.m
//  ZhilianPro
//
//  Created by 法良涛 on 12-10-10.


#import "JobCell.h"

@implementation JobCell
@synthesize jobNameLabel,dateLabel,companyLabel,cityLabel;
@synthesize leftButton;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        jobNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 0, 160, 30)];
        jobNameLabel.backgroundColor = [UIColor clearColor];
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(230, 0, 55, 30)];
        dateLabel.backgroundColor  = [UIColor clearColor];
        companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 30, 180, 30)];
        companyLabel.backgroundColor = [UIColor clearColor];
        cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(230, 30, 55, 30)];
        cityLabel.backgroundColor = [UIColor clearColor];
        
        [jobNameLabel setFont:[UIFont fontWithName:@"Arial" size:18]];
        [dateLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
        [companyLabel setFont:[UIFont fontWithName:@"Arial" size:12]];
        [cityLabel setFont:[UIFont fontWithName:@"Arial" size:10]];
        
        leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(2, 15, 30, 30);
        UIImage *image1 = [UIImage imageNamed:@"search_result_unselected.png"];
        UIImage *image2 = [UIImage imageNamed:@"search_result_selected.png"];
        [leftButton setBackgroundImage:image1 forState:UIControlStateNormal];
        [leftButton setBackgroundImage:image2 forState:UIControlStateSelected];
        [leftButton setBackgroundImage:image2 forState:UIControlStateHighlighted];
        //[leftButton setHighlighted:NO];
        //[leftButton setBackgroundImage:[UIImage imageNamed:@"search_result_selected.png"] forState:UIControlStateHighlighted];
        //[leftButton addTarget:self action:@selector(changeImage) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:cityLabel];
        [self.contentView addSubview:leftButton];
        [self.contentView addSubview:jobNameLabel];
        [self.contentView addSubview:dateLabel];
        [self.contentView addSubview:companyLabel];
        
    }
    return self;
}

- (void)dealloc {
    
    [self.jobNameLabel release];
    self.jobNameLabel = nil;
    [self.dateLabel release];
    self.dateLabel = nil;
    [self.companyLabel release];
    self.companyLabel = nil;
    [self.cityLabel release];
    self.cityLabel = nil;
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
