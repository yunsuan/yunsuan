//
//  RecommendCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RecommendVC;

typedef void(^confirmBtnBlock)(NSInteger index);

@interface RecommendCell : UITableViewCell


@property (nonatomic, copy) confirmBtnBlock confirmBtnBlock;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *confirmL;

@property (nonatomic, strong) UIImageView *statusImg;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;



@end
