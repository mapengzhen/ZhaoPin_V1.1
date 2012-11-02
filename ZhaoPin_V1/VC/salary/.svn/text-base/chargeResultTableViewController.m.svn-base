//
//  chargeResultTableViewController.m
//  workGuider
//
//  Created by Ibokan on 12-10-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "chargeResultTableViewController.h"
#import "GDataXMLNode.h"
#import "DrawLineView.h"
#import <QuartzCore/QuartzCore.h>
#import "DIYMenuOptions.h"

@implementation chargeResultTableViewController
@synthesize textTF1;
@synthesize textTF2;
@synthesize salaryVC;
@synthesize y1,y2,y3,y4,y5;
@synthesize saveArr;
@synthesize saveArrID;
@synthesize stringID;
@synthesize str1,str2,str3,str4,str5,str6;
@synthesize bar;
@synthesize carousel;
@synthesize receivedData;

- (void)dealloc {
    [textTF1 release];
    [textTF2 release];
    [lowLabel release];
    [midlowLabel release];
    [midLabel release];
    [midhighLabel release];
    [highLabel release];
    [tableImageView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTextTF1:nil];
    [self setTextTF2:nil];
    [lowLabel release];
    lowLabel = nil;
    [midlowLabel release];
    midlowLabel = nil;
    [midLabel release];
    midLabel = nil;
    [midhighLabel release];
    midhighLabel = nil;
    [highLabel release];
    highLabel = nil;
    [tableImageView release];
    tableImageView = nil;
    [super viewDidUnload];
}

-(NSString *)connectWebServer
{
    //第一步,设置访问deURL
    NSURL *url = [NSURL URLWithString:@"http://mobileinterface.zhaopin.com/iphone/payquery/query.service"];
    
    //第二步,创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];//设置参数是POST,默认是GET
    
    NSString *str = nil;
    
    NSLog(@"experience=1&cityid=%@&industryid=%@&corppropertyid=%@&jobcatid=%@&joblevelid=%@&salary=%@",salaryVC.addressID,salaryVC.industryID,salaryVC.qualityID,salaryVC.workKindID,salaryVC.workLevelID,salaryVC.salaryTF.text);
    
    if(salaryVC.experienceSwitch.on)
    {
        str = [NSString stringWithFormat:@"experience=1&cityid=%@&industryid=%@&corppropertyid=%@&jobcatid=%@&joblevelid=%@&salary=%@",salaryVC.addressID,salaryVC.industryID,salaryVC.qualityID,salaryVC.workKindID,salaryVC.workLevelID,salaryVC.salaryTF.text];
    }
    else
    {
        str = [NSString stringWithFormat:@"experience=2&cityid=%@&industryid=%@&corppropertyid=%@&jobcatid=%@&educationid=%@&salary=%@",salaryVC.addressID,salaryVC.industryID,salaryVC.qualityID,salaryVC.workKindID,salaryVC.workLevelID,salaryVC.salaryTF.text];
    }
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    NSURLResponse *response = nil;
    NSError *err = nil;
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *str0 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    return str0;
}

