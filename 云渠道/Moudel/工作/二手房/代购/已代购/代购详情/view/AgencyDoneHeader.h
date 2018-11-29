//
//  AgencyDoneHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AgencyDoneHeader;

typedef void(^AgencyDoneHeaderBlock)(NSInteger index);

typedef void(^AgencyEditHeaderBlock)(void);

@interface AgencyDoneHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) AgencyDoneHeaderBlock agencyDoneHeaderBlock;

@property (nonatomic, strong) AgencyEditHeaderBlock agencyEditHeaderBlock;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UILabel *roomCodeL;

@property (nonatomic, strong) UILabel *recommendL;

@property (nonatomic, strong) UILabel *tradeCodeL;

@property (nonatomic, strong) UILabel *validL;

@property (nonatomic, strong) UILabel *auditL;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UIView *tradeView;

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *SincertyGoldL;

@property (nonatomic, strong) UILabel *breachL;

@property (nonatomic, strong) UILabel *commissionL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *comment;

@property (nonatomic, strong) UILabel *reviewL;


@property (nonatomic, strong) UILabel *reviewTimeL;



@property (nonatomic, strong) UIButton *infoBtn;

@property (nonatomic, strong) UIButton *agentBtn;

@property (nonatomic, strong) UIButton *roomBtn;

@end
