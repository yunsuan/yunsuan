//
//  ChooseCustomerCell.h
//  云渠道
//
//  Created by xiaoq on 2019/1/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseCustomerCell : UITableViewCell
@property (nonatomic, strong) UIImageView *genderImg;
@property (nonatomic , strong) UILabel *titlelab;
@property (nonatomic , strong) UILabel *numlab;
@property (nonatomic , strong) UILabel *namelab;
@property (nonatomic , strong) UILabel *phonelab;

@property (nonatomic, strong) UIView *line;
- (void)setDataDic:(NSMutableDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