-(void)drowPoint
{
    lowLabel.text = [newResultArr objectAtIndex:0];
    midlowLabel.text = [newResultArr objectAtIndex:1];
    midLabel.text = [newResultArr objectAtIndex:2];
    midhighLabel.text = [newResultArr objectAtIndex:3];
    highLabel.text = [newResultArr objectAtIndex:4];
    
    int low = [lowLabel.text intValue];
    low = (low/1000)*1000;
    tabelLowLabel.text = [NSString stringWithFormat:@"%d",low];
    tabelMidlowLabel.text = [NSString stringWithFormat:@"%d",low*2];
    tabelMidLabel.text = [NSString stringWithFormat:@"%d",low*3];
    tabelMidhighLabel.text = [NSString stringWithFormat:@"%d",low*4];
    tabelHighLabel.text = [NSString stringWithFormat:@"%d",low*5];
    
    y1 = [lowLabel.text floatValue]/([tabelHighLabel.text floatValue]/90);
    y2 = [midlowLabel.text floatValue]/([tabelHighLabel.text floatValue]/90);
    y3 = [midLabel.text floatValue]/([tabelHighLabel.text floatValue]/90);
    y4 = [midhighLabel.text floatValue]/([tabelHighLabel.text floatValue]/90);
    y5 = [highLabel.text floatValue]/([tabelHighLabel.text floatValue]/90);
    float y0 = [salaryVC.salaryTF.text floatValue]/([tabelHighLabel.text floatValue]/90);
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(27, 90-y1, 6, 6)];
    view1.layer.cornerRadius = 3;
    view1.backgroundColor = [UIColor blueColor];
    [tableImageView addSubview:view1];
    NSValue *value1 = [NSValue valueWithCGPoint:view1.center];
    [pointArr addObject:value1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(81, 90-y2, 6, 6)];
    view2.layer.cornerRadius = 3;
    view2.backgroundColor = [UIColor blueColor];
    [tableImageView addSubview:view2];
    NSValue *value2 = [NSValue valueWithCGPoint:view2.center];
    [pointArr addObject:value2];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(135, 90-y3, 6, 6)];
    view3.layer.cornerRadius = 3;
    view3.backgroundColor = [UIColor blueColor];
    [tableImageView addSubview:view3];
    NSValue *value3 = [NSValue valueWithCGPoint:view3.center];
    [pointArr addObject:value3];
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(189, 90-y4, 6, 6)];
    view4.layer.cornerRadius = 3;
    view4.backgroundColor = [UIColor blueColor];
    [tableImageView addSubview:view4];
    NSValue *value4 = [NSValue valueWithCGPoint:view4.center];
    [pointArr addObject:value4];
    
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(243, 90-y5, 6, 6)];
    view5.layer.cornerRadius = 3;
    view5.backgroundColor = [UIColor blueColor];
    [tableImageView addSubview:view5];
    NSValue *value5 = [NSValue valueWithCGPoint:view5.center];
    [pointArr addObject:value5];
    
    float x;
    if(y0 <= y1)
    {
        x = (int)(27*y0/y1);
    }
    else if(y0 <= y2)
    {
        x = (int)(54*(y0-y1)/(y2-y1)+27);
    }
    else if(y0 <= y3)
    {
        x = (int)(54*(y0-y2)/(y3-y2)+81);
    }
    else if(y0 <= y4)
    {
        x = (int)(54*(y0-y3)/(y4-y3)+135);
    }
    else if(y0 <= y5)
    {
        x = (int)(54*(y0-y4)/(y5-y4)+189);
    }
    else
    {
        x = (int)(27*(y0-y5)/(90-y5)+243);
        
        if (x>270)
        {
            x = 270;
        }
    }
    
    DrawLineView *lineView = [[DrawLineView alloc]initWithFrame:CGRectMake(0, 0, 270, 90)];
    lineView.backgroundColor = [UIColor clearColor];
    [lineView initWithArray:pointArr value:YES];
    [tableImageView addSubview:lineView];
    [lineView release];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 70-y0, 20, 20)];
    imageView.image = [UIImage imageNamed:@"queryFlag.png"];
    [tableImageView addSubview:imageView];
}

