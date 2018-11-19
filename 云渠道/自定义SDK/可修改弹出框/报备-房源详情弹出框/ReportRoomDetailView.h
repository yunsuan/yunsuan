//
//  ReportRoomDetailView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReportRoomDetailView;

typedef void(^ReportRoomDetailBlock)(void);

@interface ReportRoomDetailView : UIView

@property (nonatomic, copy) ReportRoomDetailBlock reportRoomDetailBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UIView *blueView2;

@property (nonatomic, strong) UILabel *room;

@property (nonatomic, strong) UILabel *roomNumL;

@property (nonatomic, strong) UILabel *buildL;

@property (nonatomic, strong) UILabel *unitL;

@property (nonatomic, strong) UILabel *floorL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *areaL2;

@property (nonatomic, strong) UILabel *infoL;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *cancenBtn;

@property (nonatomic, strong) UIButton *confirmBtn;



@end
