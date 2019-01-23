//
//  CustomLookWaitCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CustomLookWaitCellBlock)(NSInteger index);

@interface CustomLookWaitCell : UITableViewCell

@property (nonatomic, copy) CustomLookWaitCellBlock customLookWaitCellBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *sourceL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *endTimeL;

@property (nonatomic, strong) UIButton *comfirmBtn;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
