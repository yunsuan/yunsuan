//
//  StoreAuthCollCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreAuthCollCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *selectArr;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

NS_ASSUME_NONNULL_END
