//
//  RoomAgencyAddProtocolCell2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTF.h"
#import "DropDownBtn.h"

typedef void(^RoomAgencyAddProtocolCell2SexBlock)(void);

typedef void(^RoomAgencyAddProtocolCell2TimeBlock)(void);
typedef void(^RoomAgencyCell2Block)(void);

@interface RoomAgencyAddProtocolCell2 : UITableViewCell

@property (nonatomic, copy) RoomAgencyAddProtocolCell2SexBlock roomAgencyAddProtocolCell2SexBlock;

@property (nonatomic, copy) RoomAgencyAddProtocolCell2TimeBlock roomAgencyAddProtocolCell2TimeBlock;

@property (nonatomic, copy) RoomAgencyCell2Block roomAgencyCell2Block;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) BorderTF *nameTF;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, strong) DropDownBtn *genderTF;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) BorderTF *phoneTF;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) BorderTF *conpanyTF;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) BorderTF *storeTF;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) BorderTF *addressTF;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) DropDownBtn *timeBtn;

@property (nonatomic, strong) NSMutableDictionary *datadic;

-(void)setDataByDic:(NSDictionary *)dic;

@end
