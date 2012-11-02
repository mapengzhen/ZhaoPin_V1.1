//
//  salaryChargeTableViewController.m
//  workGuider
//
//  Created by Ibokan on 12-10-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "salaryChargeTableViewController.h"
#import "chargeResultTableViewController.h"
#import "GDataXMLNode.h"
#import "schoolTableViewController.h"

@implementation salaryChargeTableViewController

@synthesize salaryTF;
@synthesize addressTF;
@synthesize industryTF;
@synthesize qualityTF;
@synthesize workKindTF;
@synthesize workLevelTF;
@synthesize workLevel;
@synthesize money;
@synthesize experienceSwitch;
@synthesize addressID,industryID,qualityID,workKindID,workLevelID;
@synthesize switchValue;
@synthesize netStr;
@synthesize receivedData;
@synthesize citys,citysID;
@synthesize carousel;
@synthesize industrys,industrysID,corppropertys,corppropertysID,jobcats,jobcatsID,joblevels,joblevelsID,educations,educationsID;

- (void)viewDidUnload
{
    [self setSalaryTF:nil];

    [chargeButton release];
    chargeButton = nil;   
    [tableV release];
    tableV = nil;
    [self setExperienceSwitch:nil];
    [self setWorkLevel:nil];
    [self setMoney:nil];
    [self setAddressTF:nil];
    [self setIndustryTF:nil];
    [self setQualityTF:nil];
    [self setWorkKindTF:nil];
    [self setWorkLevelTF:nil];
    [super viewDidUnload];
}

- (void)sendRequest
{
    // 根据智联招聘提供的服务器接口，创建string，用于发送网络请求
    NSURL *url = [NSURL URLWithString:@"http://mobileinterface.zhaopin.com/iphone/payquery/querylist.service"];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [url release];
    //使用异步获取网络数据
    NSURLConnection  *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [request release];
    [connection release];
}

//发送网络请求失败时，执行警告
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"服务器请求失败,请重新连接" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}
//服务器响应请求,初始化存放xml数据的receivedData
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)reponse
{
    receivedData = [[NSMutableData alloc]init];
}
//接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}
//完成数据接收,设置文章视图显示的内容
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *str = [[NSString alloc]initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    netStr = str;
    
    //移除网络状况提示视图
    //[Indicator removeIndicator:self.view];
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithXMLString:netStr options:0 error:nil];//解析XML,把结果放到document中
    GDataXMLElement *root = [document rootElement];//获得根节点
    
    citys = [[NSMutableArray alloc]init];
    citysID = [[NSMutableArray alloc]init];
    GDataXMLElement *city = [[root elementsForName:@"citys"] objectAtIndex:0];
    NSArray *array = [city children];
    for(GDataXMLElement *element in array)
    {
        GDataXMLElement *name = [[element elementsForName:@"name"] objectAtIndex:0];
        GDataXMLElement *id = [[element elementsForName:@"id"] objectAtIndex:0];
        [citys addObject:[name stringValue]];
        [citysID addObject:[id stringValue]];
    }
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"%@",docPath);
    NSString *path1 = [docPath stringByAppendingPathComponent:@"citys.txt"];
    NSString *path2 = [docPath stringByAppendingPathComponent:@"citysID.txt"];
    [citys writeToFile:path1 atomically:YES];
    [citysID writeToFile:path2 atomically:YES];
    
    industrys = [[NSMutableArray alloc]init];
    industrysID = [[NSMutableArray alloc]init];
    GDataXMLElement *indus = [[root elementsForName:@"industrys"] objectAtIndex:0];
    array = [indus children];
    for(GDataXMLElement *element in array)
    {
        GDataXMLElement *name = [[element elementsForName:@"name"] objectAtIndex:0];
        GDataXMLElement *id = [[element elementsForName:@"id"] objectAtIndex:0];
        [industrys addObject:[name stringValue]];
        [industrysID addObject:[id stringValue]];
    }
    
    path1 = [docPath stringByAppendingPathComponent:@"industrys.txt"];
    path2 = [docPath stringByAppendingPathComponent:@"industrysID.txt"];
    [industrys writeToFile:path1 atomically:YES];
    [industrysID writeToFile:path2 atomically:YES];
    
    corppropertys = [[NSMutableArray alloc]init];
    corppropertysID = [[NSMutableArray alloc]init];
    GDataXMLElement *cors = [[root elementsForName:@"corppropertys"] objectAtIndex:0];
    array = [cors children];
    for(GDataXMLElement *element in array)
    {
        GDataXMLElement *name = [[element elementsForName:@"name"] objectAtIndex:0];
        GDataXMLElement *id = [[element elementsForName:@"id"] objectAtIndex:0];
        [corppropertys addObject:[name stringValue]];
        [corppropertysID addObject:[id stringValue]];
    }
    
    path1 = [docPath stringByAppendingPathComponent:@"corppropertys.txt"];
    path2 = [docPath stringByAppendingPathComponent:@"corppropertysID.txt"];
    [corppropertys writeToFile:path1 atomically:YES];
    [corppropertysID writeToFile:path2 atomically:YES];
    
    jobcats = [[NSMutableArray alloc]init];
    jobcatsID = [[NSMutableArray alloc]init];
    GDataXMLElement *jobcas = [[root elementsForName:@"jobcats"] objectAtIndex:0];
    array = [jobcas children];
    for(GDataXMLElement *element in array)
    {
        GDataXMLElement *name = [[element elementsForName:@"name"] objectAtIndex:0];
        GDataXMLElement *id = [[element elementsForName:@"id"] objectAtIndex:0];
        [jobcats addObject:[name stringValue]];
        [jobcatsID addObject:[id stringValue]];
    }

    path1 = [docPath stringByAppendingPathComponent:@"jobcats.txt"];
    path2 = [docPath stringByAppendingPathComponent:@"jobcatsID.txt"];
    [jobcats writeToFile:path1 atomically:YES];
    [jobcatsID writeToFile:path2 atomically:YES];
    
    joblevels = [[NSMutableArray alloc]init];
    joblevelsID = [[NSMutableArray alloc]init];
    GDataXMLElement *jobleves = [[root elementsForName:@"joblevels"] objectAtIndex:0];
    array = [jobleves children];
    for(GDataXMLElement *element in array)
    {
        GDataXMLElement *name = [[element elementsForName:@"name"] objectAtIndex:0];
        GDataXMLElement *id = [[element elementsForName:@"id"] objectAtIndex:0];
        [joblevels addObject:[name stringValue]];
        [joblevelsID addObject:[id stringValue]];
    }
    
    path1 = [docPath stringByAppendingPathComponent:@"joblevels.txt"];
    path2 = [docPath stringByAppendingPathComponent:@"joblevels.txt"];
    [joblevels writeToFile:path1 atomically:YES];
    [joblevelsID writeToFile:path2 atomically:YES];
    
    educations = [[NSMutableArray alloc]init];
    educationsID = [[NSMutableArray alloc]init];
    GDataXMLElement *edus = [[root elementsForName:@"educations"] objectAtIndex:0];
    array = [edus children];
    for(GDataXMLElement *element in array)
    {
        GDataXMLElement *name = [[element elementsForName:@"name"] objectAtIndex:0];
        GDataXMLElement *id = [[element elementsForName:@"id"] objectAtIndex:0];
        [educations addObject:[name stringValue]];
        [educationsID addObject:[id stringValue]];
    }
    
    path1 = [docPath stringByAppendingPathComponent:@"educations.txt"];
    path2 = [docPath stringByAppendingPathComponent:@"educationsID.txt"];
    [educations writeToFile:path1 atomically:YES];
    [educationsID writeToFile:path2 atomically:YES];
    
}

