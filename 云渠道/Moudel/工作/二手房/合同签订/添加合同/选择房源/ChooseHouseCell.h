//
//  ChooseHouseCell.h
//  云渠道
//
//  Created by xiaoq on 2019/1/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseHouseCell : UITableViewCell

@property (nonatomic , strong) UIImageView *headimg;
@property (nonatomic , strong) UILabel *titlelab;
@property (nonatomic , strong) UILabel *numlab;
@property (nonatomic , strong) UILabel *namelab;
@property (nonatomic , strong) UILabel *phonelab;

-(void)setdatabydata:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
