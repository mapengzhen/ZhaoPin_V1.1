//
//  dfdf.m
//  Zhaopin
//
//  Created by Ibokan on 12-10-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "JobTableViewController.h"
#import "HomeVC.h"
#import "JobDetailVC.h"

#import "Job.h"
#import "JobCell.h"

#import "EncryptURL.h"
#import "GDataXMLNode.h"
#import "MBProgressHUD.h"

@implementation JobTableViewController

@synthesize jobTable = _jobTable;
@synthesize searchBar = _searchBar;

@synthesize experienceBtn = _experienceBtn,salaryRangeBtn = _salaryRangeBtn,releaseTimeBtn = _releaseTimeBtn;
@synthesize experience = _experience,salaryRange = _salaryRange,releaseTime = _releaseTime;
@synthesize experienceArr = _experienceArr,salaryRangeArr = _salaryRangeArr,releaseTimeArr = _releaseTimeArr;
@synthesize experienceBar = _experienceBar,salaryRangeBar = _salaryRangeBar,releaseTimeBar = _releaseTimeBar;

@synthesize parameterDic = _parameterDic;
@synthesize urlString = _urlString;
@synthesize curPage = _curPage;
@synthesize workingExp = _workingExp;
@synthesize data_refresh = _data_refresh;
@synthesize salaryfrom = _salaryfrom;
@synthesize salaryto = _salaryto;
@synthesize key = _key;

@synthesize jobArr = _jobArr,jobArrData = _jobArrData,moreJobArr = _moreJobArr,moreJobData = _moreJobData,applyJobData = _applyJobData;
@synthesize jobArrConnection = _jobArrConnection,moreJobArrConnection = _moreJobArrConnection,applyJobConnection = _applyJobConnection;
@synthesize loadMoreUrlString = _loadMoreUrlString;

@synthesize cellButtonIsSelectArr = _cellButtonIsSelectArr;
@synthesize jobNumber = _jobNumber,uticket = _uticket;
@synthesize noSignUp = _noSignUp;

@synthesize loadMoreView = _loadMoreView;
@synthesize isLoadingMore = _isLoadingMore;

- (void)dealloc {
    self.jobTable = nil;
    self.searchBar = nil;
    
    self.experienceBtn = nil;
    self.salaryRangeBtn = nil;
    self.releaseTimeBtn = nil;
    self.experience = nil;
    self.salaryRange = nil;
    self.releaseTime = nil;
    self.experienceArr = nil;
    self.salaryRangeArr = nil;
    self.releaseTimeArr = nil;
    self.experienceBar = nil;
    self.salaryRangeBar = nil;
    self.releaseTimeBar = nil;
    
    self.parameterDic = nil;
    self.urlString = nil;
    self.workingExp = nil;
    self.data_refresh = nil;
    self.salaryfrom = nil;
    self.salaryto = nil;
    self.key = nil;
    
    self.jobArr = nil;
    self.moreJobArr = nil;
    self.jobArrData = nil;
    self.moreJobData = nil;
    self.jobArrConnection = nil;
    self.moreJobArrConnection = nil;
    self.applyJobConnection = nil;
    self.loadMoreUrlString = nil;
    self.cellButtonIsSelectArr = nil;
    
    self.jobNumber = nil;
    self.uticket = nil;
    self.noSignUp = nil;
    
    self.loadMoreView = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [super dealloc];
}


#pragma mark 网络连接 网络解析

//初始化哪个按钮被选中的数组
- (void)initCellButtonIsSelectArr  {
    self.cellButtonIsSelectArr = [[NSMutableArray alloc]init];
    
    for (int i = 0;i < [self.jobArr count]; i++) {  //未选中设置为-1,选中则为职位所在的row
        
        NSString *str = @"-1";
        [_cellButtonIsSelectArr addObject:str];
    }
    
    [_cellButtonIsSelectArr release];
}

