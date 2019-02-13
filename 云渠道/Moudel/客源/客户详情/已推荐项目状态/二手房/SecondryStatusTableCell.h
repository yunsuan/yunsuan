//
//  SecondryStatusTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/2/13.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondryStatusTableCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *content1;

@property (nonatomic, strong) UILabel *content2;

@property (nonatomic, strong) UILabel *content3;

@property (nonatomic, strong) UILabel *content4;

@property (nonatomic, strong) UIImageView *img1;

@property (nonatomic, strong) UIImageView *img2;

@property (nonatomic, strong) UIImageView *img3;

@property (nonatomic, strong) UIImageView *img4;

@property (nonatomic, strong) UIView *line1;

@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) UIView *line3;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
