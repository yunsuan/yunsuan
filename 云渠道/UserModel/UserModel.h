//
//  UserModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserModel : NSObject
@property (nonatomic, assign)  NSInteger comment;
@property (nonatomic , strong) NSString *Token;
@property (nonatomic , strong) NSString *Account;
@property (nonatomic , strong) NSString *Password;
@property (nonatomic , strong) NSString *agent_id;
@property (nonatomic , strong) NSString *agent_identity;
@property (nonatomic , strong) NSDictionary *Configdic;
@property (nonatomic, strong) NSMutableArray *storeArr;
@property (nonatomic, strong) NSMutableArray *officeArr;
@property (nonatomic, strong) NSMutableArray *houseArr;
@property (nonatomic, strong) NSMutableDictionary *tagDic;
@property (nonatomic, strong) NSMutableArray *tagAllArr;
@property (nonatomic, strong) NSMutableArray *tagSelectArr;
@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) NSMutableArray *groupArr;

+ (UserModel *)defaultModel;

@end
