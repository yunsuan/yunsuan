//
//  ContractTradeCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContractTradeCell : UITableViewCell

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *buyBreachL;

@property (nonatomic, strong) UILabel *sellBreachL;

@property (nonatomic, strong) UILabel *buyCommissionL;

@property (nonatomic, strong) UILabel *sellCommissionL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *registerTimeL;

@property (nonatomic, strong) UILabel *logoutTimeL;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) UILabel *buyReasonL;

@property (nonatomic, strong) UILabel *sellReasonL;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
