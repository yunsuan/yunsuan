//
//  BrokerDetailHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrokerDetailHeader;
typedef void (^dropBtnBlock)(void);

@interface BrokerDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, assign) BOOL drop;

@property (nonatomic , copy) dropBtnBlock dropBtnBlock;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIImageView *dropImg;

@property (nonatomic, strong) UIButton *dropBtn;

@end
