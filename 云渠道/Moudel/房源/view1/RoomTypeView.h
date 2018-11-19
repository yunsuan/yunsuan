//
//  RoomTypeView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/10/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RoomTypeViewDoneBlock)(NSArray *arr);

@interface RoomTypeView : UIView

@property (nonatomic, copy) RoomTypeViewDoneBlock roomTypeViewDoneBlock;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *doneBtn;

@property (nonatomic, strong) NSMutableArray *dataArr;

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)data;

//@property (nonatomic, strong) NSMutableArray *selectArr;

@end

NS_ASSUME_NONNULL_END
