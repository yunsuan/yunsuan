//
//  StoreAuthCollCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/12/11.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreAuthCollCell : UITableViewCell

@property (nonatomic, strong) UILabel *roleTL;

@property (nonatomic, strong) UICollectionView *roleColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSArray *dataArr;


@end

NS_ASSUME_NONNULL_END