//发送查询职位网络请求
- (void)sendUrlString{

    _curPage = 1;

    self.urlString = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/search/searchjob.aspx?type=1&pagesize=30&sort=zf&page=%d",_curPage];
    
    NSString *urlString = [NSString stringWithFormat:self.urlString];
    
    NSMutableArray *keys = [[_parameterDic allKeys]objectAtIndex:0];
    NSMutableArray *values = [_parameterDic objectForKey:keys];
    
    NSLog(@"%d %d",keys.count,values.count);
    
    if ((keys.count > 0) && (values.count > 0)) {
        
        for (int i = 0; i < keys.count; i++) {
            
            NSString *key = [keys objectAtIndex:i];
            NSString *value = [values objectAtIndex:i];
            
            if (![key isEqualToString:@"key_word"]) {
                urlString = [urlString stringByAppendingFormat:@"&%@=%@",key,value];
            } else {
                if (![value isEqualToString:@""]) {
                    if ((_key != nil) && (![_key isEqualToString:@""])){
                        urlString = [urlString stringByAppendingFormat:@"&%@=%@",key,_key];
                    } else {
                        urlString = [urlString stringByAppendingFormat:@"&%@=%@",key,value];
                    }
                } else {
                    NSLog(@"%s %d",__FUNCTION__,__LINE__);
                    if ((_key != nil) && (![_key isEqualToString:@""])){
                        urlString = [urlString stringByAppendingFormat:@"&%@=%@",key,_key];
                    }
                }
            }
            
        } 
    } else {
        if ((_key != nil) && (![_key isEqualToString:@""])){
            urlString = [urlString stringByAppendingFormat:@"&%@=%@",@"key_word",_key];
        }
    }

    if ((_workingExp != nil) && (![_workingExp isEqualToString:@"c"]) ) {
        urlString = [urlString stringByAppendingFormat:@"&workingexp=%@",_workingExp];
    }
    if ((_data_refresh != nil) && (![_data_refresh isEqualToString:@"c"])) {
        urlString = [urlString stringByAppendingFormat:@"&data_refresh=%@",_data_refresh];
    }
    if ((_salaryfrom != nil) && (![_salaryfrom isEqualToString:@"c"])) {
        urlString = [urlString stringByAppendingFormat:@"&salaryfrom=%@",_salaryfrom];
    }
    if ((_salaryto != nil) && (![_salaryto isEqualToString:@"c"])) {
        urlString = [urlString stringByAppendingFormat:@"&data_refresh=%@",_salaryto];
    }
    
    NSLog(@"%@",urlString);

    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.loadMoreUrlString = [[[NSString alloc]initWithFormat:urlString]autorelease];
    NSLog(@"%@",urlString);
    EncryptURL *e = [[EncryptURL alloc]init];
    NSURL *url = [NSURL URLWithString:[e getMD5String:urlString]];
    self.jobArrConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];

}

//加载更多
- (void)sendLoadMoreJobUrlRequeset
{
    //NSLog(@"wwwwwww%d",_curPage);
    //NSLog(@"dddddddd%@",[_loadMoreUrlString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"page=%d",_curPage-1] withString:[NSString stringWithFormat:@"page=%d",_curPage]]);
    
    NSString *urlStr = [_loadMoreUrlString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"page=%d",_curPage-1] withString:[NSString stringWithFormat:@"page=%d",_curPage]];
    NSLog(@"%@",urlStr);
    
    EncryptURL *e = [[EncryptURL alloc]init];
    NSURL *url = [NSURL URLWithString:[e getMD5String:urlStr]];
    self.moreJobArrConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    
    self.loadMoreUrlString = urlStr;//[_loadMoreUrlString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"page=%d",_curPage-1] withString:[NSString stringWithFormat:@"page=%d",_curPage]];
}

//申请职位
- (void)sendApplyPositionRequest:(NSString *)urlStr 
{
    EncryptURL *encrpy = [[EncryptURL alloc]init];
    NSString *encrpyStr = [encrpy getMD5String:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];  //如果需要对中文转码
    NSURL *url = [[NSURL alloc]initWithString:encrpyStr];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    self.applyJobConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}


