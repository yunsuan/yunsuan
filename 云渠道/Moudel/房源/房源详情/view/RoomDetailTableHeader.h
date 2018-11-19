//
//  RoomDetailTableHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomDetailModel.h"
#import "TagView.h"

@class RoomDetailTableHeader;

typedef void(^AttentBtnBlock)(void);

typedef void(^ImgBtnBlock)(NSInteger num,NSArray *imgArr);

typedef void(^RoomDetailHeaderMoreBlock)(void);

@interface RoomDetailTableHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) AttentBtnBlock attentBtnBlock;

@property (nonatomic, copy) ImgBtnBlock imgBtnBlock;

@property (nonatomic, strong) UIScrollView *imgScroll;

@property (nonatomic, strong) UIButton *ImgBtn;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *developerL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic , strong) TagView *tagview;

@property (nonatomic , strong) TagView *wuyeview;

@property (nonatomic, strong) RoomDetailModel *model;

@property (nonatomic, strong) NSMutableArray *imgArr;

@property (nonatomic, strong) UIButton *moreBtn;


@end
