//
//  JobApplicationViewController.m
//  MyZhilian
//
//  Created by Ibokan on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#define PRIVATEMETHEODS - (void)sendRequest;- (void)setViewContent;- (NSString *) getMD5String:(NSString *)url;- (NSString *)md5:(NSString *)str;

#define NOMAL - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];if (self) {}return self;}- (void)didReceiveMemoryWarning{[super didReceiveMemoryWarning];}

#define MD5 - (NSString *) getMD5String:(NSString *)url{	NSDate *date = [NSDate date];NSTimeInterval timeInterval = [date timeIntervalSince1970];NSString *paramT = [NSString stringWithFormat:@"%f", timeInterval];NSString *md5src = [NSString stringWithFormat:@"%fA42F7167-6DB0-4A54-84D4-789E591C31DA", timeInterval];NSString *md5Result = [self md5:md5src];NSLog(@"md5:%@", md5Result);NSString *result = nil;if (NSNotFound == [url rangeOfString:@"?"].location) {result = [NSString stringWithFormat:@"%@?t=%@&e=%@&f=p&d=%@",url, paramT, md5Result,md5src];}else {result = [NSString stringWithFormat:@"%@&t=%@&e=%@&f=p&d=%@",url, paramT, md5Result,md5src];}	return result;	}-(NSString *)md5:(NSString *)str { const char *cStr = [str UTF8String]; unsigned char result[32]; CC_MD5( cStr, strlen(cStr), result ); return [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15] ]; }

#define CONNECTIONDELEGATE - (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{ }- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)reponse{_data = [[NSMutableData alloc]init];}- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{[_data appendData:data];}- (void)connectionDidFinishLoading:(NSURLConnection *)connection{[Indicator removeIndicator:self.view];[self setViewContent];}

#define SENDERREQUEST NSURL *url = [[NSURL alloc]initWithString:[self getMD5String:string]]; NSLog(@"%@",url);NSURLRequest *request =[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];[url release];NSURLConnection  *_connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];[request release];[_connection release];
#define NSLOGXML NSString *str = [[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];NSLog(@"%@",str);




#import "JobApplicationViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "MarkedJob.h"
#import "GDataXMLNode.h"
#import "RecordCell.h"
#import "PrettyKit.h"
#import "LeveyHUD.h"
#import "JobDetailVC.h"

#define start_color [UIColor colorWithHex:0xEEEEEE]
#define end_color [UIColor colorWithHex:0xDEDEDE]

@interface JobApplicationViewController()
PRIVATEMETHEODS 
- (void)getUticket ;
@end

@implementation JobApplicationViewController
@synthesize jobTableView;

#pragma mark - View lifecycle
//view刚要加载时发送网络请求
- (void)viewWillAppear:(BOOL)animated
{
    more = 1;
    
    self.jobTableView.rowHeight = 60;
    self.jobTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.jobTableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    
}

- (void)viewDidLoad
{
    
    [[LeveyHUD sharedHUD] appearWithText:@"数据加载中..."];
    [self performSelector:@selector(sendRequest) withObject:self afterDelay:1];
}

- (void)viewDidUnload
{
    [self setJobTableView:nil];
    [super viewDidUnload];
    [_data release];
}

#pragma mark -私有方法    
MD5
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
    [[LeveyHUD sharedHUD] disappear];
    [self setViewContent];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getUticket  //获取身份标识
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"user.txt"];   
    NSDictionary *userDic = [NSDictionary dictionaryWithContentsOfFile:filePath];  
    uticket = [userDic objectForKey:@"uticket"];
    [uticket retain];
}

//实现发送网络请求的方法
- (void)sendRequest
{
    [self getUticket];
    NSString *string = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobmng_applist.aspx?uticket=%@&page=1&pagesize=%d",uticket,more*10];
    SENDERREQUEST
}
//实现设置view的内容的方法
- (void)setViewContent
{
    _List = [[NSMutableArray alloc]init];
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:_data options:0 error:nil];
    GDataXMLElement *root = [document rootElement];
    //
    NSArray *jobList = [root nodesForXPath:@"applylist/apply" error:nil];
    for (GDataXMLElement *job in jobList) {
        MarkedJob *markedJob = [[MarkedJob alloc]init];
        markedJob.number = [[[job nodesForXPath:@"job_number" error:nil]objectAtIndex:0]stringValue];
        markedJob.title = [[[job nodesForXPath:@"job_title" error:nil]objectAtIndex:0]stringValue];
        markedJob.city = [[[job nodesForXPath:@"job_city" error:nil]objectAtIndex:0]stringValue];
        markedJob.count = [[[[job nodesForXPath:@"applied_count" error:nil]objectAtIndex:0] stringValue]intValue];
        markedJob.companyNumber = [[[job nodesForXPath:@"company_number" error:nil]objectAtIndex:0]stringValue];
        markedJob.companyName = [[[job nodesForXPath:@"company_name" error:nil]objectAtIndex:0]stringValue];
        markedJob.date = [[[job nodesForXPath:@"date_applied" error:nil]objectAtIndex:0]stringValue];
        [_List addObject:markedJob];
        [markedJob release];
    }   
    if ([_List count] != 0) {
        [self.jobTableView reloadData];
    }
}

#pragma mark - table view data 代理
//row的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_List count]+1;
}
//cell显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"JobCell";
    PrettyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PrettyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.tableViewBackgroundColor = tableView.backgroundColor;        
        cell.gradientStartColor = start_color;
        cell.gradientEndColor = end_color; 
    }
    if (indexPath.row == [_List count]) {
        cell.textLabel.text = @"显示更多";
        cell.detailTextLabel.text = nil;
        return cell;
    }
    MarkedJob *job = [_List objectAtIndex:indexPath.row];
    cell.textLabel.text = job.title;
    cell.detailTextLabel.text = job.companyName;

    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"accessoryArrow.png"]];
    cell.accessoryView = imageView;
    [imageView release];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return tableView.rowHeight + [PrettyTableViewCell tableView:tableView neededHeightForIndexPath:indexPath];
}


//cell被选中时执行的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [_List count]) {
        more++;
        [self sendRequest];
        return;
    }
    
    JobDetailVC *detailVC = [[JobDetailVC alloc]init];
    
    MarkedJob *job = [_List objectAtIndex:indexPath.row];
    detailVC.jobNumber = job.number;
    NSLog(@"%@",detailVC.jobNumber);
    
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

- (void)dealloc {
    [jobTableView release];
    [super dealloc];
}
@end
