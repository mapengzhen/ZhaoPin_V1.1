//
//  MapViewController.m
//  Map
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MapViewController()

-(void)userGoogleMap;//使用谷歌自带地图导航

    
@end


@implementation MapViewController
@synthesize fromecorrdinate;
@synthesize startPoint=_startPoint,endPoint=_endPoint,jobName=_jobName,jobAddress=_jobAddress;

-(void)dealloc
{
    [locationManager release];
    [alertView1 release];
    [mapV release];
    locationManager=nil;
    alertView1=nil;
    mapV = nil;
    [super dealloc];
}

#pragma mark - 初始化方法


-(void)initMapView//初始化MapView
{

    
    mapV=[[MKMapView alloc] initWithFrame:CGRectMake(0, 44, 320, 460)];
    [mapV setMapType:MKMapTypeStandard];
    mapV.delegate=self;
    [self.view addSubview:mapV];
    NSLog(@"initMapView");
}

-(void)initLocationManager//初始化位置管理器
{
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);

    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;

    if ([CLLocationManager locationServicesEnabled]==YES) //判断是否有定位服务
    {
        
        NSLog(@"定位服务正常");
        NSLog(@"%s,%d",__FUNCTION__,__LINE__);
        locationManager.distanceFilter=1000.0f;         //100.0以米为单位，超过100米后重新定位
        [locationManager startUpdatingLocation];        //启动定位管理器进行定位，进入代理方法，实施定位
        
        
    }
    else
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"没有定位服务" message:@"!!!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
    }

}



-(void)initMKAnnotationAndcoordinateSpan//初始化大头针和坐标跨度
{
    if (!(int)self.fromecorrdinate.latitude) 
    {
        
        UIAlertView *lertView=[[UIAlertView alloc]initWithTitle:@"该招聘信息地址填写不规范" message:@"无法识别" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [lertView show];
        [lertView release];
        
        
        
        self.fromecorrdinate=CLLocationCoordinate2DMake(39.915, 116.397);
        Placeanonation *annotation=[[[Placeanonation alloc] initWithCoord:self.fromecorrdinate] autorelease];
        annotation.name=@" 钓鱼岛是中国的！";
        annotation.subTitle1=@" 苍井空才是世界的 ！ ！ ！";
        [mapV addAnnotation:annotation];
        
        MKCoordinateSpan theSpan;
        theSpan.latitudeDelta=60.0f;
        theSpan.longitudeDelta=60.0f;
        theRegion.span=theSpan;
        theRegion.center=self.fromecorrdinate; 
        //mapview的坐标区域，赋值
        [mapV setRegion:theRegion animated:YES];

    }
    
    else
    {
    
    //坐标区域：精度信息
    
    Placeanonation *annotation=[[[Placeanonation alloc] initWithCoord:self.fromecorrdinate] autorelease];
    NSLog(@"00000 !%f,%f",self.fromecorrdinate.latitude,self.fromecorrdinate.longitude);
    annotation.name=self.jobName;
    annotation.subTitle1=self.jobAddress;
    [mapV addAnnotation:annotation];
    
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta=0.01f;
    theSpan.longitudeDelta=0.01f;
    theRegion.span=theSpan;
    theRegion.center=self.fromecorrdinate; 
    //mapview的坐标区域，赋值
    [mapV setRegion:theRegion animated:YES];
    }
        
}

#pragma mark -viewDidLoad
- (void)viewDidLoad
{

    [super viewDidLoad];
    [self initMapView];
    [self initLocationManager];
    [self initMKAnnotationAndcoordinateSpan];
    
}

#pragma mark -返回按钮和查找路线的方法

- (IBAction)back:(id)sender//返回按钮的方法

{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setType:@"cube"];
    [animation setSubtype:kCATransitionFromLeft];    
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
    
}
- (IBAction)search:(id)sender//查找路线方法
{
    alertView1=[[UIAlertView alloc] initWithTitle:@"您确定要离开智联招聘" message:@"客户端吗!!!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView1 show];
}


-(void)userGoogleMap//使用谷歌自带地图导航
{

    NSLog(@"sss %@",self.endPoint);
    
    if (self.endPoint == nil)
    {
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"该招聘信息未填写工作地点" message:@"无法查找路线" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        NSString *theString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%@&daddr=%@",self.startPoint, self.endPoint];
        NSLog(@"startPoint = %@, endPoint = %@",self.startPoint,self.endPoint);
        
        theString =  [theString stringByAddingPercentEscapesUsingEncoding: 
                      NSUTF8StringEncoding];
        
        NSURL *url = [[NSURL alloc] initWithString:theString];
        
        [[UIApplication sharedApplication] openURL:url];
        //[self.navigationController pushViewController:searchRouteVC animated:YES];
    }
}

#pragma  mark CLLocationManager的代理方法

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{

    
    NSLog(@"获取当前位置信息");
    //通过经纬度得到中文地址
    CLLocation *cc = [[CLLocation alloc]initWithLatitude:39.9045 longitude:116.217];
   // CLLocation *cc=newLocation;
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:cc completionHandler:
     
     ^(NSArray* placemarks, NSError* error){
         
         if([[placemarks objectAtIndex:0]isKindOfClass:[CLPlacemark class]])
         {

             CLPlacemark *dd = [placemarks objectAtIndex:0];
             self.startPoint=dd.name;
             
         }
         
         NSLog(@"self. startPoint = %@",self.startPoint);
         
     }];
    [geocoder release];
    [cc release];


}


- (void)locationManager:(CLLocationManager *)manager


       didFailWithError:(NSError *)error

{
    
    
    NSString *errorType = (error.code == kCLErrorDenied) ?
    
    @"拒绝访问" : @"位置错误";
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"获得位置错误"
                          
                          message:errorType
                          
                          delegate:nil
                          
                          cancelButtonTitle:@"确定"
                          
                          otherButtonTitles:nil];
    
    [alert show];
    
    [alert release];
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"ok");
    if (buttonIndex==1) {
        [self userGoogleMap];
    }
}

#pragma mark MKMapViewDelegate 的代理方法


//自动弹出annotation
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"自动弹出annotation");
    for (MKAnnotationView* nnotationView in views) {
        
        [mapV selectAnnotation:nnotationView.annotation animated:YES];
    }
}

//修改大头针颜色，以及在标注上添加按钮等
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{    
    NSLog(@"//修改大头针颜色，以及在标注上添加按钮等");
    MKPinAnnotationView *pinAnnotation=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    
      //红色代表目的地，绿色代表起点，紫色代表用户自选位置
    pinAnnotation.pinColor=MKPinAnnotationColorRed;
    
    pinAnnotation.canShowCallout=YES;
    pinAnnotation.animatesDrop=YES;
    return [pinAnnotation autorelease];
}



@end
