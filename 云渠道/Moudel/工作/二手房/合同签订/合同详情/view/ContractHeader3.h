//
//  ContractHeader3.h
//  云渠道
//
//  Created by 谷治墙 on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ContractHeader3Block)(void);

@interface ContractHeader3 : UITableViewHeaderFooterView

@property (nonatomic, copy) ContractHeader3Block contractHeader3Block;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *AddBtn;

@end

NS_ASSUME_NONNULL_END
