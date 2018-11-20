//
//  RecommendCell3.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecommendCell3;

typedef void(^phoneBtnBlock)(NSInteger index);

@interface RecommendCell3 : UITableViewCell

@property (nonatomic, copy) phoneBtnBlock phoneBtnBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *confirmL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableDictionary *inValidDic;

@end
