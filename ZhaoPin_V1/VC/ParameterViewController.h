//
//  ParameterViewController.h
//
//  Created by 吴育星 on 12-10-9.


#import <UIKit/UIKit.h>

@protocol GetData <NSObject>

- (void)getData:(NSString *)parameter selectRow:(NSInteger)row;

@end

@interface ParameterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,GetData>

@property(assign,nonatomic)int selectRow;  //选中第几个row
@property(retain,nonatomic)NSMutableArray *sourceDataArr;   //存放职位名称 行业 工作地点 发布时间等
@property(retain,nonatomic)NSMutableDictionary *sourceDataDic;  //存放职位名称  工作地点  都能更详细
@property(assign,nonatomic)id<GetData>delegate;
@property(nonatomic,retain)NSString *detailTitle;  //当选择行业和工作地点第二层次时设置navigationitem的title
@property (retain, nonatomic) IBOutlet UITableView *parameterTableView;

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@end
