//
//  SecondaryMatchHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecondaryMatchHeaderMoreBlock)(void);

//typedef void(^CustomTableListHeaderStatusBlock)(void);

@interface SecondaryMatchHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) SecondaryMatchHeaderMoreBlock secondaryMatchHeaderMoreBlock;

@property (nonatomic, strong) UILabel *numListL;

@property (nonatomic, strong) UIButton *moreBtn;

@end

NS_ASSUME_NONNULL_END
