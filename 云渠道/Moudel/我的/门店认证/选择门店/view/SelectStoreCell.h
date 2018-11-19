//
//  SelectStoreCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/10/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectStoreCell : UITableViewCell

@property (nonatomic, strong) UIImageView *selectImg;

@property (nonatomic, strong) UIImageView *storeImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
