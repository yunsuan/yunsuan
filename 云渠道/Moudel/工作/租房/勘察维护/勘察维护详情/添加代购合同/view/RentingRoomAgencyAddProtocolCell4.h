//
//  RentingRoomAgencyAddProtocolCell4.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/27.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropDownBtn.h"
#import "BorderTF.h"

typedef void(^RentingRoomAgencyAddProtocolCell4TimeBlock)(void);

typedef void(^RentingRoomAgencyAddProtocolCell4PayBlock)(void);

typedef void(^RentingRoomAgencylCell4Block)(NSMutableDictionary *data);

NS_ASSUME_NONNULL_BEGIN

@interface RentingRoomAgencyAddProtocolCell4 : UITableViewCell

@property (nonatomic, copy) RentingRoomAgencyAddProtocolCell4TimeBlock rentingRoomAgencyAddProtocolCell4TimeBlock;

@property (nonatomic, copy) RentingRoomAgencyAddProtocolCell4PayBlock rentingRoomAgencyAddProtocolCell4PayBlock;

@property (nonatomic, copy) RentingRoomAgencylCell4Block rentingRoomAgencylCell4Block;

@property (nonatomic, assign) NSInteger ratio;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTF *priceTF;

@property (nonatomic, strong) UILabel *sincerityL;

@property (nonatomic, strong) BorderTF *sincerityTF;

@property (nonatomic, strong) UILabel *breachL;

@property (nonatomic, strong) BorderTF *breachTF;

@property (nonatomic, strong) UILabel *commisionL;

@property (nonatomic, strong) BorderTF *commisionTF;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) DropDownBtn *payWayBtn;

@property (nonatomic, strong) UILabel *signTimeL;

@property (nonatomic, strong) DropDownBtn *signTimeBtn;

@property (nonatomic, strong) UILabel *eventL;

@property (nonatomic, strong) UITextView *eventTV;

@property (nonatomic, strong) NSMutableDictionary *tradeDic;

@property (nonatomic, strong) NSMutableDictionary *datadic;

@end

NS_ASSUME_NONNULL_END
