//
//  CustomTableAddHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/10/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CustomTableAddHeaderBlock)(void);

@interface CustomTableAddHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) CustomTableAddHeaderBlock customTableAddHeaderBlock;

@property (nonatomic, strong) UIButton *addBtn;

@end

NS_ASSUME_NONNULL_END
