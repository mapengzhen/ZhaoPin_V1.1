//
//  HistoryCell.m
//  Zhaopin
//
//  Created by 马朋震 /Users/ibokan/Desktop/图片/523194.gif on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell
@synthesize historySearch;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        historySearch = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 290, 30)];
        historySearch.backgroundColor = [UIColor clearColor];
        [historySearch setFont:[UIFont fontWithName:@"Georgia-Bold" size:14]];
        historySearch.frame = CGRectMake(10, 10, 290, 30);
        [historySearch setTextAlignment:UITextAlignmentLeft];
        [self.contentView addSubview:historySearch];
        [historySearch release];
        
        [self.textLabel setTextAlignment:UITextAlignmentLeft];
        [self.detailTextLabel setTextAlignment:UITextAlignmentRight];
        [self.textLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:14]];
        [self.textLabel setTextColor:[UIColor blackColor]];
        [self.detailTextLabel setFont:[UIFont fontWithName:@"Georgia-Bold" size:15]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
