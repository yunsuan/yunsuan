//
//  MyShopAddressL.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyShopAddressLBlock)(NSInteger idx);

@interface MyShopAddressL : UICollectionViewCell

@property (nonatomic, copy) MyShopAddressLBlock myShopAddressLBlock;

@property (nonatomic, strong) UILabel *addressTF;

@property (nonatomic, strong) UIButton *editBtn;

@end

NS_ASSUME_NONNULL_END