-(void)viewDidLoad
{
    textTF1.userInteractionEnabled = NO;
    textTF2.userInteractionEnabled = NO;
    
    self.str1 = salaryVC.addressTF.text;
    self.str2 = salaryVC.industryTF.text;
    self.str3 = salaryVC.workKindTF.text;
    self.str4 = salaryVC.qualityTF.text;
    self.str5 = salaryVC.workLevelTF.text;
    self.str6 = salaryVC.salaryTF.text;  
    
    NSLog(@"885555555%@",self.str1);
    
    pointArr = [[NSMutableArray alloc]init];
//    saveArr = [[NSMutableArray alloc]init];
//    saveArrID = [[NSMutableArray alloc]init];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem.backBarButtonItem release];
    
//    indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicatorView.center = self.tableView.center;
//    [self.view addSubview:indicatorView];
//    [indicatorView startAnimating];
    
    webStr = [self connectWebServer];
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithXMLString:webStr options:0 error:nil];//解析XML,把结果放到document中
    GDataXMLElement *root = [document rootElement];//获得根节点
    NSArray *array = [root children];
    
    resultArr = [[NSMutableArray alloc]init];
  
    GDataXMLElement *salary = [[root elementsForName:@"salary"] objectAtIndex:0];
    [resultArr addObject:[salary stringValue]];
    for(GDataXMLElement *element in array)
    {
        GDataXMLElement *name = [[element elementsForName:@"name"] objectAtIndex:0];
        if([name stringValue] != nil)
        {
           [resultArr addObject:[name stringValue]];
        }
        
        GDataXMLElement *low = [[element elementsForName:@"low"] objectAtIndex:0];
        GDataXMLElement *lownormal = [[element elementsForName:@"low-normal"] objectAtIndex:0];
        GDataXMLElement *normal = [[element elementsForName:@"normal"] objectAtIndex:0];
        GDataXMLElement *normalhigh = [[element elementsForName:@"normal-high"] objectAtIndex:0];
        GDataXMLElement *high = [[element elementsForName:@"high"] objectAtIndex:0];
        
        if([low stringValue] != nil)
        {
            newResultArr = [[NSMutableArray alloc]initWithObjects:[low stringValue],[lownormal stringValue],[normal stringValue],[normalhigh stringValue],[high stringValue], nil];
        }
    }
    
    [self drowPoint];
    
    UIFont *font = [UIFont fontWithName:MENUFONT_FAMILY size:MENUFONT_SIZE];
    
    [DIYMenu setDelegate:self];

    [DIYMenu addMenuItem:[NSString stringWithFormat:@"地区: %@",salaryVC.addressTF.text] withIcon:[UIImage imageNamed:@"address1.png"] withColor:[UIColor colorWithRed:0.18f green:0.76f blue:0.93f alpha:1.0f] withFont:font];
    [DIYMenu addMenuItem:[NSString stringWithFormat:@"行业: %@",salaryVC.industryTF.text] withIcon:[UIImage imageNamed:@"industry1.png"] withColor:[UIColor colorWithRed:0.18f green:0.76f blue:0.93f alpha:1.0f] withFont:font];
    [DIYMenu addMenuItem:[NSString stringWithFormat:@"职位类别: %@",salaryVC.workKindTF.text ] withIcon:[UIImage imageNamed:@"workKind1.png"] withColor:[UIColor colorWithRed:0.18f green:0.76f blue:0.93f alpha:1.0f] withFont:font];
    [DIYMenu addMenuItem:[NSString stringWithFormat:@"企业性质: %@",salaryVC.qualityTF.text] withIcon:[UIImage imageNamed:@"qualitry1.png"] withColor:[UIColor colorWithRed:0.18f green:0.76f blue:0.93f alpha:1.0f] withFont:font];
    
    if(salaryVC.experienceSwitch.on)
    {
        [DIYMenu addMenuItem:[NSString stringWithFormat:@"职位级别: %@",salaryVC.workLevelTF.text] withIcon:[UIImage imageNamed:@"workLevel1.png"] withColor:[UIColor colorWithRed:0.18f green:0.76f blue:0.93f alpha:1.0f] withFont:font];
        [DIYMenu addMenuItem:[NSString stringWithFormat:@"期望月薪: %@",salaryVC.salaryTF.text] withIcon:[UIImage imageNamed:@"salary1.png"] withColor:[UIColor colorWithRed:0.18f green:0.76f blue:0.93f alpha:1.0f] withFont:font];
    }
    else
    {
        [DIYMenu addMenuItem:[NSString stringWithFormat:@"学历: %@",salaryVC.workLevelTF.text] withIcon:[UIImage imageNamed:@"education1.png"] withColor:[UIColor colorWithRed:0.18f green:0.76f blue:0.93f alpha:1.0f] withFont:font];
        [DIYMenu addMenuItem:[NSString stringWithFormat:@"期望起薪: %@",salaryVC.salaryTF.text] withIcon:[UIImage imageNamed:@"salary1.png"] withColor:[UIColor colorWithRed:0.18f green:0.76f blue:0.93f alpha:1.0f] withFont:font];
    }
    
