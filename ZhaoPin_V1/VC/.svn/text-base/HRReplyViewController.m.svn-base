//
//  HRReplyViewController.m
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

#define UTICKET R1uG28tWm6LEVCvI8X0N+bSoX1lL6DLuTpkLLXbvLfy+k8xzMngO9w==

#define start_color [UIColor colorWithHex:0xEEEEEE]
#define end_color [UIColor colorWithHex:0xDEDEDE]


#import "HRReplyViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "MarkedJob.h"
#import "GDataXMLNode.h"
#import "RecordCell.h"
#import "Email.h"
#import "EmailDetailViewController.h"
#import "PrettyKit.h"
#import "LeveyHUD.h"

@interface HRReplyViewController()
PRIVATEMETHEODS 
- (void)getUticket;
@end


@implementation HRReplyViewController
@synthesize HRTableView = _HRTableView;


#pragma mark - View lifecycle
//view刚要加载时发送网络请求
- (void)viewWillAppear:(BOOL)animated
{
    self.HRTableView.rowHeight = 60;
    self.HRTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.HRTableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];

    //[self sendRequest];

}

- (void)viewDidLoad
{
    
    [[LeveyHUD sharedHUD] appearWithText:@"数据加载中..."];
    
    [self performSelector:@selector(sendRequest) withObject:self afterDelay:1];
}
- (void)viewDidUnload
{
    [self setHRTableView:nil];
    [self setHRTableView:nil];
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

- (void)getUticket  //获取身份标识
{    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"user.txt"];   
    NSDictionary *userDic = [NSDictionary dictionaryWithContentsOfFile:filePath];  
    uticket = [userDic objectForKey:@"uticket"];
    [uticket retain];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//实现发送网络请求的方法
- (void)sendRequest
{
    [self getUticket];
    NSString *string = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/get_hr_email_list.aspx?uticket=%@&page=1&pagesize=30",uticket];
    SENDERREQUEST
}
//实现设置view的内容的方法
- (void)setViewContent
{
    _List = [[NSMutableArray alloc]init];
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:_data options:0 error:nil];
    GDataXMLElement *root = [document rootElement];
    //
    NSArray *jobList = [root nodesForXPath:@"emaillist/email" error:nil];
    for (GDataXMLElement *job in jobList) {
        Email *email = [[Email alloc]init];
        email.subject = [[[job nodesForXPath:@"subject" error:nil]objectAtIndex:0]stringValue];
        email.companyName = [[[job nodesForXPath:@"company_name" error:nil]objectAtIndex:0]stringValue];
        email.companyNumber = [[[job nodesForXPath:@"company_number" error:nil]objectAtIndex:0]stringValue];
        email.datePosted = [[[job nodesForXPath:@"date_posted" error:nil]objectAtIndex:0] stringValue];
        email.emailNumber = [[[job nodesForXPath:@"email_number" error:nil]objectAtIndex:0]stringValue];
        email.responseEmailNumber = [[[job nodesForXPath:@"response_email_number" error:nil]objectAtIndex:0]stringValue];
        email.isRead = [[[job nodesForXPath:@"is_read" error:nil]objectAtIndex:0]stringValue];
        [_List addObject:email];
    }   
    if ([_List count] != 0) {
        [self.HRTableView reloadData];
    }
}

#pragma mark - table view data 代理
//row的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_List count];
}
//cell显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HRCell";
    PrettyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PrettyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.tableViewBackgroundColor = tableView.backgroundColor;        
        cell.gradientStartColor = start_color;
        cell.gradientEndColor = end_color;  
    }
    Email *email = [_List objectAtIndex:indexPath.row];
    cell.textLabel.text = email.subject;
    cell.detailTextLabel.text = email.companyName;
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
    EmailDetailViewController *VC = [[EmailDetailViewController alloc]init];
    Email *email = [_List objectAtIndex:indexPath.row];
    VC.ID = email.emailNumber;
    NSLog(@"%@",VC.ID);
    [self.navigationController pushViewController:VC animated:YES];
    [VC release];
}

//cell可以被编辑
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.HRTableView  setEditing:editing animated:animated];
}
//cell被删除执行的方法
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Email *email = [_List objectAtIndex:indexPath.row];
    NSString *string = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobmng_fav_del.aspx?email_number=%@&uticket=R1uG28tWm6LEVCvI8X0N+cEt5TFWlImHTpkLLXbvLfy+k8xzMngO9w==",email.responseEmailNumber];
    NSLog(@"%@",email.responseEmailNumber);
    NSURL *url = [[NSURL alloc]initWithString:[self getMD5String:string]]; 
    NSLog(@"%@",url);
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];    
    NSURLResponse *response = nil;
    NSError *error = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    [_List removeObjectAtIndex:indexPath.row];
    [self.HRTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

- (void)dealloc
{
    [_HRTableView release];
    [super dealloc];
}

@end
