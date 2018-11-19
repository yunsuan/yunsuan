//
//  CustomTableListHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/11/1.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CustomTableListHeaderMoreBlock)(void);

typedef void(^CustomTableListHeaderStatusBlock)(void);

@interface CustomTableListHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) CustomTableListHeaderMoreBlock customTableListHeaderMoreBlock;

@property (nonatomic, copy) CustomTableListHeaderStatusBlock customTableListHeaderStatusBlock;

@property (nonatomic, strong) UILabel *numListL;

@property (nonatomic, strong) UILabel *recommendListL;

@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) UIButton *moreBtn;

@end

NS_ASSUME_NONNULL_END
