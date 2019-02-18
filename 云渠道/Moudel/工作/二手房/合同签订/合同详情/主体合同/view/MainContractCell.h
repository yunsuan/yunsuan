//
//  MainContractCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MainContractCellBlock)(NSInteger index);

@interface MainContractCell : UICollectionViewCell

@property (nonatomic, copy) MainContractCellBlock mainContractCellBlock;

@property (nonatomic, strong) UIImageView *bigImg;

@property (nonatomic, strong) UIButton *deleteBtn;

@end

NS_ASSUME_NONNULL_END
