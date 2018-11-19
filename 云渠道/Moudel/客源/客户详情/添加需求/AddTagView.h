//
//  AddTagView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@class AddTagView;

typedef void(^AddBtnBlock)(void);

@interface AddTagView : UIView

@property (nonatomic, copy) AddBtnBlock addBtnBlock;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UICollectionView *tagColl;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end
