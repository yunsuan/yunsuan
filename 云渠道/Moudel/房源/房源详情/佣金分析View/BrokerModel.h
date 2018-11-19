//
//  BrokerModel.h
//  云渠道
//
//  Created by xiaoq on 2018/4/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrokerModel : NSObject
@property (nonatomic , strong) NSMutableArray *dataarr;//基本规则
@property (nonatomic , strong) NSMutableArray *bsicarr;//全名看到的基本规则
@property (nonatomic , strong) NSMutableArray *breakerinfo;//全名看到的佣金规则
@property (nonatomic , strong) NSMutableArray *companyarr;//公司看到的基本规则


-(instancetype)initWithdata:(NSArray *)data;

@end
