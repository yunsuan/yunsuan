//
//  ActiveRoomDetailHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ActiveRoomDetailHeaderImgBtnBlock)(NSInteger num,NSArray *imgArr);

@interface ActiveRoomDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) ActiveRoomDetailHeaderImgBtnBlock activeRoomDetailHeaderImgBtnBlock;

@property (nonatomic, strong) UIImageView *bigImg;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UICollectionView *imgColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *imgArr;

@end

NS_ASSUME_NONNULL_END