- (void)loadJobArr   //当接收完数据调用  解析XML数据
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.jobArr = [[NSMutableArray alloc]init];  //初始化
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:self.jobArrData options:0 error:nil];
    GDataXMLElement *root = [document rootElement];
    
    for(GDataXMLElement *position in [root nodesForXPath:@"result/position" error:nil])
    {
        //NSLog(@"%s %d",__FUNCTION__,__LINE__);
        NSString *jobNumber = [[[position nodesForXPath:@"job_number" error:nil]objectAtIndex:0]stringValue];
        NSString *jobName = [[[position nodesForXPath:@"job_title" error:nil]objectAtIndex:0]stringValue];
        NSString *companyNumber = [[[position nodesForXPath:@"company_number" error:nil]objectAtIndex:0]stringValue];
        NSString *companyName = [[[position nodesForXPath:@"company_name" error:nil]objectAtIndex:0]stringValue];
        NSString *city = [[[position nodesForXPath:@"city_id" error:nil]objectAtIndex:0]stringValue];
        NSString *date = [[[position nodesForXPath:@"date_opening" error:nil]objectAtIndex:0]stringValue];
        
        Job *job = [Job jobWitnName:jobName Number:jobNumber companyName:companyName companyNumber:companyNumber city:city date:date];
        [self.jobArr addObject:job];
        
    }
    [self.jobArr release];
    
    [self initCellButtonIsSelectArr];  //cell的按钮
    [_jobTable reloadData];
}

- (void)loadMoreJobArr
{
    
    self.moreJobArr = [[NSMutableArray alloc]init];  //初始化
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:_moreJobData options:0 error:nil];
    GDataXMLElement *root = [document rootElement];
    
    for(GDataXMLElement *position in [root nodesForXPath:@"result/position" error:nil])
    {
        //NSLog(@"%s %d",__FUNCTION__,__LINE__);
        NSString *jobNumber = [[[position nodesForXPath:@"job_number" error:nil]objectAtIndex:0]stringValue];
        NSString *jobName = [[[position nodesForXPath:@"job_title" error:nil]objectAtIndex:0]stringValue];
        NSString *companyNumber = [[[position nodesForXPath:@"company_number" error:nil]objectAtIndex:0]stringValue];
        NSString *companyName = [[[position nodesForXPath:@"company_name" error:nil]objectAtIndex:0]stringValue];
        NSString *city = [[[position nodesForXPath:@"city_id" error:nil]objectAtIndex:0]stringValue];
        NSString *date = [[[position nodesForXPath:@"date_opening" error:nil]objectAtIndex:0]stringValue];
        
        Job *job = [Job jobWitnName:jobName Number:jobNumber companyName:companyName companyNumber:companyNumber city:city date:date];
        [self.moreJobArr addObject:job];
        
    }
    [self.moreJobArr release];
    
    if ([_moreJobArr count] > 0) {
        
        [_jobArr addObjectsFromArray:_moreJobArr];
        [self initCellButtonIsSelectArr];  //cell的按钮
            [_jobTable reloadData];
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"没有数据拉" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [_loadMoreView removeFromSuperview];
    }
}

- (void)getApplyPositionData   //解析申请职位返回的XML数据    
{
    NSLog(@"%@",[[NSString alloc]initWithData:_applyJobData encoding:NSUTF8StringEncoding]);
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:_applyJobData options:0 error:nil];
    GDataXMLElement *root = [document rootElement];
    
    NSString *message = [[[root nodesForXPath:@"message" error:nil]objectAtIndex:0]stringValue];  //返回的信息 
    
    //NSString *finish = [[[root nodesForXPath:@"finish" error:nil]objectAtIndex:0]stringValue]; //几个职位申请成功
    //NSString *setdefaultresume = [[[root nodesForXPath:@"setdefaultresume" error:nil]objectAtIndex:0]stringValue]; //设置默认简历是否成功
    
    //NSLog(@"%@ %@ %@",message,finish,setdefaultresume);
    
    if ([message isEqualToString:@"职位申请成功"]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"职位申请成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"职位申请失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        [alert release];
    }
    
}

