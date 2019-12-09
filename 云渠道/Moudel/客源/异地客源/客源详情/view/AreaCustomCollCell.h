//
//  AreaCustomCollCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/12/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AreaCustomCollCell : UITableViewCell

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *imgColl;

@property (nonatomic, strong) NSArray *dataArr;

@end

NS_ASSUME_NONNULL_END
