//
//  LocationManager.h
//  云渠道
//
//  Created by xiaoq on 2018/11/29.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject

+(LocationManager *)Manager;
+(NSString *)GetCityName;
+(NSString *)GetCityCode;
-(void)startLocationSuccess:(void(^)(NSString *cityname,NSString *citycode)) success
                      Faild:(void(^)(void)) faild;
-(void)stopLocation;
@end
