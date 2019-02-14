//
//  ContractHeader2.h
//  云渠道
//
//  Created by xiaoq on 2019/2/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ContractHeaderBlock)(NSInteger index);

@interface ContractHeader2 : UITableViewHeaderFooterView

@property (nonatomic, copy) ContractHeaderBlock contractHeaderBlock;

@property (nonatomic, strong) UIButton *buyBtn;

@property (nonatomic, strong) UIButton *sellBtn;

@property (nonatomic, strong) UIButton *infoBtn;

@end

NS_ASSUME_NONNULL_END