#pragma mark 初始化pickerView

//调整pickView的位置
- (void)adjustExperience{
    if (_experience.frame.origin.y >= 500) {
        [UIView animateWithDuration:0.5 animations:^{
            _experience.frame = CGRectMake(0, 300, 320, 100);
            _experienceBar.frame = CGRectMake(0, 260, 320, 40);
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            _experience.frame = CGRectMake(0, 500, 320, 100);
            _experienceBar.frame = CGRectMake(0, 460, 320, 40);
        }];
    }
}
- (void)adjustSalaryRange{
    if (_salaryRange.frame.origin.y >= 500) {
        [UIView animateWithDuration:0.5 animations:^{
            _salaryRange.frame = CGRectMake(0, 300, 320, 100);
            _salaryRangeBar.frame = CGRectMake(0, 260, 320, 40);
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            _salaryRange.frame = CGRectMake(0, 500, 320, 100);
            _salaryRangeBar.frame = CGRectMake(0, 460, 320, 40);
        }];
    }
}
- (void)adjustReleaseTime{
    if (_releaseTime.frame.origin.y >= 500) {
        [UIView animateWithDuration:0.5 animations:^{
            _releaseTime.frame = CGRectMake(0, 300, 320, 100);
            _releaseTimeBar.frame = CGRectMake(0, 260, 320, 40);
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            _releaseTime.frame = CGRectMake(0, 500, 320, 100);
            _releaseTimeBar.frame = CGRectMake(0, 460, 320, 40);
        }];
    }
}

//当键盘升起
- (void)adjustPickerView
{
    if (_experience.frame.origin.y < 500) {
        [self adjustExperience];
    }
    if (_salaryRange.frame.origin.y < 500) {
        [self adjustSalaryRange];
    }
    if (_releaseTime.frame.origin.y < 500) {
        [self adjustReleaseTime];
    }
}

//当点击完成后
- (void)sureExperience{
    self.workingExp = [NSString stringWithFormat:@"c"];
    NSString *experience = [_experienceBtn titleForState:UIControlStateNormal];
    switch ([_experienceArr indexOfObject:experience]) {
        case 1:{
            _workingExp = @"0000";
            break;
        }   
        case 2:{
            _workingExp = @"0001";
            break;
        }  
        case 3:{
            _workingExp = @"0103";
            break;
        }  
        case 4:{
            _workingExp = @"0305";
            break;
        }  
        case 5:{
            _workingExp = @"0510";
            break;
        }  
        case 6:{
            _workingExp = @"1099";
            break;
        }  
        default:
            break;
    }
    [self sendUrlString];
    [self adjustExperience];
}
- (void)sureSalaryRange{
    self.salaryfrom = [NSString stringWithFormat:@"c"];
    self.salaryto = [NSString stringWithFormat:@"c"];
    _salaryRangeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    NSString *salaryRange = [_salaryRangeBtn titleForState:UIControlStateNormal];
    switch ([_salaryRangeArr indexOfObject:salaryRange]) {
        case 1:{
            _salaryfrom = @"0";
            _salaryto = @"1000";
            break;
        }   
        case 2:{
            _salaryfrom = @"1000";
            _salaryto = @"2000";
            break;
        }  
        case 3:{
            _salaryfrom = @"2001";
            _salaryto = @"4000";
            break;
        }  
        case 4:{
            _salaryfrom = @"4001";
            _salaryto = @"6000";
            break;
        }  
        case 5:{
            _salaryfrom = @"6001";
            _salaryto = @"8000";
            break;
        }  
        case 6:{
            _salaryfrom = @"8001";
            _salaryto = @"10000";
            break;
        }  
        case 7:{
            _salaryfrom = @"10001";
            _salaryto = @"15000";
            break;
        } 
        case 8:{
            _salaryfrom = @"15001";
            _salaryto = @"25000";
            break;
        } 
        case 9:{
            _salaryfrom = @"25000";
            break;
        } 
        case 10:{
            _salaryfrom = @"0";
            break;
        } 
        default:
            break;
    }
    [self sendUrlString];
    [self adjustSalaryRange];
}
- (void)sureReleaseTime{
    self.data_refresh = [NSString stringWithFormat:@"c"];
    NSString *releaseTime = [_releaseTimeBtn titleForState:UIControlStateNormal];
    switch ([_releaseTimeArr indexOfObject:releaseTime]) {
        case 1:{
            _data_refresh = @"1";
            break;
        }   
        case 2:{
            _data_refresh = @"3";
            break;
        }  
        case 3:{
            _data_refresh = @"7";
            break;
        }  
        case 4:{
            _data_refresh = @"30";
            break;
        }  
        default:
            break;
    }
    [self sendUrlString];
    [self adjustReleaseTime];
}

