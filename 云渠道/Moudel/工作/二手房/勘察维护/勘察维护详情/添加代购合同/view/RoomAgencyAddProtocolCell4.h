//
//  RoomAgencyAddProtocolCell4.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropDownBtn.h"
#import "BorderTF.h"

typedef void(^RoomAgencyAddProtocolCell4TimeBlock)(void);

typedef void(^RoomAgencyAddProtocolCell4PayBlock)(void);

@interface RoomAgencyAddProtocolCell4 : UITableViewCell

@property (nonatomic, copy) RoomAgencyAddProtocolCell4TimeBlock roomAgencyAddProtocolCell4TimeBlock;

@property (nonatomic, copy) RoomAgencyAddProtocolCell4PayBlock roomAgencyAddProtocolCell4PayBlock;

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

@end
