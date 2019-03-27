//
//  MoreViewHouseCollCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/3/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropDownBtn.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MoreViewHouseCollCellBlock)(void);

@interface MoreViewHouseCollCell : UICollectionViewCell

@property (nonatomic, copy) MoreViewHouseCollCellBlock moreViewHouseCollCellBlock;

@property (nonatomic, strong) DropDownBtn *houseBtn;

@end

NS_ASSUME_NONNULL_END