//初始化pickerView
- (void)loadPickerViewData{
    self.experienceArr = [NSArray arrayWithObjects:@"不限",@"无经验",@"一年以下",@"1-3年",@"3-5年",@"5-10年",@"10年以上", nil];
    self.salaryRangeArr = [NSArray arrayWithObjects:@"不限",
                           @"1000元以下",@"1000-2000元/月",
                           @"2001-4000元/月",@"4001-6000元/月",
                           @"6001-8000元/月",@"8001-10000元/月",
                           @"10001-15000元/月",@"15001-25000元/月",
                           @"25000元/月以上",@"面议", 
                           nil];
    self.releaseTimeArr = [NSArray arrayWithObjects:@"不限",@"今天",@"最近三天",@"最近一周",@"最近一个月", nil];
}
- (void)loadPickerView{
    self.experience = [[[UIPickerView alloc]initWithFrame:CGRectMake(0, 500, 320, 100)]autorelease];
    _experience.showsSelectionIndicator = YES;
    _experience.delegate = self;
    _experience.dataSource = self;
    [self.view addSubview:_experience];
    self.experienceBar = [[[UIToolbar alloc]initWithFrame:CGRectMake(0, 460, 320, 40)]autorelease];
    _experienceBar.tintColor = [UIColor blackColor];
    [self.view addSubview:_experienceBar];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(265, 5, 40, 30);
    [btn1 setTitle:@"完成" forState:UIControlStateNormal];
    btn1.showsTouchWhenHighlighted = YES;
    [btn1 addTarget:self action:@selector(sureExperience) forControlEvents:UIControlEventTouchUpInside];
    [_experienceBar addSubview:btn1];
    
    self.salaryRange = [[[UIPickerView alloc]initWithFrame:CGRectMake(0, 500, 320, 100)]autorelease];
    _salaryRange.showsSelectionIndicator = YES;
    _salaryRange.delegate = self;
    _salaryRange.dataSource = self;
    [self.view addSubview:_salaryRange];
    self.salaryRangeBar = [[[UIToolbar alloc]initWithFrame:CGRectMake(0, 460, 320, 40)]autorelease];
    _salaryRangeBar.tintColor = [UIColor blackColor];
    [self.view addSubview:_salaryRangeBar];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(265, 5, 40, 30);
    [btn2 setTitle:@"完成" forState:UIControlStateNormal];
    btn2.showsTouchWhenHighlighted = YES;
    [btn2 addTarget:self action:@selector(sureSalaryRange) forControlEvents:UIControlEventTouchUpInside];
    [_salaryRangeBar addSubview:btn2];
    
    self.releaseTime = [[[UIPickerView alloc]initWithFrame:CGRectMake(0, 500, 320, 100)]autorelease];
    _releaseTime.showsSelectionIndicator = YES;
    _releaseTime.delegate = self;
    _releaseTime.dataSource = self;
    [self.view addSubview:_releaseTime];
    self.releaseTimeBar = [[[UIToolbar alloc]initWithFrame:CGRectMake(0, 460, 320, 40)]autorelease];
    _releaseTimeBar.tintColor = [UIColor blackColor];
    [self.view addSubview:_releaseTimeBar];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(265, 5, 40, 30);
    [btn3 setTitle:@"完成" forState:UIControlStateNormal];
    btn3.showsTouchWhenHighlighted = YES;
    [btn3 addTarget:self action:@selector(sureReleaseTime) forControlEvents:UIControlEventTouchUpInside];
    [_releaseTimeBar addSubview:btn3];
}