-(void)viewDidLoad
{
    tableV.delegate = self;
    tableV.dataSource = self;
    
    self.navigationController.navigationBar.hidden = NO;
    
    tableV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture.png"]];
    
    addressTF.userInteractionEnabled = NO;
    industryTF.userInteractionEnabled = NO;
    qualityTF.userInteractionEnabled = NO;
    workLevelTF.userInteractionEnabled = NO;
    workKindTF.userInteractionEnabled = NO;
    
    salaryTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    [experienceSwitch addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    
    //发送网络请求
    [self sendRequest];
    // 显示网络状况提示视图
    //[Indicator addIndicator:self.view];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭键盘" style:UIBarButtonItemStyleDone target:self action:@selector(keyboardBack)];
    [toolBar setItems:[NSArray arrayWithObjects:spaceItem,doneItem, nil]];
    salaryTF.inputAccessoryView = toolBar;
    
}

-(void)keyboardBack
{
    [salaryTF resignFirstResponder];
}

-(void)change:(UISwitch *)sender
{
    if(sender.on)
    {
        workLevel.text = @"职位级别";
        money.text = @"期望月薪";
        workLevelTF.text = nil;
        salaryTF.text = nil;
        workLevelTF.placeholder = @"请选择职位级别";
        
        switchValue = YES;
    }
    else
    {
        workLevel.text = @"学历";
        money.text = @"期望起薪";
        workLevelTF.text = nil;
        salaryTF.text = nil;
        workLevelTF.placeholder = @"请选择学历";
        
        switchValue = NO;
    }
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc]initWithFrame:tableV.tableHeaderView.bounds];
//    view.backgroundColor = [UIColor clearColor];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, -10, 320, 40)];
//    label.text = @"选择薪酬查询条件";
//    label.font = [UIFont fontWithName:@"ThonBuri-Bold" size:20];
//    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor blackColor];
//    [view addSubview:label];
//    return view;
//    [view release];
//    [label release];
//    
//}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        NSString *name = @"选择薪酬查询条件";
        return name;
    }
    return NULL;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if(indexPath.row > 0 && indexPath.row < 5)
    {
        selectRow = indexPath.row;
        
        if(carousel == nil)
        {
            carousel = [[[iCarousel alloc]initWithFrame:CGRectMake(0, 170, 100, 50)]autorelease];
            carousel.backgroundColor = [UIColor clearColor];
            carousel.delegate = self;
            carousel.dataSource = self;
            carousel.vertical = YES;
            carousel.type = iCarouselTypeCylinder;
            
            tableV.scrollEnabled = NO;
            
            CATransition *animation = [CATransition animation];
            animation.duration = 0.5f;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.fillMode = kCAFillModeForwards;
            
            animation.type = kCATransitionMoveIn;
            animation.subtype = kCATransitionFromLeft;
            
            [carousel.layer addAnimation:animation forKey:@"animation"];
            
            [self.view addSubview:carousel];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem.backBarButtonItem release];
    
    if([segue.identifier isEqualToString:@"result"])
    {
        chargeResultTableViewController *chargeR = segue.destinationViewController;
        chargeR.salaryVC = self;
    }
    
    if([segue.identifier isEqualToString:@"five"])
    {
        schoolTableViewController *schoolVC = segue.destinationViewController;
        schoolVC.salaryVC = self;
    }
}

