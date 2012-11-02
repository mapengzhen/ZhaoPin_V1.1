//
//  LoginVC.m
//  Zhaopin
//
//  Created by Ibokan on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "HomeVC.h"
#import "EncryptURL.h"
#import "GDataXMLNode.h"
#import "LeveyHUD.h"

@implementation LoginVC
@synthesize username;
@synthesize password;
@synthesize uticket;
@synthesize usernameTextField;
@synthesize passwordTextField;
@synthesize loginButton;
@synthesize registerButton;

@interface LoginVC(private)

- (BOOL)parseReceivedData:(NSData *)aReceivedData;

@end

- (BOOL) parseReceivedData:(NSData *)aReceivedData
{
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:aReceivedData options:0 error:nil];
    GDataXMLElement *root = [document rootElement];
    
    NSString *result = [[[root nodesForXPath:@"result" error:nil]objectAtIndex:0]stringValue];
    
    if ([result isEqualToString:@"1"])
    {
        self.uticket = [[[root nodesForXPath:@"uticket" error:nil]objectAtIndex:0]stringValue];
        
        HomeVC *homeVC = [HomeVC instance];
        homeVC.loginded = YES;
        
        homeVC.loginLabel.text = @"注销";
        homeVC.emailLabel.text = [NSString stringWithFormat:@"未读%@条",[[[root nodesForXPath:@"no_read_hr_email_count" error:nil]objectAtIndex:0]stringValue]];
        homeVC.favoriteLabel.text = [NSString stringWithFormat:@"收藏%@条",[[[root nodesForXPath:@"fav_count" error:nil]objectAtIndex:0]stringValue]];
        homeVC.recordLabel.text = [NSString stringWithFormat:@"记录%@条",[[[root nodesForXPath:@"apply_count" error:nil]objectAtIndex:0]stringValue]];    
        
        [homeVC.emailButton setImage:[UIImage imageNamed:@"email-button.png"] forState:UIControlStateNormal];
        [homeVC.favoriteButton setImage:[UIImage imageNamed:@"favorite-button.png"] forState:UIControlStateNormal];
        [homeVC.recordButton setImage:[UIImage imageNamed:@"record-button.png"] forState:UIControlStateNormal];
        [homeVC.recommendButton setImage:[UIImage imageNamed:@"recommend-button.png"] forState:UIControlStateNormal];
        
        homeVC.emailButton.userInteractionEnabled = YES;
        homeVC.favoriteButton.userInteractionEnabled = YES;
        homeVC.recordButton.userInteractionEnabled = YES;
        homeVC.recommendButton.userInteractionEnabled = YES;  
        
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
    
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [registerButton addTarget:self action:@selector(showRegisterVC) forControlEvents:UIControlEventTouchUpInside];
    
    usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;//账号输入键盘类型
    usernameTextField.delegate = self;
    
    passwordTextField.delegate = self;
    passwordTextField.secureTextEntry = YES;
}

- (void)viewDidUnload
{
    [self setUsernameTextField:nil];
    [self setPasswordTextField:nil];
    [self setLoginButton:nil];
    [self setRegisterButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - 返回，注册,登陆按钮方法

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showRegisterVC
{
    RegisterVC *registerVC = [[RegisterVC alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    [registerVC release];
}

-(void)login
{
    if ([usernameTextField.text length]==0 || [passwordTextField.text length]==0) 
    {
        [[LeveyHUD sharedHUD] appearWithText:@"用户名或密码为空"];
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(removeAlertView) userInfo:nil repeats:NO];
        return;
    }
    
    NSString *urls = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/loginmgr/login.aspx?loginname=%@&password=%@",usernameTextField.text,passwordTextField.text];//原始url
    EncryptURL *encryption = [[EncryptURL alloc]init];
    NSString *urlStr = [encryption getMD5String:urls];//url MD5加密
    [encryption release];
    NSString *encodeUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//UTF8 Encode处理
    
    NSURL *url = [NSURL URLWithString:encodeUrlStr];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if([self parseReceivedData:receivedData])//如果成功解析xml方法 返回登陆成功
    {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [documentPath stringByAppendingPathComponent:@"user.txt"];
        
        NSDictionary *userDic = [[NSDictionary alloc]initWithObjectsAndKeys:usernameTextField.text,@"username",passwordTextField.text,@"password",self.uticket,@"uticket", nil];
        
        [userDic writeToFile:filePath atomically:YES];//用户名,密码和uticket写入文件
        
        [self.navigationController popViewControllerAnimated:YES];//返回Home界面
        
        return;
    }
    
    [[LeveyHUD sharedHUD] appearWithText:@"用户名或密码错误"];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(removeAlertView) userInfo:nil repeats:NO];
}

#pragma mark - 移除警告提示视图

- (void)removeAlertView
{
    [[LeveyHUD sharedHUD] delayDisappear:0.1f withText:nil]; 
}

#pragma mark - 键盘回收

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == usernameTextField) {
        [usernameTextField resignFirstResponder];
        [passwordTextField becomeFirstResponder];
    }
    if (textField == passwordTextField) {
        [passwordTextField resignFirstResponder];
        [self login];
    }
    return YES;
}

#pragma mark - 重写dealloc

- (void)dealloc 
{
    self.username = nil;
    self.password = nil;
    [usernameTextField release];
    [passwordTextField release];
    [loginButton release];
    [registerButton release];
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
