//
//  RecommendSuccessCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendSuccessCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *phaseL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
