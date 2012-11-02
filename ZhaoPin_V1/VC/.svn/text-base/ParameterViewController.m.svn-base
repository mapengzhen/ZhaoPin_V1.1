//
//  ParameterViewController.m
//
//  Created by 吴育星 on 12-10-9.



#import "ParameterViewController.h"

@interface ParameterViewController()

- (void)getSourceData;  //取得所需数据 显示在tableview上
- (void)getPositionOrPlace:(NSString *)name; //取得职位名称和工作地点
- (void)getIndustry:(NSString *)name;   //取得行业

@end

@implementation ParameterViewController
@synthesize parameterTableView;
@synthesize titleLabel;
@synthesize selectRow,sourceDataArr,sourceDataDic,detailTitle;
@synthesize delegate;


- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark 初始化

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    if (self.sourceDataArr == nil) {
        
        [self getSourceData];   //取得所需数据 显示在tableview上 并设置navigationitem的title
        
    } else {
        
        //NSDictionary *titleAttribute= [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Arial" size:17] forKey:UITextAttributeFont];
        //[self.navigationController.navigationBar setTitleTextAttributes:titleAttribute];
        self.titleLabel.text = self.detailTitle;
    }
    
    parameterTableView.delegate = self;
    parameterTableView.dataSource = self;
}


#pragma mark 私有方法

//取得所需数据 显示在tableview上

- (void)getSourceData     
{
    //判断选中的row 给tableview数据源
    switch (self.selectRow) {  
        case 1: //职位名称
        {
            self.navigationItem.title = @"选择职位";
            [self getPositionOrPlace:@"position"];      //取得职位名称和工作地点
            self.titleLabel.text = @"职位";
            break;
        }
            
        case 2: //行业
        { 
            self.navigationItem.title = @"选择行业";
            [self getIndustry:@"industry"];     //取得行业
            self.titleLabel.text = @"行业";
            break;
        }
            
        case 3:  //工作地点
        {
            self.navigationItem.title = @"选择地点";
            [self getPositionOrPlace:@"place"];    //取得职位名称和工作地点
            self.titleLabel.text = @"工作地点";
            break;
        }
            
        case 5:  //发布时间
        {
            self.navigationItem.title = @"选择发布时间";
            self.sourceDataArr = [[NSMutableArray alloc]initWithObjects:@"不限",@"今天",@"最近三天",@"最近一周",@"最近一个月", nil];
            [self.sourceDataArr release];
            break;
        }
        case 6:  //工作经验
        {   
            self.navigationItem.title = @"选择工作经验";
            self.sourceDataArr = [[NSMutableArray alloc]initWithObjects:@"不限",@"无经验",@"1年以下",@"1-3年",@"3-5年",@"5-10年",@"10年以上", nil];
            [self.sourceDataArr release];
            break;
        }
        case 7: //学历
        {   
            self.navigationItem.title = @"选择学历";
            self.sourceDataArr = [[NSMutableArray alloc]initWithObjects:@"不限",@"大专",@"本科",@"硕士",@"博士",@"MBA",@"EMBA",@"中专",@"中技",@"高中",@"初中",@"其他", nil];
            [self.sourceDataArr release];
            break;
        }
        case 8:  //企业性质
        {            
            self.navigationItem.title = @"选择公司性质";
            self.sourceDataArr = [[NSMutableArray alloc]initWithObjects:@"不限",@"国企",@"外商独资",@"代表处",@"合资",@"民营",@"国家机关",@"其他",@"股份制企业",@"上市公司",@"事业单位",nil];
            [self.sourceDataArr release];
            break;
        }
        case 9:  //企业人数
        {   
            self.navigationItem.title = @"选择公司规模";
            self.sourceDataArr = [[NSMutableArray alloc]initWithObjects:@"不限",@"20人以下",@"20-99人",@"100-499人",@"500-999人",@"1000-9999人",@"10000人以上",nil];
            [self.sourceDataArr release];
            break;
        }
        default:
            break;
    }
    
    NSLog(@"%d",[self.sourceDataArr count]);
}

//取得职位名称和工作地点
- (void)getPositionOrPlace:(NSString *)name  
{
    self.sourceDataArr = [[NSMutableArray alloc]init];
    self.sourceDataDic = [[NSMutableDictionary alloc]init];
    
    NSString *sourceData = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    
    for(NSString *str in [sourceData componentsSeparatedByString:@"\n"])
    {
        NSString *str1 = [[str componentsSeparatedByString:@"#"]objectAtIndex:0];
        NSString *str2 = [[str componentsSeparatedByString:@"#"]objectAtIndex:1];
        //NSLog(@"%@",str1);
        [self.sourceDataArr addObject:str1];
        NSMutableArray *detaiArr = [[NSMutableArray alloc]init];
        for (NSString *detail in [str2 componentsSeparatedByString:@"*"]) {
            
            [detaiArr addObject:detail];
            //NSLog(@"%@",detail);
        }
        
        [self.sourceDataDic setObject:detaiArr forKey:str1];
        [detaiArr release];
        
    }
    
    [self.sourceDataArr release];
    [self.sourceDataDic release];

}
 
//取得行业
- (void)getIndustry:(NSString *)name  
{
    self.sourceDataArr = [[NSMutableArray alloc]init];
    
    NSString *sourceData = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    
    for(NSString *positon in [sourceData componentsSeparatedByString:@"\n"])
    {

        //NSLog(@"%@",positon);
        [self.sourceDataArr addObject:positon];
            
    }
    
    [self.sourceDataArr release];
}


#pragma mark tableview的代理方法

//section的个数  
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; 
}

//row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sourceDataArr count];
}

//设置row的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35; 
}

//自定义cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
        if (self.sourceDataDic != nil) 
        { //是否要取 职位 或 工作地点
            UIImageView *accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"accessoryArrow.png"]];
            [cell setAccessoryView:accessoryView];
            [accessoryView release];
        }
    }
    
    cell.textLabel.text = [self.sourceDataArr objectAtIndex:indexPath.row];
    
    return cell;
    
}

//选中cell时

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.sourceDataDic != nil) 
    { //是否要取 职位 或 工作地点
        
        ParameterViewController *parameter = [[[ParameterViewController alloc]init]autorelease];;
        parameter.delegate = self;
        NSString *str = [self.sourceDataArr objectAtIndex:indexPath.row];
        parameter.sourceDataArr = [self.sourceDataDic objectForKey:str];
        parameter.selectRow = self.selectRow;
        parameter.detailTitle = str;
        [self.navigationController pushViewController:parameter animated:YES];
        
    } else {
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(getData:selectRow:)]) {
            
            [self.delegate getData:[self.sourceDataArr objectAtIndex:indexPath.row] selectRow:self.selectRow];
        }
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
        
    }
}

//协议方法

- (void)getData:(NSString *)parameter selectRow:(NSInteger)row  
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(getData:selectRow:)]) {
        
        [self.delegate getData:parameter selectRow:row];
    }
    //NSLog(@"%@ %d",str,row);
}

- (void)viewDidUnload
{
    [self setParameterTableView:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    
    self.detailTitle = nil;
    self.sourceDataArr = nil;
    self.sourceDataDic = nil;
    [parameterTableView release];
    [titleLabel release];
    [super dealloc];
}
@end
