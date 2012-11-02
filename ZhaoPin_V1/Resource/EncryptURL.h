//
//  EncryptURL.h
//  ZhiLianZhaoPin
//
//  Created by Ibokan on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface EncryptURL : NSObject
- (NSString *) getMD5String:(NSString *)url;
- (NSString *) md5:(NSString *)str;
@end
