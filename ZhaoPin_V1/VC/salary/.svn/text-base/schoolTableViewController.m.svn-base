//
//  schoolTableViewController.m
//  Zhaopin
//
//  Created by Ibokan on 12-10-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "schoolTableViewController.h"

@implementation schoolTableViewController

@synthesize salaryVC;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(salaryVC.experienceSwitch.on)
    {
        return salaryVC.joblevels.count;
    }
    else
    {
        return salaryVC.educations.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if(salaryVC.experienceSwitch.on)
    {
        cell.textLabel.text = [salaryVC.joblevels objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = [salaryVC.educations objectAtIndex:indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(salaryVC.experienceSwitch.on)
    {
        salaryVC.workLevelTF.text = [salaryVC.joblevels objectAtIndex:indexPath.row];
        salaryVC.workLevelID = [salaryVC.joblevelsID objectAtIndex:indexPath.row];
    }
    else
    {
        salaryVC.workLevelTF.text = [salaryVC.educations objectAtIndex:indexPath.row];
        salaryVC.workLevelID = [salaryVC.educationsID objectAtIndex:indexPath.row];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
