//
//  currentRecommendViewController.m
//  Zhaopin
//
//  Created by Ibokan on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "currentRecommendViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "Mycell.h"
#import "GDataXMLNode.h"
#import "morejoblistViewcontroller.h"
#import "LeveyHUD.h"
#import "JobDetailVC.h"
#import "LeveyHUD.h"

@implementation currentRecommendViewController
@synthesize MytableView=_MytableView;
@synthesize MyScorllView = _MyScorllView;
@synthesize root = _root;
@synthesize uiticket = _uiticket;
@synthesize titleArray =_titleArray;


- (IBAction)back:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)apply:(id)sender
{
    [[LeveyHUD sharedHUD] appearWithText:@"职位申请中..."];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(removeAlertView) userInfo:nil repeats:NO];
}

#pragma mark - 移除警告提示视图

- (void)removeAlertView
{
    [[LeveyHUD sharedHUD] delayDisappear:1 withText:@"申请成功"]; 
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - MD5
- (NSString *) getMD5String:(NSString *)url {
	
	NSDate *date = [NSDate date];
	NSTimeInterval timeInterval = [date timeIntervalSince1970];
	NSString *paramT = [NSString stringWithFormat:@"%f", timeInterval];
	
	NSString *md5src = [NSString stringWithFormat:@"%fA42F7167-6DB0-4A54-84D4-789E591C31DA", timeInterval];
	NSString *md5Result = [self md5:md5src];
	NSLog(@"md5:%@", md5Result);
	
	NSString *result = nil;
	if (NSNotFound == [url rangeOfString:@"?"].location) {
		//result = [NSString stringWithFormat:@"?t=%@&e=%@", paramT, md5Result];
        result = [NSString stringWithFormat:@"%@?t=%@&e=%@&f=p&d=%@",url, paramT, md5Result,md5src];
        NSLog(@"%@",result);
	}else {
		//result = [NSString stringWithFormat:@"&t=%@&e=%@", paramT, md5Result];
        result = [NSString stringWithFormat:@"%@&t=%@&e=%@&f=p&d=%@",url, paramT, md5Result,md5src];
        NSLog(@"%@",result);
	}
	
	return result;
	
}

-(NSString *)md5:(NSString *)str { 
    const char *cStr = [str UTF8String]; 
    unsigned char result[32]; 
    CC_MD5( cStr, strlen(cStr), result ); 
    return [NSString stringWithFormat: 
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], 
            result[4], result[5], result[6], result[7], 
            result[8], result[9], result[10], result[11], 
            result[12], result[13], result[14], result[15] 
            ]; 
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void)getUticket  //获取身份标识
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"user.txt"];   
    NSDictionary *userDic = [NSDictionary dictionaryWithContentsOfFile:filePath];  
    self.uiticket = [userDic objectForKey:@"uticket"];
    [self.uiticket retain];
}

//实现发送网络请求的方法
- (void)sendRequest
{
    [self getUticket];
    NSString *string = [[NSString alloc]initWithFormat:@"http://wapinterface.zhaopin.com/iphone/job/recommendjob.aspx?uticket=%@&pagesize=15&page=1",self.uiticket];//self.uiticlet
    NSString *strUIrl = [self getMD5String:string];
    NSURL *url = [[NSURL alloc]initWithString:strUIrl];
    
    [string release];
    // 发送网络请求的方式有很多，具体哪一个更好，还需要测试
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [url release];
    //使用异步获取网络数据，方法有两种，到底该用哪一种需要测试
    NSURLConnection  *_connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [request release];
    [_connection release];
    
    NSLog(@"sendrequest");
}
//实现设置view的内容的方法
- (void)setViewContent
{
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:_data options:0 error:nil];
    self.root = [document rootElement];//根节点
    numberOfRows = [NSMutableArray arrayWithArray:[self.root nodesForXPath:@"//positionlist" error:nil]];
    numberOfSection = [NSMutableArray arrayWithArray:[self.root nodesForXPath:@"//applyjob" error:nil]];
    //设置view的内容    
    [self.MytableView reloadData];
    [_data release];
}
#pragma mark - 网络连接异步代理
//发送网络请求失败时，执行的方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[LeveyHUD sharedHUD] disappear];

}
//服务器响应请求,初始化存放xml数据的_data
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)reponse
{
    
    _data = [[NSMutableData alloc]init];
}
//接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}
//完成数据接收,设置文章视图显示的内容
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //移除网络状况提示视图
    //[Indicator removeIndicator:self.view];
    [[LeveyHUD sharedHUD] disappear];
    NSLog(@"%s  %d",__FUNCTION__,__LINE__);
    [self setViewContent];
}

