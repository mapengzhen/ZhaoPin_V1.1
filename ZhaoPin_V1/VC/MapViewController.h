//
//  MapViewController.h
//  Map
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Placeanonation.h"


@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>
{
    MKMapView *mapV;
    
    CLLocationManager *locationManager;   //位置管理器
    
    MKCoordinateRegion theRegion;        //坐标区域（经纬度坐标，精度）
    
    CLLocationCoordinate2D coordinate;   //经纬度坐标
    
    UIAlertView *alertView1;
    
}
@property (assign ,nonatomic )CLLocationCoordinate2D fromecorrdinate;//接受上个界面传过来的经纬度corrdinate；
@property (retain ,nonatomic )NSString *endPoint;//地图中的终点的地址；
@property (retain ,nonatomic )NSString *startPoint;//地图中起点的地址；
@property (retain ,nonatomic )NSString *jobName;//大头针显示的职位名称；
@property (retain ,nonatomic )NSString *jobAddress;//大头针显示的职位地址；

@end
