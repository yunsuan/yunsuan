//
//  RecommendBigImageCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/3/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendBigImageCell : UITableViewCell

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *sourceL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic , strong) UILabel *autherL;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