- (void)dealloc 
{
    [salaryTF release];
    [chargeButton release];
    [tableV release];
    [experienceSwitch release];
    [workLevel release];
    [money release];
    [addressTF release];
    [industryTF release];
    [qualityTF release];
    [workKindTF release];
    [workLevelTF release];
    [carousel release];
    
    [super dealloc];
}

#pragma mark -

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.showsTouchWhenHighlighted = YES;
    button.alpha = 0.9;
    [button setBackgroundImage:[UIImage imageNamed:@"button.jpg"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = index;
    
    switch (selectRow)
    {
        case 1:
        {
            [button setTitle:[self.citys objectAtIndex:index] forState:UIControlStateNormal];
            button.frame = CGRectMake(0, 0, 70, 40);
            button.titleLabel.font = [button.titleLabel.font fontWithSize:17];
        }
            break;
        case 2:
        {
            [button setTitle:[self.industrys objectAtIndex:index] forState:UIControlStateNormal];
            button.frame = CGRectMake(80, 0, 120, 40);
            button.titleLabel.font = [button.titleLabel.font fontWithSize:15];
        }
            break;
        case 3:
        {
            [button setTitle:[self.corppropertys objectAtIndex:index] forState:UIControlStateNormal];
            button.frame = CGRectMake(40, 0, 100, 60);
            button.titleLabel.font = [button.titleLabel.font fontWithSize:15];
        }
            break;
        case 4:
        {
            [button setTitle:[self.jobcats objectAtIndex:index] forState:UIControlStateNormal];
            button.frame = CGRectMake(20, 0, 100, 40);
            button.titleLabel.font = [button.titleLabel.font fontWithSize:17];
        }
            break;
        default:
            break;
    }
    
    return button;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	return 0;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return 25;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    
    switch (selectRow)
    {
        case 1:
        {
            return self.citys.count;
        }
            break;
        case 2:
        {
            return self.industrys.count;
        }
            break;
        case 3:
        {
            return self.corppropertys.count;
        }
            break;
        case 4:
        {
            return self.jobcats.count;
        }
            break;
        default:
        {
            return 0;
        }
            break;
    }
    
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    switch (selectRow)
    {
        case 1:
        {
            return 50;
        }
            break;
        case 2:
        {
            return 50;
        }
            break;
        case 3:
        {
            return 100;
        }
            break;
        case 4:
        {
            return 60;
        }
            break;
        default:
        {
            return 0;
        }
            break;
    }
}

- (CGFloat)carousel:(iCarousel *)carousel itemAlphaForOffset:(CGFloat)offset
{
    return 1.0f - fminf(fmaxf(offset, 0.0f), 1.0f);
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (void)buttonTapped:(UIButton *)sender
{
    switch (selectRow)
    {
        case 1:
        {
            self.addressID = [self.citysID objectAtIndex:sender.tag];
        }
            break;
        case 2:
        {
            self.industryID = [self.industrysID objectAtIndex:sender.tag];
        }
            break;
        case 3:
        {
            self.qualityID = [self.corppropertysID objectAtIndex:sender.tag];
        }
            break;
        case 4:
        {
            self.workKindID = [self.jobcatsID objectAtIndex:sender.tag];
        }
            break;
        default:
            break;
    }
        
    tableV.scrollEnabled = YES;
    
    NSIndexPath *indexPath = [tableV indexPathForSelectedRow];
    
    [tableV deselectRowAtIndexPath:indexPath animated:YES];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
    
    [carousel.layer addAnimation:animation forKey:@"animation"];
    
    [carousel removeFromSuperview];
    carousel = nil;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)currentCarousel
{
    switch (selectRow)
    {
        case 1:
        {
            self.addressTF.text = [self.citys objectAtIndex:currentCarousel.currentItemIndex];
        }
            break;
        case 2:
        {
            self.industryTF.text = [self.industrys objectAtIndex:currentCarousel.currentItemIndex];
        }
            break;
        case 3:
        {
            self.qualityTF.text = [self.corppropertys objectAtIndex:currentCarousel.currentItemIndex];
        }
            break;
        case 4:
        {
            self.workKindTF.text = [self.jobcats objectAtIndex:currentCarousel.currentItemIndex];
        }
            break;
        default:
            break;
    }
}

-(BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return YES;
}

@end
