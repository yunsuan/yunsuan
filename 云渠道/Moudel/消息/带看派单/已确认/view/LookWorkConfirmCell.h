//
//  LookWorkConfirmCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LookWorkConfirmBlock)(NSInteger index);

@interface LookWorkConfirmCell : UITableViewCell

@property (nonatomic, strong) LookWorkConfirmBlock lookWorkConfirmBlock;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *sourceL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *proTypeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *confirmTimeL;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
