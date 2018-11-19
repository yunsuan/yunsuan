//
//  HouseTypeTableHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HouseTypeTableHeader;

typedef void(^HouseTypeImgBtnBlock)(NSInteger num,NSArray *imgArr);

@interface HouseTypeTableHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) HouseTypeImgBtnBlock houseTypeImgBtnBlock;

@property (nonatomic, strong) UIImageView *bigImg;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UICollectionView *imgColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *imgArr;

@end
