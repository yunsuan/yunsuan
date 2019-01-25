//
//  StoreListCell.h
//  云渠道
//
//  Created by xiaoq on 2019/1/24.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreListCell : UITableViewCell

@property (nonatomic , strong) UIImageView *headimg;
@property (nonatomic , strong) UILabel *titlelab;
@property (nonatomic , strong) UILabel *numlab;
@property (nonatomic , strong) UILabel *adresslab;
@property (nonatomic , strong) UILabel *housenumlab;
@property (nonatomic , strong) UILabel *namelab;
@property (nonatomic , strong) UIButton *recomentBtn;


-(void)setDataBydata:(NSDictionary *)data type:(NSString *)type;


@end

NS_ASSUME_NONNULL_END
