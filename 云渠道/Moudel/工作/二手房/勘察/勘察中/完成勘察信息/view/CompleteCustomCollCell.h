//
//  CompleteCustomCollCell.h
//  云渠道
//
//  Created by 谷治墙 on 2020/1/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTF.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CompleteCustomCollCellBlock)(NSString *str);

@interface CompleteCustomCollCell : UICollectionViewCell

@property (nonatomic, copy) CompleteCustomCollCellBlock completeCustomCollCellBlock;

@property (nonatomic, strong) BorderTF *contentTF;
@property (nonatomic, strong) UIButton *comfirmBtn;

@end

NS_ASSUME_NONNULL_END
