//
//  HomeVC.m
//  Zhaopin
//
//  Created by Ibokan on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HomeVC.h"
#import "JobSearchViewController.h"
#import "ChannelListViewController.h"
#import "HRReplyViewController.h"
#import "CollectionViewController.h"
#import "JobApplicationViewController.h"
#import "currentRecommendViewController.h"
#import "LoginVC.h"
#import "EncryptURL.h"
#import "GDataXMLNode.h"
#import "LeveyHUD.h"

@implementation HomeVC
@synthesize loginded;
@synthesize username;
@synthesize password;
@synthesize uticket;
@synthesize emailCount;
@synthesize recordCount;
@synthesize favoriteCount;
@synthesize searchButton;
@synthesize salaryButton;
@synthesize guideButton;
@synthesize emailButton;
@synthesize favoriteButton;
@synthesize recordButton;
@synthesize recommendButton;
@synthesize loginButton;
@synthesize emailLabel;
@synthesize favoriteLabel;
@synthesize recordLabel;
@synthesize loginLabel;

@interface HomeVC(private)

- (BOOL)getUserInfo;
- (void)setViewContent;
- (void)quickLogin;
- (BOOL)parseReceivedData:(NSData *)aReceivedData;

@end

+ (HomeVC *) instance
{
    //静态变量,生命周期是整个程序，在下一次该函数调用时仍可使用 。
    static HomeVC *instance; 
    if(!instance)
    {
        instance = [[HomeVC alloc] init];
    }
    return instance;
}

- (BOOL)getUserInfo
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"user.txt"];   
    NSDictionary *userDic = [NSDictionary dictionaryWithContentsOfFile:filePath];  
    self.username = [userDic objectForKey:@"username"];
    self.password = [userDic objectForKey:@"password"];
    if ([self.username length]==0) {
        return NO;
    }
    return YES;
}

- (BOOL) parseReceivedData:(NSData *)aReceivedData
{
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:aReceivedData options:0 error:nil];
    GDataXMLElement *root = [document rootElement];
    
    NSString *result = [[[root nodesForXPath:@"result" error:nil]objectAtIndex:0]stringValue];
    
    if ([result isEqualToString:@"1"])
    {
        self.uticket = [[[root nodesForXPath:@"uticket" error:nil]objectAtIndex:0]stringValue];
        
        self.loginded = YES;

        self.emailCount = [NSString stringWithFormat:@"未读%@条",[[[root nodesForXPath:@"no_read_hr_email_count" error:nil]objectAtIndex:0]stringValue]];
        self.favoriteCount = [NSString stringWithFormat:@"收藏%@条",[[[root nodesForXPath:@"fav_count" error:nil]objectAtIndex:0]stringValue]];
        self.recordCount = [NSString stringWithFormat:@"记录%@条",[[[root nodesForXPath:@"apply_count" error:nil]objectAtIndex:0]stringValue]];    
        
        [document release];
        return YES;        
    }
    
    [document release];
    return NO;
}

#pragma mark - 生命周期

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture.png"]];
    
    self.navigationController.navigationBar.hidden = YES;
    if ([self getUserInfo])
    {
        [self quickLogin];
    }        
    [self setViewContent];
}

