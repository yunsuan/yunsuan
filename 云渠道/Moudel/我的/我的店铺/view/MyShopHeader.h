//
//  MyShopHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyShopHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *attentionL;

@property (nonatomic, strong) UILabel *seeL;

@property (nonatomic, strong) UILabel *scoreL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *addressBtn;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@end

NS_ASSUME_NONNULL_END
