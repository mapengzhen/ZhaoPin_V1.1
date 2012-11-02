//
//  CollectionCell.h
//  MyZhilian
//
//  Created by Ibokan on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UITableViewCell

@property(nonatomic,retain)UILabel *titleLabel,*companyLabel,*dateLabel,*countLabel;
@property(nonatomic, retain)UIButton *btn;

@end