//--------------------------------------------------------------------------------
    
    UIImage *image = [UIImage imageNamed:@"red_plus_up.png"];
    UIImage *selectedImage = [UIImage imageNamed:@"red_plus_down.png"];
    UIImage *toggledImage = [UIImage imageNamed:@"red_x_up.png"];
    UIImage *toggledSelectedImage = [UIImage imageNamed:@"red_x_down.png"];
    
    CGPoint center = CGPointMake(280, 344);

    CGRect buttonFrame = CGRectMake(0, 0, 70, 30);
    
    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b1 setFrame:buttonFrame];
    [b1 setTitle:@"地区" forState:UIControlStateNormal];
    b1.tag = 0;
    [b1 addTarget:self action:@selector(onModal:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b2 setFrame:buttonFrame];
    [b2 setTitle:@"行业" forState:UIControlStateNormal];
    b2.tag = 1;
    [b2 addTarget:self action:@selector(onModal:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *b3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b3 setFrame:buttonFrame];
    [b3 setTitle:@"企业性质" forState:UIControlStateNormal];
    b3.tag = 2;
    [b3 addTarget:self action:@selector(onModal:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *b4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b4 setFrame:buttonFrame];
    [b4 setTitle:@"职位类型" forState:UIControlStateNormal];
    b4.tag = 3;
    [b4 addTarget:self action:@selector(onModal:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *b5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [b5 setFrame:buttonFrame];
    [b5 setTitle:@"职位级别" forState:UIControlStateNormal];
    b5.tag = 4;
    [b5 addTarget:self action:@selector(onModal:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *buttons = [NSArray arrayWithObjects:b1, b2, b3,b4,b5, nil];
    
    bar = [[RNExpandingButtonBar alloc] initWithImage:image selectedImage:selectedImage toggledImage:toggledImage toggledSelectedImage:toggledSelectedImage buttons:buttons center:center];
    
    [bar setDelegate:self];
    [bar setSpin:YES];
    [self setBar:bar];
    [[self view] addSubview:[self bar]];

}

- (void) onModal:(UIButton *)sender
{
    selectTag = sender.tag;
    
    [[self bar] hideButtonsAnimated:YES];
    self.textTF1.text = sender.titleLabel.text;
    
    switch (sender.tag)
    {
        case 0:
        {
            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *path1 = [docPath stringByAppendingPathComponent:@"citys.txt"];
            NSString *path2 = [docPath stringByAppendingPathComponent:@"citysID.txt"];
            self.saveArr = [[NSMutableArray alloc]initWithContentsOfFile:path1];
            self.saveArrID = [[NSMutableArray alloc]initWithContentsOfFile:path2];
            self.textTF2.text = [self.saveArr objectAtIndex:0];
            
        }
            break;
        case 1:
        {
            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *path1 = [docPath stringByAppendingPathComponent:@"industrys.txt"];
            NSString *path2 = [docPath stringByAppendingPathComponent:@"industrysID.txt"];
            self.saveArr = [[NSMutableArray alloc]initWithContentsOfFile:path1];
            self.saveArrID = [[NSMutableArray alloc]initWithContentsOfFile:path2];
            self.textTF2.text = [self.saveArr objectAtIndex:0];
        }
            break;
        case 2:
        {
            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *path1 = [docPath stringByAppendingPathComponent:@"corppropertys.txt"];
            NSString *path2 = [docPath stringByAppendingPathComponent:@"corppropertysID.txt"];
            self.saveArr = [[NSMutableArray alloc]initWithContentsOfFile:path1];
            self.saveArrID = [[NSMutableArray alloc]initWithContentsOfFile:path2];
            self.textTF2.text = [self.saveArr objectAtIndex:0];
        }
            break;
        case 3:
        {
            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *path1 = [docPath stringByAppendingPathComponent:@"jobcats.txt"];
            NSString *path2 = [docPath stringByAppendingPathComponent:@"jobcatsID.txt"];
            self.saveArr = [[NSMutableArray alloc]initWithContentsOfFile:path1];
            self.saveArrID = [[NSMutableArray alloc]initWithContentsOfFile:path2];
            self.textTF2.text = [self.saveArr objectAtIndex:0];
        }
            break;
        case 4:
        {
            if(salaryVC.switchValue == YES)
            {
                NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString *path1 = [docPath stringByAppendingPathComponent:@"joblevels.txt"];
                NSString *path2 = [docPath stringByAppendingPathComponent:@"joblevelsID.txt"];
                self.saveArr = [[NSMutableArray alloc]initWithContentsOfFile:path1];
                self.saveArrID = [[NSMutableArray alloc]initWithContentsOfFile:path2];
                self.textTF2.text = [self.saveArr objectAtIndex:0];
            }
            else
            {
                NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString *path1 = [docPath stringByAppendingPathComponent:@"educations.txt"];
                NSString *path2 = [docPath stringByAppendingPathComponent:@"educationsID.txt"];
                
                self.saveArr = [[NSMutableArray alloc]initWithContentsOfFile:path1];
                self.saveArrID = [[NSMutableArray alloc]initWithContentsOfFile:path2];
                self.textTF2.text = [self.saveArr objectAtIndex:0];
            }
            
        }
            break;
        default:
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        [DIYMenu show];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    if(indexPath.row == 5)
    {
        if(carousel == nil)
        {
            carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 250, 320, 170)];
            carousel.backgroundColor = [UIColor clearColor];
            carousel.delegate = self;
            carousel.dataSource = self;
            carousel.vertical = YES;
            carousel.type = iCarouselTypeCoverFlow2;
            
            self.tableView.scrollEnabled = NO;
            
            CATransition *animation = [CATransition animation];
            animation.duration = 0.5f;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.fillMode = kCAFillModeForwards;
            
            animation.type = kCATransitionMoveIn;
            animation.subtype = kCATransitionFromTop;
            
            [carousel.layer addAnimation:animation forKey:@"animation"];
            
            [self.view addSubview:carousel];
        }
    }
}

- (void)menuItemSelected:(NSString *)action
{
    [DIYMenu dismiss];
}
    
-(void)drowView:(float)m1 m2:(float)m2 m3:(float)m3 m4:(float)m4 m5:(float)m5
{
    if(pointArr != nil)
    {
        [pointArr removeAllObjects];
    }
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(27, 90-m1, 6, 6)];
    view1.layer.cornerRadius = 3;
    view1.backgroundColor = [UIColor blueColor];
    [tableImageView addSubview:view1];
    NSValue *value1 = [NSValue valueWithCGPoint:view1.center];
    [pointArr addObject:value1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(81, 90-m2, 6, 6)];
    view2.layer.cornerRadius = 3;
    view2.backgroundColor = [UIColor blueColor];
    [tableImageView addSubview:view2];
    NSValue *value2 = [NSValue valueWithCGPoint:view2.center];
    [pointArr addObject:value2];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(135, 90-m3, 6, 6)];
    view3.layer.cornerRadius = 3;
    view3.backgroundColor = [UIColor blueColor];
    [tableImageView addSubview:view3];
    NSValue *value3 = [NSValue valueWithCGPoint:view3.center];
    [pointArr addObject:value3];
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(189, 90-m4, 6, 6)];
    view4.layer.cornerRadius = 3;
    view4.backgroundColor = [UIColor blueColor];
    [tableImageView addSubview:view4];
    NSValue *value4 = [NSValue valueWithCGPoint:view4.center];
    [pointArr addObject:value4];
    
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(243, 90-m5, 6, 6)];
    view5.layer.cornerRadius = 3;
    view5.backgroundColor = [UIColor blueColor];
    [tableImageView addSubview:view5];
    NSValue *value5 = [NSValue valueWithCGPoint:view5.center];
    [pointArr addObject:value5];
    
}

#pragma mark -

- (void)sendRequest
{
    // 根据智联招聘提供的服务器接口，创建string，用于发送网络请求
    NSURL *url = [NSURL URLWithString:@"http://mobileinterface.zhaopin.com/iphone/payquery/comparequery.service"];
    
    //第二步,创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];//设置参数是POST,默认是GET
    
    NSString *str = nil;
    NSString *string = nil;
    switch (selectTag)
    {
        case 0:
        {
            string = @"city";
        }
            break;
        case 1:
        {
            string = @"industry";
        }
            break;
        case 2:
        {
            string =  @"corpproperty";
        }
            break;
        case 3:
        {
            string = @"jobcat";
        }
            break;
        case 4:
        {
            string = @"joblevel";
        }
            
        default:
            break;
    }
    if(salaryVC.experienceSwitch.on)
    {
        str = [NSString stringWithFormat:@"experience=1&cityid=%@&industryid=%@&corppropertyid=%@&jobcatid=%@&joblevelid=%@&salary=%@&comparetype=%@&comparevalue=%@",salaryVC.addressID,salaryVC.industryID,salaryVC.qualityID,salaryVC.workKindID,salaryVC.workLevelID,salaryVC.salaryTF.text,string,stringID];
    }
    else
    {
        str = [NSString stringWithFormat:@"experience=2&cityid=%@&industryid=%@&corppropertyid=%@&jobcatid=%@&educationid=%@&salary=%@&comparetype=%@&comparevalue=%@",salaryVC.addressID,salaryVC.industryID,salaryVC.qualityID,salaryVC.workKindID,salaryVC.workLevelID,salaryVC.salaryTF.text,string,stringID];
    }
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    //使用异步获取网络数据
    NSURLConnection  *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [request release];
    [connection release];
}

//发送网络请求失败时，执行警告
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"服务器请求失败,请重新连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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
    web = str;
    
    //移除网络状况提示视图
    //[Indicator removeIndicator:self.view];
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithXMLString:web options:0 error:nil];//解析XML,把结果放到document中
    GDataXMLElement *root = [document rootElement];//获得根节点
    NSArray *array = [root children];
    GDataXMLElement *salary = [[root elementsForName:@"salary"] objectAtIndex:0];
    [resultArr addObject:[salary stringValue]];
    GDataXMLElement *low;
    GDataXMLElement *lownormal;
    GDataXMLElement *normal;
    GDataXMLElement *normalhigh;
    GDataXMLElement *high ;
    for(GDataXMLElement *element in array)
    {
        
        low = [[element elementsForName:@"low"] objectAtIndex:0];
        lownormal = [[element elementsForName:@"low-normal"] objectAtIndex:0];
        normal = [[element elementsForName:@"normal"] objectAtIndex:0];
        normalhigh = [[element elementsForName:@"normal-high"] objectAtIndex:0];
        high = [[element elementsForName:@"high"] objectAtIndex:0];
        
    }
    
    ny1 = [[low stringValue] floatValue]/([tabelHighLabel.text floatValue]/90);
    ny2 = [[lownormal stringValue] floatValue]/([tabelHighLabel.text floatValue]/90);
    ny3 = [[normal stringValue] floatValue]/([tabelHighLabel.text floatValue]/90);
    ny4 = [[normalhigh stringValue] floatValue]/([tabelHighLabel.text floatValue]/90);
    ny5 = [[high stringValue] floatValue]/([tabelHighLabel.text floatValue]/90);
    
    tabelLow = [[UILabel alloc]initWithFrame:CGRectMake(7, 60-ny1, 50, 30)];
    tabelLow.backgroundColor = [UIColor clearColor];
    //    tabelLow.font = [UIFont fontWithName:@"ThonBuri-Bold" size:5];
    tabelMidlow = [[UILabel alloc]initWithFrame:CGRectMake(61, 60-ny2, 50, 30)];
    tabelMidlow.backgroundColor = [UIColor clearColor];
    tabelMid = [[UILabel alloc]initWithFrame:CGRectMake(115, 60-ny3, 50, 30)];
    tabelMid.backgroundColor = [UIColor clearColor];
    tabelMidhigh = [[UILabel alloc]initWithFrame:CGRectMake(169, 60-ny4, 50, 30)];
    tabelMidhigh.backgroundColor = [UIColor clearColor];
    tabelHigh = [[UILabel alloc]initWithFrame:CGRectMake(223, 60-ny5, 50, 30)];
    tabelHigh.backgroundColor = [UIColor clearColor];    
    
    tabelLow.textColor = [UIColor redColor];
    tabelMidlow.textColor = [UIColor redColor];
    tabelMid.textColor = [UIColor redColor];
    tabelMidhigh.textColor = [UIColor redColor];
    tabelHigh.textColor = [UIColor redColor];
    
    tabelLow.text = [low stringValue];
    tabelMidlow.text = [lownormal stringValue];
    tabelMid.text = [normal stringValue];
    tabelMidhigh.text = [normalhigh stringValue];
    tabelHigh.text = [high stringValue];
    
    [tableImageView addSubview:tabelLow];
    [tableImageView addSubview:tabelMidlow];
    [tableImageView addSubview:tabelMid];
    [tableImageView addSubview:tabelMidhigh];
    [tableImageView addSubview:tabelHigh];
    
    NSMutableArray *newPointArr = [[NSMutableArray alloc]init];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(27, 90-ny1, 6, 6)];
    view1.layer.cornerRadius = 3;
    view1.backgroundColor = [UIColor redColor];
    [tableImageView addSubview:view1];
    NSValue *value1 = [NSValue valueWithCGPoint:view1.center];
    [newPointArr addObject:value1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(81, 90-ny2, 6, 6)];
    view2.layer.cornerRadius = 3;
    view2.backgroundColor = [UIColor redColor];
    [tableImageView addSubview:view2];
    NSValue *value2 = [NSValue valueWithCGPoint:view2.center];
    [newPointArr addObject:value2];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(135, 90-ny3, 6, 6)];
    view3.layer.cornerRadius = 3;
    view3.backgroundColor = [UIColor redColor];
    [tableImageView addSubview:view3];
    NSValue *value3 = [NSValue valueWithCGPoint:view3.center];
    [newPointArr addObject:value3];
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(189, 90-ny4, 6, 6)];
    view4.layer.cornerRadius = 3;
    view4.backgroundColor = [UIColor redColor];
    [tableImageView addSubview:view4];
    NSValue *value4 = [NSValue valueWithCGPoint:view4.center];
    [newPointArr addObject:value4];
    
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(243, 90-ny5, 6, 6)];
    view5.layer.cornerRadius = 3;
    view5.backgroundColor = [UIColor redColor];
    [tableImageView addSubview:view5];
    NSValue *value5 = [NSValue valueWithCGPoint:view5.center];
    [newPointArr addObject:value5];
    
    NSLog(@"%f-%f-%f-%f-%f",y1,y2,y3,y4,y5);
    NSLog(@"%f-%f-%f-%f-%f",ny1,ny2,ny3,ny4,ny5);
    
    DrawLineView *newLineView = [[DrawLineView alloc]initWithFrame:CGRectMake(0, 0, 270, 90)];
    newLineView.backgroundColor = [UIColor clearColor];
    [newLineView initWithArray:newPointArr value:NO];
    [tableImageView addSubview:newLineView];
    [newLineView release];
    [newPointArr release];
}

- (IBAction)compare:(id)sender 
{
    //发送网络请求
    [self sendRequest];
    // 显示网络状况提示视图
    //[Indicator addIndicator:self.view];
}

-(void)chargeResultTableViewControllerDidBack:(id)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 320, 50);
    button.showsTouchWhenHighlighted = YES;
    button.alpha = 0.8;
    [button setTitle:[self.saveArr objectAtIndex:index] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"button.jpg"] forState:UIControlStateNormal];
    button.titleLabel.font = [button.titleLabel.font fontWithSize:23];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = index;
    
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
    return self.saveArr.count;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 70;
}

- (CGFloat)carousel:(iCarousel *)carousel itemAlphaForOffset:(CGFloat)offset
{
	//set opacity based on distance from camera
    return 1.0f - fminf(fmaxf(offset, 0.0f), 1.0f);
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (void)buttonTapped:(UIButton *)sender
{
    self.stringID = [self.saveArrID objectAtIndex:sender.tag];
    
    self.tableView.scrollEnabled = YES;
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [carousel removeFromSuperview];

    [carousel release];
    carousel = nil;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)currentCarousel
{
    self.textTF2.text = [self.saveArr objectAtIndex:currentCarousel.currentItemIndex];
}

-(BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return NO;
}

@end