- (void)getUticketAndInitJobNumber
{
    NSDictionary *dic  = [NSDictionary dictionaryWithContentsOfFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"user.txt"]];
    self.uticket = [dic objectForKey:@"uticket"];
    NSLog(@"ttttttttt%@",_uticket);
}

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustPickerView) name:UIKeyboardWillShowNotification object:nil];
    MBProgressHUD *mb = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mb.labelText = @"加载中";
    
    [self loadPickerViewData];
    [self loadPickerView];
    [self sendUrlString];
    [self getUticketAndInitJobNumber];
    
    if (_loadMoreView == nil) {
        
        _loadMoreView = [[LoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0.0f, _jobTable.contentSize.height, _jobTable.frame.size.width, _jobTable.bounds.size.height)];
        _loadMoreView.delegate = self;
        [_jobTable addSubview:_loadMoreView];
                
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
#pragma mark searchBar代理方法

//点击搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.key = _searchBar.text;
    [self sendUrlString];
    [_searchBar resignFirstResponder];
}


//返回上个界面
- (IBAction)backTo:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//申请职位
- (IBAction)applyJob:(id)sender {
    BOOL haveSelect = NO;  //是否有被选中的职位
    
    for(NSString *str in self.cellButtonIsSelectArr)
    {
        if (![str isEqualToString:@"-1"]) {
            
            haveSelect = YES;
        }
    }
    
    if (haveSelect == NO) 
    {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"您还未选中任何职位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        
    } else {
        
        HomeVC *home =  [HomeVC instance];
        if (!home.loginded){//_uticket == nil) {  //是否登陆
            
            self.noSignUp = [[UIAlertView alloc]initWithTitle:@"警告" message:@"您还未登陆,无法提交简历" delegate:self cancelButtonTitle:@"放弃" otherButtonTitles:@"登陆", nil];
            _noSignUp.delegate = self;
            [self.noSignUp show];
            [_noSignUp release];
            
        } else {
            
            NSLog(@"%s %d",__FUNCTION__,__LINE__);
            
            int selectNum = 1;
            
            for(int i = 0; i < [_cellButtonIsSelectArr count] ; i++)
            {
                
                NSString *str = [_cellButtonIsSelectArr objectAtIndex:i];
                
                
                if (![str isEqualToString:@"-1"]) {
                    
                    
                    if (selectNum > 1) {
                        
                        Job *job = [self.jobArr objectAtIndex:[str intValue]];
                        self.jobNumber = [_jobNumber stringByAppendingFormat:@",%@",job.number];
                        
                    } else {
                        
                        Job *job = [self.jobArr objectAtIndex:[str intValue]];
                            self.jobNumber = job.number;
                        selectNum++;

                    }
                    
                }
                
            }

            
            EncryptURL *e = [[EncryptURL alloc]init];
            
            
            NSDictionary *dic  = [NSDictionary dictionaryWithContentsOfFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"user.txt"]];
            
            
            NSString *urlSt = [e getMD5String:[NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/myzhaopin/loginmgr/login.aspx?loginname=%@&password=%@",[dic objectForKey:@"username"],[dic objectForKey:@"password"]]];
            NSString *data = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlSt] encoding:NSUTF8StringEncoding error:nil];
            
            
            GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithXMLString:data options:0 error:nil];
            
            GDataXMLElement *root = [document rootElement];
            NSString *resume_id = [[[root nodesForXPath:@"//resume_id" error:nil]objectAtIndex:0]stringValue];
            NSString *resume_number = [[[root nodesForXPath:@"//resume_number" error:nil]objectAtIndex:0]stringValue];
            //NSString *version_number = [[[root nodesForXPath:@"//version_number" error:nil]objectAtIndex:0]stringValue];
            
            //NSLog(@"%@ %@ %@",resume_id,resume_number,version_number);
            
            NSString *urlStr = [NSString stringWithFormat:@"http://wapinterface.zhaopin.com/iphone/job/batchaddposition.aspx?uticket=%@&Resume_id=%@&Resume_number=%@&Version_number=%d&Job_number=%@&needSetDefResume=1",_uticket,resume_id,resume_number,6,_jobNumber];

            
            NSLog(@"%@",urlStr);
            [self sendApplyPositionRequest:urlStr];
        }
    }     

}


