//
//  BuildingAlbumVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@interface BuildingAlbumVC : BaseViewController

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UICollectionView *albumColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

//- (instancetype)initWithNum:(NSInteger )num imgArr:(NSArray *)imgArr;

- (instancetype)initWithNum:(NSInteger)num infoid:(NSString *)infoid;

@end