- (void)viewDidUnload
{
    [self setSearchButton:nil];
    [self setSalaryButton:nil];
    [self setGuideButton:nil];
    [self setEmailButton:nil];
    [self setFavoriteButton:nil];
    [self setRecordButton:nil];
    [self setLoginButton:nil];
    [self setRecommendButton:nil];
    [self setLoginLabel:nil];
    [self setEmailLabel:nil];
    [self setFavoriteLabel:nil];
    [self setRecordLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - 设置view的显示内容，快速登陆

- (void)setViewContent
{
    [self.searchButton addTarget:self action:@selector(showSearchVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self.guideButton addTarget:self action:@selector(showGuideVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self.emailButton addTarget:self action:@selector(showEmailVC) forControlEvents:UIControlEventTouchUpInside];
    self.emailButton.userInteractionEnabled = NO;
    [self.emailButton setImage:[UIImage imageNamed:@"disable-email-button.png"] forState:UIControlStateNormal];
    
    [self.favoriteButton addTarget:self action:@selector(showFavoriteVC) forControlEvents:UIControlEventTouchUpInside];
    self.favoriteButton.userInteractionEnabled = NO;
    [self.favoriteButton setImage:[UIImage imageNamed:@"disable-favorite-button.png"] forState:UIControlStateNormal];
    
    [self.recordButton addTarget:self action:@selector(showRecordVC) forControlEvents:UIControlEventTouchUpInside];
    self.recordButton.userInteractionEnabled = NO;
    [self.recordButton setImage:[UIImage imageNamed:@"disable-record-button.png"] forState:UIControlStateNormal];
    
    [self.recommendButton addTarget:self action:@selector(showRecommendVC) forControlEvents:UIControlEventTouchUpInside];
    self.recommendButton.userInteractionEnabled = NO;
    [self.recommendButton setImage:[UIImage imageNamed:@"disable-recommend-button.png"] forState:UIControlStateNormal];
    
    [self.loginButton addTarget:self action:@selector(showLoginVC) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.loginded == YES) {
        loginLabel.text = @"注销";
        emailLabel.text = [NSString stringWithFormat:@"未读%@条",self.emailCount];
        favoriteLabel.text = [NSString stringWithFormat:@"收藏%@条",self.emailCount];
        recordLabel.text = [NSString stringWithFormat:@"记录%@条",self.emailCount];
        
        [self.emailButton setImage:[UIImage imageNamed:@"email-button.png"] forState:UIControlStateNormal];
        [self.favoriteButton setImage:[UIImage imageNamed:@"favorite-button.png"] forState:UIControlStateNormal];
        [self.recordButton setImage:[UIImage imageNamed:@"record-button.png"] forState:UIControlStateNormal];
        [self.recommendButton setImage:[UIImage imageNamed:@"recommend-button.png"] forState:UIControlStateNormal];
        
        self.emailLabel.text = [NSString stringWithFormat:@"%@",self.emailCount];
        self.favoriteLabel.text = [NSString stringWithFormat:@"%@",self.favoriteCount];
        self.recordLabel.text = [NSString stringWithFormat:@"%@",self.recordCount];
        
        self.emailButton.userInteractionEnabled = YES;
        self.favoriteButton.userInteractionEnabled = YES;
        self.recordButton.userInteractionEnabled = YES;
        self.recommendButton.userInteractionEnabled = YES;  
    }
    if (self.loginded == NO) {
        self.loginLabel.text = @"注册登录";
    }
}

- (void)quickLogin
{
    NSString *urls = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/loginmgr/login.aspx?loginname=%@&password=%@",self.username,self.password];//原始url
    EncryptURL *encryption = [[EncryptURL alloc]init];
    NSString *urlStr = [encryption getMD5String:urls];//url MD5加密
    [encryption release];
    NSString *encodeUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//UTF8 Encode处理
    NSLog(@"encodeUrlStr = %@",encodeUrlStr);
    NSURL *url = [NSURL URLWithString:encodeUrlStr];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if([self parseReceivedData:responseData])//如果解析xml方法 返回登陆成功
    {
        self.loginded = YES;
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [documentPath stringByAppendingPathComponent:@"user.txt"];
        NSDictionary *userDic = [[NSDictionary alloc]initWithObjectsAndKeys:self.username,@"username",self.password,@"password",self.uticket,@"uticket", nil];
        
        [userDic writeToFile:filePath atomically:YES];//用户名和密码写入文件
    }
}

#pragma mark - 从home界面push到其他界面的方法

- (void)showSearchVC
{
    JobSearchViewController *searchVC = [[JobSearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
    [searchVC release];
}

- (void)showGuideVC
{
    ChannelListViewController *guideVC = [[ChannelListViewController alloc]init];
    [self.navigationController pushViewController:guideVC animated:YES];
    [guideVC release];
}

- (void)showLoginVC
{
    if (self.loginded == NO) {
        LoginVC *loginVC = [[LoginVC alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
        [loginVC release];
    }
    if (self.loginded == YES) {
        self.loginded = NO;
        [self setViewContent];
        [[LeveyHUD sharedHUD] appearWithText:@"用户已注销"];
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(removeAlertView) userInfo:nil repeats:NO];
    }
}

- (void)showEmailVC
{
    HRReplyViewController *emailVC = [[HRReplyViewController alloc]init];
    [self.navigationController pushViewController:emailVC animated:YES];
    [emailVC release];
}

- (void)showFavoriteVC
{
    CollectionViewController *favoriteVC = [[CollectionViewController alloc]init];
    [self.navigationController pushViewController:favoriteVC animated:YES];
    [favoriteVC release];
}

- (void)showRecommendVC
{
    currentRecommendViewController *recommendVC = [[currentRecommendViewController alloc]init];
    [self.navigationController pushViewController:recommendVC animated:YES];
    [recommendVC release];
}

- (void)showRecordVC
{
    JobApplicationViewController *recordVC = [[JobApplicationViewController alloc]init];
    [self.navigationController pushViewController:recordVC animated:YES];
    [recordVC release];
}

#pragma mark - 移除警告提示视图

- (void)removeAlertView
{
    [[LeveyHUD sharedHUD] delayDisappear:0.1f withText:nil]; 
}

#pragma mark - 重写dealloc

- (void)dealloc {
    [searchButton release];
    [salaryButton release];
    [guideButton release];
    [emailButton release];
    [favoriteButton release];
    [recordButton release];
    [loginButton release];
    [recommendButton release];
    [loginLabel release];
    [emailLabel release];
    [favoriteLabel release];
    [recordLabel release];
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