#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewwillappear");
    //发送网络请求
    //[self sendRequest];
    //c初始化jobnumberDictionay
    jobnumberDictionay = [[NSMutableDictionary alloc] initWithCapacity:10];
    jobDictionary=[[NSMutableDictionary alloc] initWithCapacity:10];
    jobArray = [[NSMutableArray alloc]init ];
    NEWJobArray = [[NSMutableArray alloc]init ];
    self.titleArray = [[NSMutableArray alloc]init ];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[Indicator addIndicator:self.MytableView];
    
    [[LeveyHUD sharedHUD] appearWithText:@"数据加载中..."];
    [self performSelector:@selector(sendRequest) withObject:self afterDelay:0.5];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
 
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.navigationItem.title = @"实时推荐";

    self.MytableView.tag = 110;
    self.MytableView.delegate = self;
    self.MytableView.dataSource = self;
    detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(320, 40, 320, 416) style:UITableViewStylePlain];
    detailTableView.backgroundView=(UIView *)[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"centerBackground@2x.png"]];
    detailTableView.backgroundColor = [UIColor clearColor];
   [self.MyScorllView addSubview:detailTableView];
    detailTableView.tag = 111;
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    
    self.MyScorllView.contentSize = CGSizeMake(320*2, 416);
    self.MyScorllView.pagingEnabled = YES;
    self.MyScorllView.backgroundColor = [UIColor blueColor];
    self.MyScorllView.delegate = self;
    
    pageControl = [[[UIPageControl alloc]initWithFrame:CGRectMake(0, 350, 320, 30)]autorelease];
    pageControl.currentPage = 0;
    pageControl.numberOfPages = 2;
    //pageControl.backgroundColor = [UIColor redColor];
    [pageControl addTarget:self action:@selector(changeOffSet:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview: pageControl];
}
-(void)changeOffSet:(UIPageControl *)p
{
    int x = p.currentPage*320;
    
    [self.MyScorllView setContentOffset:CGPointMake(x, 0) animated:YES];
    
    
}
//UIscorllView的协议方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    int page = scrollView.contentOffset.x/320;
    pageControl.currentPage = page;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        
    if (tableView.tag==110) {
        if ([numberOfSection count]!=0) {
            return [numberOfSection count];
        }
    }
        
        return 1;
    
    
       
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    //定义一个view
//    UIView *titleview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    titleview.backgroundColor = [UIColor clearColor];
//    
//    //加一个textview加载信息
//    UITextView *test = [[[UITextView alloc]initWithFrame:titleview.frame]autorelease];
//    test.backgroundColor = [UIColor clearColor];
//    [titleview addSubview:test];
//    test.userInteractionEnabled = NO;
//    
//    test.editable = NO;
//    //[test setFont:[UIFont fontWithName:nil size:10]];
//    test.font = [UIFont boldSystemFontOfSize:16];
//    test.textAlignment = UITextAlignmentCenter;
//    if (tableView.tag==110) {
//        
//    
//        NSArray *arr = [self.root nodesForXPath:@"//applyjob" error:nil];
//        if ([arr count]!=0) {
//            GDataXMLElement *applyjob = [[self.root nodesForXPath:@"//applyjob" error:nil]objectAtIndex:section];
//            GDataXMLElement*job = [[applyjob elementsForName:@"job"]objectAtIndex:0];
//            GDataXMLElement *job_title = [[job elementsForName:@"job_title"]objectAtIndex:0];
//            NSString *str = [[NSString alloc]initWithFormat:@"你已经选择（%@），为你推荐以下职位：",[job_title stringValue]];
//            test.text = str;
//        }else{
//            test.text = @"根据你的求职意愿为你推荐如下职位";
//        }
//    }if (tableView.tag==111) {
//       
//        
//        test.text =[NSString stringWithFormat: @"你已经申请了如下(%d)个职位：",[jobArray count]];
//        
//    }
//    
//   
//        
//    return titleview;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag==110) {
        if ([numberOfRows count]!=0) {
            
            return [[[numberOfRows objectAtIndex:section ]children] count];
        }
    }
    if (tableView.tag==111) {
        if ([jobArray count]!=0) {
            return [jobArray count];
        }
        return 15;
    }
        return 1;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //选择职位的tableview
    if (tableView1.tag==111) {
        UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) 
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        if ([jobArray count]!=0) {
            cell.textLabel.text = [jobArray objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
        }
        NSString *str = [[NSBundle mainBundle]pathForResource:@"accessoryArrow@2x" ofType:@"png"];
        UIImage *iamgeV = [UIImage imageWithContentsOfFile:str];
        cell.accessoryView = (UIView *)[[UIImageView alloc]initWithImage:iamgeV];
        return cell;
        
    }
        
    //shi实时推荐的tableView
    Mycell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[Mycell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //当用户没有填写申请职位意向，弹出
    NSArray *message = [self.root nodesForXPath:@"//message" error:nil];
    
    if ([message count]!=0) {
        GDataXMLElement *message = [[self.root nodesForXPath:@"//message" error:nil]objectAtIndex:0];
        UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"提示..." message:[message stringValue] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alet show];
    }
    
    //用户已登录，并填写多个求职意向
    //qu取工作，公司，时间等值，进行赋值
    
    NSArray *arr = [self.root nodesForXPath:@"//applyjob" error:nil];
    if ([arr count]!=0) {
        GDataXMLElement *applyjob = [[self.root nodesForXPath:@"//applyjob" error:nil]objectAtIndex:indexPath.section];
        GDataXMLElement *positionlist = [[applyjob elementsForName:@"positionlist"]objectAtIndex:0];
        GDataXMLElement *position = [[positionlist elementsForName:@"position"]objectAtIndex:indexPath.row];
        GDataXMLElement *name = [[position elementsForName:@"company_name"]objectAtIndex:0];
        GDataXMLElement *titlt = [[position elementsForName:@"job_title"]objectAtIndex:0];
        GDataXMLElement *date = [[position elementsForName:@"opening_date"]objectAtIndex:0];
        GDataXMLElement *city = [[position elementsForName:@"job_city"]objectAtIndex:0];
        GDataXMLElement *jobnumber = [[position elementsForName:@"job_number"]objectAtIndex:0];
        //把job_number加入到jobmuberdictionary
        [ jobnumberDictionay setObject:[jobnumber stringValue] forKey:[NSString stringWithFormat:@"%d",100+indexPath.section*10 + indexPath.row]];
        [jobDictionary setObject:[titlt stringValue] forKey:[NSString stringWithFormat:@"%d",100+indexPath.section*10 + indexPath.row]];
        //cell的标识btn,用于覆盖工作”未选中“的图片
        cell.btn.selected = NO;
        //ba把所有cell的标识btn 加入到titleArray上,用来标识申请的工作
        if ([self.titleArray count]!=0) {
            
            for (NSNumber *a in self.titleArray) {
                int i = [a intValue];
                
                if (i==(100+indexPath.section*10 + indexPath.row)) {
                    cell.btn.selected = YES;
                    
                }
            }
        } 
        cell.btn.tag = 100+indexPath.section*10 + indexPath.row;
        [cell.btn addTarget:self action:@selector(a:) forControlEvents:UIControlEventTouchDown];
        //cell.btn.selected = NO;
        cell.labelTitle.text = [titlt stringValue];
        cell.labelCompany.placeholder = [name stringValue];
        cell.labelDate.placeholder = [date stringValue];
        cell.labelAddress.placeholder = [city stringValue];
        
    }
    //用户已登录，并填写多个求职意向
    else{  NSArray *art = [self.root nodesForXPath:@"//mindrecommend" error:nil];
        if ([art count]!=0) {
            GDataXMLElement *mindrecomment = [[self.root nodesForXPath:@"//mindrecommend" error:nil]objectAtIndex:0];
            GDataXMLElement *positionlist = [[mindrecomment elementsForName:@"positionlist"]objectAtIndex:0];
            GDataXMLElement *position = [[positionlist elementsForName:@"position"]objectAtIndex:indexPath.row];
            GDataXMLElement *name = [[position elementsForName:@"company_name"]objectAtIndex:0];
            GDataXMLElement *titlt = [[position elementsForName:@"job_title"]objectAtIndex:0];
            GDataXMLElement *date = [[position elementsForName:@"date_opening"]objectAtIndex:0];
            GDataXMLElement *city = [[position elementsForName:@"job_city"]objectAtIndex:0];
            
            GDataXMLElement *jobnumber = [[position elementsForName:@"job_number"]objectAtIndex:0];
            //把job_number加入到jobmuberdictionary
            
            [ jobnumberDictionay setObject:[jobnumber stringValue]  forKey:[NSString stringWithFormat:@"%d",100+indexPath.section*10 + indexPath.row]];
            [jobDictionary setObject:[titlt stringValue] forKey:[NSString stringWithFormat:@"%d",100+indexPath.section*10 + indexPath.row]];
            //cell的标识btn,用于覆盖工作”未选中“的图片
            cell.btn.selected = NO;
            //ba把所有cell的标识btn 加入到titleArray上,用来标识申请的工作
            if ([self.titleArray count]!=0) {
                
                for (NSNumber *a in self.titleArray) {
                    int i = [a intValue];
                    if (i==(100+indexPath.section*10 + indexPath.row)) {
                        cell.btn.selected = YES;
                    }
                }
            }
            
            cell.btn.tag = 100+indexPath.section*10 + indexPath.row;
            [cell.btn addTarget:self action:@selector(a:) forControlEvents:UIControlEventTouchDown];
            //cell.btn.selected = NO;
            cell.labelTitle.text = [titlt stringValue];
            cell.labelCompany.placeholder = [name stringValue];
            cell.labelDate.placeholder = [date stringValue];
            cell.labelAddress.placeholder = [city stringValue];
        }
    }
    NSString *str = [[NSBundle mainBundle]pathForResource:@"accessoryArrow@2x" ofType:@"png"];
    UIImage *iamgeV = [UIImage imageWithContentsOfFile:str];
    cell.accessoryView = (UIView *)[[UIImageView alloc]initWithImage:iamgeV];
    
    
    return cell;
}
//更改btn的图片，用于选中和未选中判断标识
-(void)a:(id)s
{
    UIButton *btn = (UIButton *)s;
    if (btn.selected) {
        for (NSNumber *a in self.titleArray) {
            int i = [a intValue];
            if (i==btn.tag) {
                [self.titleArray removeObject:a];
                btn.selected = !btn.selected;
                return;
            }
            
        }
    }
    btn.selected = !btn.selected;
    NSNumber *n = [NSNumber numberWithInt:btn.tag];
    [self.titleArray addObject:n];
    //NSLog(@"self.titeA = %@",self.titleArray);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobDetailVC *detailVC = [[JobDetailVC alloc]init];
               detailVC.jobNumber = @"CC145561157J90250248000_551";
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
    
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (tableView.tag==110) {
//       NSArray *arr = [self.root nodesForXPath:@"//applyjob" error:nil];
//       if ([arr count]!=0) {
//        GDataXMLElement *applyjob = [[self.root nodesForXPath:@"//applyjob" error:nil]objectAtIndex:indexPath.section];
//        GDataXMLElement *positionlist = [[applyjob elementsForName:@"positionlist"]objectAtIndex:0];
//        GDataXMLElement *position = [[positionlist elementsForName:@"position"]objectAtIndex:indexPath.row];
//        GDataXMLElement *jonnumber = [[position elementsForName:@"job_number"]objectAtIndex:0];
//        GDataXMLElement *companyN = [[position elementsForName:@"company_number"]objectAtIndex:0];
//        //推到详细界面
//           //推到详细界面
//          DetailView *detail = [[DetailView alloc]init];
//           
//           detail.comUrlStr = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/company/showcompanydetail.aspx?Page=1&Pagesize=2&Company_number=%@",[companyN stringValue]];
//           detail.jobUrlStr = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/job/showjobdetail.aspx?Page=0&Pagesize=1&Job_number=%@",[jonnumber stringValue]];
//            [self.navigationController pushViewController:detail animated:YES];
//           self.titleArray = nil;
//           [detail release];
//    }  
//    else{
//        GDataXMLElement *mindrecomment = [[self.root nodesForXPath:@"//mindrecommend" error:nil]objectAtIndex:0];
//        GDataXMLElement *positionlist = [[mindrecomment elementsForName:@"positionlist"]objectAtIndex:0];
//        GDataXMLElement *position = [[positionlist elementsForName:@"position"]objectAtIndex:indexPath.row];
//        GDataXMLElement *jonnumber = [[position elementsForName:@"job_number"]objectAtIndex:0];
//        GDataXMLElement *companyN = [[position elementsForName:@"company_number"]objectAtIndex:0];
//        //推到详细界面
//        //推到详细界面
//        DetailView *detail = [[DetailView alloc]init];
//        
//        detail.comUrlStr = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/company/showcompanydetail.aspx?Page=1&Pagesize=2&Company_number=%@",[companyN stringValue]];
//        detail.jobUrlStr = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/job/showjobdetail.aspx?Page=0&Pagesize=1&Job_number=%@",[jonnumber stringValue]];
//        [self.navigationController pushViewController:detail animated:YES];
//        self.titleArray = nil;
//        [detail release];      } 
//    }
//}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    //[self.MytableView setEditing:editing animated:animated];
    [detailTableView setEditing:editing animated:animated];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag ==111) {
        return YES;
    }
    return NO;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return UITableViewCellEditingStyleInsert;
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [jobArray removeObjectAtIndex:indexPath.row];
        [NEWJobArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    }   
       
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)  
sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath { 
    if (tableView.tag==111) {
        
    
    [tableView exchangeSubviewAtIndex:[sourceIndexPath row] withSubviewAtIndex:[destinationIndexPath row]];
    [tableView reloadData];
    }
}
- (void)viewDidUnload
{
    [self setMytableView:nil];
    [self setMyScorllView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    self.titleArray = nil;
    self.uiticket = nil;
    [jobnumberDictionay release];
    jobArray = nil;
    jobDictionary= nil;
    [self.MytableView release];
    [_MyScorllView release];
    [super dealloc];
}
- (IBAction)askForJobs:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"申请成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    for (NSNumber *a in self.titleArray) {
        int i = [a intValue];
        NSString *str = [jobnumberDictionay objectForKey:[NSString stringWithFormat:@"%d",i]];
        NSLog(@"%@",str);
        [NEWJobArray addObject:str];
        NSString *s = [jobDictionary objectForKey:[NSString stringWithFormat:@"%d",i]];
        [jobArray addObject:s];
    }
    [detailTableView reloadData];
    [self.MyScorllView setContentOffset:CGPointMake(320, 0) animated:YES];
//    DetailView *a = [[DetailView alloc]init];
//    [a apply];
}

- (IBAction)MyCollect:(id)sender {
    for (NSNumber *a in self.titleArray) {
        int i = [a intValue];
        NSString *str = [jobnumberDictionay objectForKey:[NSString stringWithFormat:@"%d",i]];
        NSLog(@"%@",str);
        [NEWJobArray addObject:str];
        NSString *s = [jobDictionary objectForKey:[NSString stringWithFormat:@"%d",i]];
        [jobArray addObject:s];
    }
    [detailTableView reloadData];
    [self.MyScorllView setContentOffset:CGPointMake(320, 0) animated:YES];
}

- (IBAction)Myaction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先点击公司" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

- (IBAction)MysimilarJob:(id)sender {
    
    //推到详细界面
    if ([NEWJobArray count]==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先选择并申请职位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    if ([NEWJobArray count]!=0) {
        NSString *jobnumber = [NEWJobArray objectAtIndex:0];
    
    morejoblistViewcontroller *iv = [[morejoblistViewcontroller alloc]init];
        iv.jobnumber = jobnumber ;
    iv.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:iv animated:YES];
    self.titleArray = nil;
    [iv release];
    }
}
@end
