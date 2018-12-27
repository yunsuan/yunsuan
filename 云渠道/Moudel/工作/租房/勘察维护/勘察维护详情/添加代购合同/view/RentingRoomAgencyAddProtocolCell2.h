//
//  RentingRoomAgencyAddProtocolCell2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/27.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTF.h"
#import "DropDownBtn.h"

typedef void(^RentingRoomAgencyAddProtocolCell2SexBlock)(void);

typedef void(^RentingRoomAgencyAddProtocolCell2TimeBlock)(void);
typedef void(^RentingRoomAgencyCell2Block)(void);

NS_ASSUME_NONNULL_BEGIN

@interface RentingRoomAgencyAddProtocolCell2 : UITableViewCell

@property (nonatomic, copy) RentingRoomAgencyAddProtocolCell2SexBlock rentingRoomAgencyAddProtocolCell2SexBlock;

@property (nonatomic, copy) RentingRoomAgencyAddProtocolCell2TimeBlock rentingRoomAgencyAddProtocolCell2TimeBlock;

@property (nonatomic, copy) RentingRoomAgencyCell2Block rentingRoomAgencyCell2Block;

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

NS_ASSUME_NONNULL_END
