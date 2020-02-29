//
//  MyShopRoomCell.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyShopRoomCellBlock)(NSInteger index,NSInteger btn);

@interface MyShopRoomCell : UITableViewCell

@property (nonatomic, copy) MyShopRoomCellBlock myShopRoomCellBlock;

@property (nonatomic, strong) UIImageView *roomImg;

@property (nonatomic, strong) UIView *specialView;

@property (nonatomic, strong) UILabel *specialL;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *roomNumL;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *stateL;

@property (nonatomic, strong) UILabel *attentionL;

@property (nonatomic, strong) UILabel *seeL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *upBtn;

@property (nonatomic, strong) UIButton *downBtn;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
