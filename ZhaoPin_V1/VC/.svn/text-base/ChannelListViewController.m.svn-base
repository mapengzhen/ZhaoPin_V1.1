//
//  ChannelListViewController.m
//  GuideToJobHunting
//
//  Created by Ibokan on 12-10-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#define start_color [UIColor colorWithHex:0xEEEEEE]
#define end_color [UIColor colorWithHex:0xDEDEDE]

#import "ChannelListViewController.h"
#import "ArticleListViewController.h"
#import "ArticleDetailViewController.h"
#import "Channel.h"
#import "Article.h"
#import "GDataXMLNode.h"
#import "PrettyKit.h"
#import "LeveyHUD.h"

@implementation ChannelListViewController
@synthesize channelListTableView;

//私有方法
@interface ChannelListViewController(private)
//发送网络请求的方法
- (void)sendRequest;
//设置view的内容
- (void)setViewContent;
@end

- (void)sendRequest
{
    // 根据智联招聘提供的服务器接口，创建string，用于发送网络请求
    NSString *string = [[NSString alloc]initWithFormat:@"http://mobileinterface.zhaopin.com/iphone/article/channellist.service"];
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
    //开始解析xml
    channelList = [[NSMutableArray alloc]init];
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:_data options:0 error:nil];
    GDataXMLElement *root = [document rootElement];
    //
    for (int i = 0; i<8; i++) {
        //解析channel的数据
        GDataXMLElement *channelElement = [[root children]objectAtIndex:i];
        Channel *channel = [[Channel alloc]init];
        channel.ID = [[[channelElement attributeForName:@"id"]stringValue]intValue];
        channel.name = [[[channelElement nodesForXPath:@"name" error:nil] objectAtIndex:0] stringValue];
        //解析articles的数据
        channel.articles = [[NSMutableArray alloc]init];        
        for (int j = 0; j<5; j++) {
            Article *article = [[Article alloc]init];
            article.title = [[[channelElement nodesForXPath:@"articles/article/title" error:nil]objectAtIndex:j]stringValue];
            article.ID = [[[[channelElement nodesForXPath:@"articles/article/id" error:nil]objectAtIndex:j]stringValue]intValue];
            [channel.articles addObject:article];
            [article release];
        }
        [channelList addObject:channel];
        [channel release];
    }
    
    //设置view的内容    
    [channelListTableView reloadData];
    [_data release];
}

#pragma mark - View 生命周期
//view将要显示时发送网络请求
- (void)viewWillAppear:(BOOL)animated
{
    self.channelListTableView.rowHeight = 60;
    self.channelListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.channelListTableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    //[self sendRequest];
    self.title = @"求职指导";
    //[[LeveyHUD sharedHUD] appearWithText:@"数据加载中..."];
}

- (void)viewDidLoad
{
    
    [[LeveyHUD sharedHUD] appearWithText:@"数据加载中..."];
    [self performSelector:@selector(sendRequest) withObject:self afterDelay:0.7];
}
- (void)viewDidUnload
{
    //释放内存
    [self setChannelListTableView:nil];
    [channelList release],channelList = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - 返回按钮方法

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络请求异步代理方法

//发送网络请求失败时，执行的方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[LeveyHUD sharedHUD] disappear];
}
//服务器响应请求时要执行的方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)reponse
{
    //初始化存放xml数据的_data
    _data = [[NSMutableData alloc]init];
}
//接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}
//完成数据接收
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self setViewContent];
    [[LeveyHUD sharedHUD] disappear];
}

#pragma mark - table view data 代理

//row的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
//section的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}
//设置cell显示的内容
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
    Channel *channel = [channelList objectAtIndex:indexPath.section];
    Article *article = [channel.articles objectAtIndex:indexPath.row]; 
    cell.textLabel.text = article.title;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}
//设置section header 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return tableView.rowHeight + [PrettyTableViewCell tableView:tableView neededHeightForIndexPath:indexPath];
}

//table view 每个section header里的视图的设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
  
    //创建more按钮
    
    Channel *channel = [channelList objectAtIndex:section];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = channel.ID;
    button.frame = CGRectMake(-10, 0, 340, 40);
    [button setBackgroundImage:[UIImage imageNamed:@"black-button.png"] forState:UIControlStateNormal];

    [button setTitle:[NSString stringWithFormat:@"查看更多关于%@的文章",channel.name] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [button addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [button release];
    return view;
}
//more按钮点击是push到文章列表界面
- (void)moreButtonClicked:(UIButton *)sender
{
    ArticleListViewController *detailViewController = [[ArticleListViewController alloc]initWithNibName:@"ArticleListView" bundle:nil];
    detailViewController.ID = sender.tag;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}
//当点击cell时，push到文章详细界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleDetailViewController *detailViewController = [[ArticleDetailViewController alloc] initWithNibName:@"ArticleDetailView" bundle:nil];
    Channel *channel = [channelList objectAtIndex:indexPath.section];
    Article *article = [channel.articles objectAtIndex:indexPath.row]; 
    detailViewController.ID = article.ID;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

#pragma mark - 重写dealloc

- (void)dealloc
{
    [channelListTableView release];
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