#pragma mark 职位筛选按钮

//选择工作经验
- (IBAction)experience:(id)sender {
    [_searchBar resignFirstResponder];
    if (_experience.frame.origin.y >= 500) {
        [self adjustExperience];
    }
    if (_salaryRange.frame.origin.y < 500) {
        [self adjustSalaryRange];
    }
    if (_releaseTime.frame.origin.y < 500) {
        [self adjustReleaseTime];
    }
}

//选择月薪范围
- (IBAction)salaryRange:(id)sender {
    [_searchBar resignFirstResponder];
    if (_experience.frame.origin.y < 500) {
        [self adjustExperience];
    }
    if (_salaryRange.frame.origin.y >= 500) {
        [self adjustSalaryRange];
    }
    if (_releaseTime.frame.origin.y < 500) {
        [self adjustReleaseTime];
    }
}

//选择发布时间
- (IBAction)releaseTime:(id)sender {
    [_searchBar resignFirstResponder];
    if (_experience.frame.origin.y < 500) {
        [self adjustExperience];
    }
    if (_salaryRange.frame.origin.y < 500) {
        [self adjustSalaryRange];
    }
    if (_releaseTime.frame.origin.y >= 500) {
        [self adjustReleaseTime];
    }
}




#pragma mark pickerview的代理方法

//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == _experience) {
        
        return [_experienceArr count];
    }
    if (pickerView == _salaryRange) {
        return [_salaryRangeArr count];
    }
    if (pickerView == _releaseTime) {
        return [_releaseTimeArr count];
    }
    return 0;
}

//每行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == _experience) {
        
        return [_experienceArr objectAtIndex:row];
    }
    if (pickerView == _salaryRange) {
        return [_salaryRangeArr objectAtIndex:row];
    }
    if (pickerView == _releaseTime) {
        return [_releaseTimeArr objectAtIndex:row];
    }
    
    return nil;
}

//停止滚动后
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == _experience) {
        [_experienceBtn setTitle:[_experienceArr objectAtIndex:row] forState:UIControlStateNormal];
    }
    if (pickerView == _salaryRange) {
        [_salaryRangeBtn setTitle:[_salaryRangeArr objectAtIndex:row] forState:UIControlStateNormal];
    }
    if (pickerView == _releaseTime) {
        [_releaseTimeBtn setTitle:[_releaseTimeArr objectAtIndex:row] forState:UIControlStateNormal];
    }
}



#pragma mark 异步请求的代理方法

//收到请求响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (connection == _jobArrConnection) {
        self.jobArrData = [[[NSMutableData alloc]init]autorelease];
    } else if(connection == _applyJobConnection){
        self.applyJobData = [[[NSMutableData alloc]init]autorelease];
    } else if(connection == _moreJobArrConnection){
        self.moreJobData = [[[NSMutableData alloc]init]autorelease];
    }
}

