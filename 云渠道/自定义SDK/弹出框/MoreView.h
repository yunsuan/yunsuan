//
//  MoreView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MoreView;

typedef void(^MoreBtnBlock)(NSString *tag,NSString *houseType,NSString *status);

typedef void(^MoreViewClearBlock)(void);


@interface MoreView : UIView

@property (nonatomic, assign) NSInteger numOfSec;

@property (nonatomic, copy) MoreBtnBlock moreBtnBlock;

@property (nonatomic, copy) MoreViewClearBlock moreViewClearBlock;

@property (nonatomic, strong) UICollectionView *moreColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowlayout;

@property (nonatomic, strong) UIButton *clearBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) NSMutableArray *tagSelectArr;

@property (nonatomic, strong) NSMutableArray *houseSelectArr;

@property (nonatomic, strong) NSMutableArray *statusSelectArr;

@end
