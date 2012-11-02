//
//  EmailDetailViewController.m
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


#define start_color [UIColor colorWithHex:0xEEEEEE]
#define end_color [UIColor colorWithHex:0xDEDEDE]


#import "EmailDetailViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "MarkedJob.h"
#import "GDataXMLNode.h"
#import "RecordCell.h"
#import "Email.h"
#import "PrettyKit.h"
#import "LeveyHUD.h"

@interface EmailDetailViewController()
PRIVATEMETHEODS 
- (void)getUticket;
@end

@implementation EmailDetailViewController
@synthesize ID;
@synthesize subjectLabel = _subjectLabel;
@synthesize dateLabel = _dateLabel;
@synthesize companyLabel = _companyLabel;
@synthesize bodyTextView = _bodyTextView;
@synthesize backScollView = _backScollView;

#pragma mark - View lifecycle
//view刚要加载时发送网络请求
- (void)viewWillAppear:(BOOL)animated
{

    
}

- (void)viewDidLoad
{
    
    [[LeveyHUD sharedHUD] appearWithText:@"数据加载中..."];
    [self performSelector:@selector(sendRequest) withObject:self afterDelay:0.5];
}
- (void)viewDidUnload
{
    [self setSubjectLabel:nil];
    [self setCompanyLabel:nil];
    [self setDateLabel:nil];
    [self setBodyTextView:nil];
    [self setBackScollView:nil];
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
    NSString *string = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/jobmng_showmail.aspx?email_number=%@&uticket=%@",self.ID,uticket];
    SENDERREQUEST
}
//实现设置view的内容的方法
- (void)setViewContent
{
    _List = [[NSMutableArray alloc]init];
    self.bodyTextView.contentSize = CGSizeMake(320, 580);
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:_data options:0 error:nil];
    GDataXMLElement *root = [document rootElement];
    self.subjectLabel.text = [[[root nodesForXPath:@"mail/subject" error:nil]objectAtIndex:0]stringValue];
    self.companyLabel.text = [[[root nodesForXPath:@"mail/company_name" error:nil]objectAtIndex:0]stringValue];
    self.dateLabel.text = [[[root nodesForXPath:@"mail/date_posted" error:nil]objectAtIndex:0]stringValue];
    self.bodyTextView.text = [[[root nodesForXPath:@"mail/mail_body" error:nil]objectAtIndex:0]stringValue];
}

- (void)dealloc {
    [_subjectLabel release];
    [_companyLabel release];
    [_dateLabel release];
    [_bodyTextView release];
    [_backScollView release];
    [super dealloc];
}
@end