//开始接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data  {
    if (connection == _jobArrConnection) {
        [_jobArrData appendData:data];
    } else if(connection == _applyJobConnection){
        [_applyJobData appendData:data];
    } else if(connection == _moreJobArrConnection){
        [_moreJobData appendData:data];
    }
}

//数据接收完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection   {
    if (connection == _jobArrConnection) {
        [self performSelector:@selector(loadJobArr) withObject:self afterDelay:1];
    } else if(connection == _applyJobConnection){
        [self getApplyPositionData];
    } else if(connection == _moreJobArrConnection){
        //NSLog(@"%@",[[NSString alloc]initWithData:_moreJobData encoding:NSUTF8StringEncoding]);
        [self loadMoreJobArr];
        
    }
}

//请求失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error  {
    if (connection == _jobArrConnection) {
        
        
    } else if(connection == _applyJobConnection)
    {
        
        
    }
}

#pragma mark alertView的代理方法


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == _noSignUp) {
        
        if (buttonIndex == 1) {
            
        }
    }

}

#pragma mark tableview代理方法 

//点击cell左边的按钮 改变保存哪个按钮被选中的按钮
- (void)changeImage:(UIButton *)btn  {
    btn.selected = !btn.selected;
    if ([[self.cellButtonIsSelectArr objectAtIndex:btn.tag]intValue] == -1) {
        NSString *str = [NSString stringWithFormat:@"%d",btn.tag];
        [self.cellButtonIsSelectArr replaceObjectAtIndex:btn.tag withObject:str];
        
    } else {
        NSString *str = @"-1";
        [self.cellButtonIsSelectArr replaceObjectAtIndex:btn.tag withObject:str];
        
    }    
}

//section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1; 
}

//row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_jobArr count];
}

//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

//cell显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Cell";
    JobCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (cell == nil) {
        
        cell = [[JobCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"accessoryArrow.png"]];
        [cell setAccessoryView:imageView];
        [imageView release];
    }
    
    Job *job = [self.jobArr objectAtIndex:indexPath.row];
    cell.jobNameLabel.text = job.name;
    cell.companyLabel.text = job.companyName;
    cell.dateLabel.text = job.date;
    cell.cityLabel.text = job.city;
    
    int isSelect = [[self.cellButtonIsSelectArr objectAtIndex:indexPath.row]intValue];
    cell.leftButton.selected = isSelect == -1 ? NO:YES;
    cell.leftButton.tag = indexPath.row;
    [cell.leftButton addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;

}

//cell被选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JobDetailVC *detail = [[JobDetailVC alloc]init];
    Job *job = [self.jobArr objectAtIndex:indexPath.row];
    detail.jobNumber = job.number;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}


#pragma mark - load more
- (void)loadMoreTableViewDataSource{
    
    _isLoadingMore = YES;
    _curPage++;
    [self sendLoadMoreJobUrlRequeset];
//    //在此写取数据代码
}



- (void)doneLoadMoreTableViewData{
    _isLoadingMore = NO;
    [_loadMoreView loadMoreScrollViewDataSourceDidFinishedLoading:_jobTable]; 
    NSLog(@"doneLoad");    
}



#pragma mark - LoadMoreTableFooterView delegate

-(void)loadMoreTableFooterDidTriggerRefresh:(LoadMoreTableFooterView *)view{
    
    _isLoadingMore = YES;
    
    [self loadMoreTableViewDataSource];
    [self performSelector:@selector(doneLoadMoreTableViewData) withObject:nil afterDelay:3.0];
    
    
}



-(BOOL)loadMoreTableFooterDataSourceIsLoading:(LoadMoreTableFooterView *)view{
    return _isLoadingMore;
}



#pragma mark - UIScrollViewDelegate Methods



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     [_loadMoreView loadMoreScrollViewDidScroll:scrollView];
    [_searchBar resignFirstResponder];
}
    

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{ 
    [_loadMoreView loadMoreScrollViewDidEndDragging:scrollView];
}

@end
