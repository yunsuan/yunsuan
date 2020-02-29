//
//  MyShopHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTF.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyShopHeaderAddBlock)(void);

typedef void(^MyShopHeaderDeleteBlock)(NSInteger idx);

typedef void(^MyShopHeaderAddressEditBlock)(NSInteger idx);

typedef void(^MyShopHeaderAddressBtnBlock)(void);

@interface MyShopHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) MyShopHeaderDeleteBlock myShopHeaderDeleteBlock;

@property (nonatomic, strong) MyShopHeaderAddBlock myShopHeaderAddBlock;

@property (nonatomic, strong) MyShopHeaderAddressEditBlock myShopHeaderAddressEditBlock;

@property (nonatomic, strong) MyShopHeaderAddressBtnBlock myShopHeaderAddressBtnBlock;

@property (nonatomic, strong) UILabel *attentionL;

@property (nonatomic, strong) UILabel *seeL;

@property (nonatomic, strong) UILabel *scoreL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UIButton *addBtn;

//@property (nonatomic, strong) BorderTF *contentTF;

@property (nonatomic, strong) UIButton *addressBtn;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) GZQFlowLayout *addressLayout;

@property (nonatomic, strong) UICollectionView *addressColl;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSArray *tagArr;

@property (nonatomic, strong) NSArray *addressArr;

@end

NS_ASSUME_NONNULL_END
