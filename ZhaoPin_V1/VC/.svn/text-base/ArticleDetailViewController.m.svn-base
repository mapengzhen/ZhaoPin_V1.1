//
//  ArticleDetailViewController.m
//  GuideToJobHunting
//
//  Created by Ibokan on 12-10-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import "Article.h"
#import "LeveyHUD.h"

@implementation ArticleDetailViewController
@synthesize ID;
@synthesize titleLabel;
@synthesize startDateLabel;
@synthesize contentTextView;

@interface ArticleDetailViewController(private)

//发送网络请求的方法
- (void)sendRequest;
//设置view的内容
- (void)setViewContent;

@end

- (void)sendRequest
{
    // 根据智联招聘提供的服务器接口，创建string，用于发送网络请求
    NSString *string = [[NSString alloc]initWithFormat:@"http://mobileinterface.zhaopin.com/iphone/article/articledetail.service?id=%d",self.ID];
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
    //根据下载下来的xml数据创建article对象
    Article *article = [[Article alloc]initByXMLData:_data];
    [_data release];
    //设置view的内容
    titleLabel.text = article.title;
    startDateLabel.text = article.startDate;
    contentTextView.text = article.content;
    [article release];
}

#pragma mark - 生命周期
//view将要显示时发送网络请求
- (void)viewWillAppear:(BOOL)animated
{
//    //发送网络请求
//    [self sendRequest];
//    // 显示网络状况提示视图
//    [[LeveyHUD sharedHUD] appearWithText:@"数据加载中..."];
}

- (void)viewDidLoad
{
    
    [[LeveyHUD sharedHUD] appearWithText:@"数据加载中..."];
    [self performSelector:@selector(sendRequest) withObject:self afterDelay:0.5];
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setStartDateLabel:nil];
    [self setContentTextView:nil];
    [super viewDidUnload];
}

#pragma mark - 返回按钮方法

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 异步代理

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

#pragma mark - 重写dealloc

- (void)dealloc 
{
    [titleLabel release];
    [startDateLabel release];
    [contentTextView release];
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
