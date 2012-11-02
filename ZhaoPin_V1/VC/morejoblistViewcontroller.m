//
//  morejoblistViewcontroller.m
//  day10-3SearchJob
//
//  Created by 董红强 on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "morejoblistViewcontroller.h"
#import "GDataXMLNode.h"
#import <CommonCrypto/CommonDigest.h>

@implementation morejoblistViewcontroller
@synthesize job=_job,jobnumber = _jobnumber;
@synthesize root = _root;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc
{
    self.root = nil;
    self.jobnumber = nil;
    [self.job release];
    [_data release];
    [connection release];
    [super dealloc];
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
- (void)sendRequest
{
    // 根据智联招聘提供的服务器接口，创建string，用于发送网络请求
    NSString *string = [[NSString alloc]initWithFormat:@"http://wapinterface.zhaopin.com/iphone/job/showjobdetail.aspx?job_number=%@&Page=1&Pagesize=10",self.jobnumber];
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
}
//实现设置view的内容的方法
- (void)setViewContent
{
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:_data options:0 error:nil];
    self.root = [document rootElement];//根节点
   
    NSMutableArray *morejobnumber = [[NSMutableArray alloc]init];
    GDataXMLElement *joblist = [[self.root nodesForXPath:@"//joblist" error:nil]objectAtIndex:0];
    NSArray *jobarr = [self.root nodesForXPath:@"//job" error:nil];
    for (int i=0; i<[jobarr count]; i++) {
        GDataXMLElement *job = [[joblist elementsForName:@"job"]objectAtIndex:i];
        GDataXMLElement *jobtitlenew = [[job elementsForName:@"job_title"]objectAtIndex:0];
        GDataXMLElement *jobnumber = [[job elementsForName:@"job_number"]objectAtIndex:0];
        [self.job addObject:[jobtitlenew stringValue]];
        [morejobnumber addObject:[jobnumber stringValue]];
    }
    NSLog(@"%@",self.job);
     
    [table reloadData];
    [_data release];
}

//发送网络请求失败时，执行的方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
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
    [self setViewContent];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) backToMainPage:(id) sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self sendRequest];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.job = [[NSMutableArray alloc]initWithCapacity:10]; 
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"返回首页" style:UIBarButtonItemStyleBordered target:self action:@selector(backToMainPage:)];
    
    self.navigationItem.rightBarButtonItem=bar;
    self.view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)]autorelease];
    self.view.backgroundColor = [UIColor whiteColor];
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    table.backgroundView=(UIView *)[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"centerBackground@2x.png"]];
    table.backgroundColor = [UIColor clearColor];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [table release];

    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if ([self.job count]!=0) {
        return [self.job count];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    
    //tableviewcell上显示本公司其他招聘职位
    if ([self.job count]!=0) {
        cell.textLabel.text = [self.job objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:12];

    }
        
    NSString *str = [[NSBundle mainBundle]pathForResource:@"accessoryArrow@2x" ofType:@"png"];
    UIImage *iamgeV = [UIImage imageWithContentsOfFile:str];
    cell.accessoryView = (UIView *)[[UIImageView alloc]initWithImage:iamgeV];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
//     Secondfivecontroller *detailViewController = [[Secondfivecontroller alloc] init];
//     // ...
//     // Pass the selected object to the new view controller.
//    detailViewController.job_number = [self.jobnumber objectAtIndex:indexPath.row];
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     [detailViewController release];
     
}

@end
