//
//  Job.m
//  JobViewController
//
//  Created by 吴育星 on 12-10-10.


#import "Job.h"

@implementation Job
@synthesize name,number,companyName,companyNumber,city,date;

- (void)dealloc {
    
    self.name = nil;
    self.number = nil;
    self.companyName = nil;
    self.companyNumber = nil;
    self.city = nil;
    self.date = nil;
    [super dealloc];
}

+(id)jobWitnName:(NSString *)name Number:(NSString *)number companyName:(NSString *)companyName companyNumber:(NSString *)companyNumber city:(NSString *)city date:(NSString *)date
{
    Job *job = [[Job alloc]init];
    
    if (job != nil) {
        
        job.name = name;
        job.number = number;
        job.companyName = companyName;
        job.companyNumber = companyNumber;
        job.city = city;
        job.date = date;
    }
    
    return [job autorelease];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",number,name,companyNumber,companyName,city,date];
}
@end
