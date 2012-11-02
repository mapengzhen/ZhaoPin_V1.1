//
//  Job.h
//  JobViewController
//
//  Created by 吴育星 on 12-10-10.

#import <Foundation/Foundation.h>

@interface Job : NSObject 

//职位名称 职位编码 公司名称 公司编码 公司所在城市 职位发布日期 

@property(nonatomic,retain)NSString *name,*number,*companyName,*companyNumber,*city,*date;

+(id)jobWitnName:(NSString *)name Number:(NSString *)number companyName:(NSString *)companyName companyNumber:(NSString *)companyNumber city:(NSString *)city date:(NSString *)date;
@end
