//
//  MyShopBtnHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyShopBtnHeaderMoreBlock)(void);

typedef void(^MyShopBtnHeaderAddBlock)(void);

@interface MyShopBtnHeader : BaseHeader

@property (nonatomic, copy) MyShopBtnHeaderMoreBlock myShopBtnHeaderMoreBlock;

@property (nonatomic, copy) MyShopBtnHeaderAddBlock myShopBtnHeaderAddBlock;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIButton *addBtn;

@end

NS_ASSUME_NONNULL_END
