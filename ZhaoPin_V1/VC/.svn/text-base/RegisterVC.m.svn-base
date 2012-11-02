//
//  RegisterVC.m
//  Zhaopin
//
//  Created by Ibokan on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RegisterVC.h"
#import "LeveyHUD.h"

@implementation RegisterVC
@synthesize emailTextField;
@synthesize phoneTextField;
@synthesize passwordTextField;
@synthesize rePasswordTextField;

@interface RegisterVC(private)

- (BOOL) validateUserEmail : (NSString *) str;
- (BOOL) validateUserPhone : (NSString *) str;
- (BOOL) validateUserPasswd : (NSString *) str;
- (BOOL) validatePasswdRepeat:(NSString *)str;

@end


#pragma mark - 生命周期

- (void)viewDidLoad
{
    [super viewDidLoad];
    emailTextField.delegate = self;
    passwordTextField.delegate = self;
    rePasswordTextField.delegate = self;
    phoneTextField.delegate = self;
    passwordTextField.secureTextEntry = YES;
    rePasswordTextField.secureTextEntry = YES;
}

- (void)viewDidUnload
{
    [self setEmailTextField:nil];
    [self setPhoneTextField:nil];
    [self setPasswordTextField:nil];
    [self setRePasswordTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - 键盘回收

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == emailTextField) {
        [emailTextField resignFirstResponder];
        [phoneTextField becomeFirstResponder];
    }
    if (textField == phoneTextField) {
        [phoneTextField resignFirstResponder];
        [passwordTextField becomeFirstResponder];
    }
    if (textField == passwordTextField) {
        [rePasswordTextField becomeFirstResponder];
    }
    if (textField == rePasswordTextField) {
        [rePasswordTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark - 返回，注册按钮方法

- (IBAction)register:(id)sender
{
    if ([self validateUserEmail:emailTextField.text]==NO)
    {
        [[LeveyHUD sharedHUD] appearWithText:@"邮箱格式格式错误"];
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(removeAlertView) userInfo:nil repeats:NO];        
        return;
    }
    if ([self validateUserPhone:phoneTextField.text]==NO)
    {
        [[LeveyHUD sharedHUD] appearWithText:@"手机号输入错误"];
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(removeAlertView) userInfo:nil repeats:NO];
        return;
    }
    if ([self validateUserPasswd:passwordTextField.text]==NO)
    {
        [[LeveyHUD sharedHUD] appearWithText:@"密码由6为以上数字或字母组成"];
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(removeAlertView) userInfo:nil repeats:NO];
        return;
    }
    if ([self validatePasswdRepeat:rePasswordTextField.text]==NO)
    {
        [[LeveyHUD sharedHUD] appearWithText:@"密码两次输入不同"];
        [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(removeAlertView) userInfo:nil repeats:NO];
        return;
    }
    
    [[LeveyHUD sharedHUD] appearWithText:@"账号注册成功"];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(removeAlertView) userInfo:nil repeats:NO];
}

- (IBAction)back:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 注册信息校验

- (BOOL) validateUserEmail:(NSString *)str  
{       
    NSString * regex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

- (BOOL) validateUserPhone:(NSString *)str  
{  
    NSString * regex = @"\\b(1)[358][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\\b";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;  
}  

- (BOOL) validateUserPasswd : (NSString *) str  
{    
    NSString * regex = @"^[a-zA-Z0-9]{6,16}$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

- (BOOL) validatePasswdRepeat:(NSString *)str
{
    if ([passwordTextField.text isEqualToString:rePasswordTextField.text]) {
        return YES;
    }
    return NO;
}

#pragma mark - 移除警告提示视图

- (void)removeAlertView
{
   [[LeveyHUD sharedHUD] delayDisappear:0.1f withText:nil]; 
}

#pragma mark - 重写dealloc

- (void)dealloc 
{
    [emailTextField release];
    [phoneTextField release];
    [passwordTextField release];
    [rePasswordTextField release];
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
