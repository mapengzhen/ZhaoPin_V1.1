//
//  ArticleListViewController.m
//  GuideToJobHunting
//
//  Created by Ibokan on 12-10-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#define start_color [UIColor colorWithHex:0xEEEEEE]
#define end_color [UIColor colorWithHex:0xDEDEDE]

#import "ArticleListViewController.h"
#import "ArticleDetailViewController.h"
#import "Channel.h"
#import "Article.h"
#import "PrettyKit.h"
#import "LeveyHUD.h"

@implementation ArticleListViewController
@synthesize articleListTableView;
@synthesize ID;

@interface ArticleListViewController(private)

//发送网络请求的方法
- (void)sendRequest;
//设置view的内容
- (void)setViewContent;

@end

- (void)sendRequest
{
    // 根据智联招聘提供的服务器接口，创建string，用于发送网络请求
    NSString *string = [[NSString alloc]initWithFormat:@"http://mobileinterface.zhaopin.com/iphone/article/articlelist.service?cid=%d",self.ID];
    NSURL *url = [[NSURL alloc]initWithString:string];
    [string release];
    // 发送网络请求的方式有很多，具体哪一个更好，还需要测试
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [url release];
    //使用异步获取网络数据，方法有两种，到底该用哪一种需要测试
    NSURLConnection  *_connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [request release];
    [_connection release];
}

- (void)setViewContent
{
    channel = [[Channel alloc]initByXMLData:_data];
    //设置view的内容    
    [articleListTableView reloadData];
    [_data release];
}

#pragma mark - 视图生命周期
//view将要显示时发送网络请求
- (void)viewWillAppear:(BOOL)animated
{
    self.articleListTableView.rowHeight = 60;
    self.articleListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.articleListTableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];

}

- (void)viewDidLoad
{
    
    [[LeveyHUD sharedHUD] appearWithText:@"数据加载中..."];
    [self performSelector:@selector(sendRequest) withObject:self afterDelay:1];
}

- (void)viewDidUnload
{
    [self setArticleListTableView:nil];
    [channel release],channel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - 返回按钮方法

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    [[LeveyHUD sharedHUD] disappear];
    [self setViewContent];
}

#pragma mark - table view  代理
//row的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return channel.totalCount;
}
//cell显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PrettyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PrettyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.tableViewBackgroundColor = tableView.backgroundColor;        
        cell.gradientStartColor = start_color;
        cell.gradientEndColor = end_color;  
        
    }
    Article *article = [channel.articles objectAtIndex:indexPath.row];   
    cell.textLabel.text = article.title;  
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

//cell被选中时执行的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     ArticleDetailViewController *detailViewController = [[ArticleDetailViewController alloc] initWithNibName:@"ArticleDetailView" bundle:nil];
        Article *article = [channel.articles objectAtIndex:indexPath.row]; 
    detailViewController.ID = article.ID;
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return tableView.rowHeight + [PrettyTableViewCell tableView:tableView neededHeightForIndexPath:indexPath];
}

#pragma mark - 重写dealloc

- (void)dealloc 
{
    [articleListTableView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
