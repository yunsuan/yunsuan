//
//  MaintainDetailHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashesLineView.h"
#import "ThreePartView.h"

@class MaintainDetailHeader;

typedef void(^MaintainTagHeaderBlock)(NSInteger index);

typedef void(^MaintainDetailHeaderBlock)(void);

typedef void(^MaintainPriceHeaderBlock)(void);

@interface MaintainDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) MaintainDetailHeaderBlock maintainDetailHeaderBlock;

@property (nonatomic, strong) MaintainPriceHeaderBlock maintainPriceHeaderBlock;

@property (nonatomic, strong) MaintainTagHeaderBlock maintainTagHeaderBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableDictionary *takeDic;

@property (nonatomic, strong) UIView *codeView;

@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *singlePriceL;

@property (nonatomic, strong) UILabel *minPriceL;

@property (nonatomic, strong) UILabel *singleMinPriceL;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UILabel *mortgageL;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) UILabel *seeWayL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) DashesLineView *dashesLine;

@property (nonatomic, strong) ThreePartView *partView;

@property (nonatomic, strong) DashesLineView *dashesLine2;

@property (nonatomic, strong) ThreePartView *seeView;

@property (nonatomic, strong) DashesLineView *dashesLine3;

@property (nonatomic, strong) ThreePartView *priceView;

@property (nonatomic, strong) DashesLineView *dashesLine4;

//@property (nonatomic, strong) UILabel *RePriceL;
//
//@property (nonatomic, strong) UILabel *RePriceLabel;
//
//@property (nonatomic, strong) UILabel *attentL;
//
//@property (nonatomic, strong) UILabel *attentLabel;
//
//@property (nonatomic, strong) UILabel *periodL;
//
//@property (nonatomic, strong) UILabel *periodLabel;
//
//@property (nonatomic, strong) UILabel *daysL;
//
//@property (nonatomic, strong) UILabel *daysLabel;
//
//@property (nonatomic, strong) UILabel *allL;
//
//@property (nonatomic, strong) UILabel *allLabel;
//
//@property (nonatomic, strong) UILabel *seePriceL;
//
//@property (nonatomic, strong) UILabel *seePriceLabel;
//
//@property (nonatomic, strong) UILabel *maxL;
//
//@property (nonatomic, strong) UILabel *maxLabel;
//
//@property (nonatomic, strong) UILabel *minL;
//
//@property (nonatomic, strong) UILabel *minLabel;
//
//@property (nonatomic, strong) UILabel *numL;
//
//@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, strong) UIButton *infoBtn;

@property (nonatomic, strong) UIButton *advantageBtn;

@property (nonatomic, strong) UIButton *followBtn;

@end
