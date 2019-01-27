//
//  StoreDetailCell.h
//  云渠道
//
//  Created by xiaoq on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreDetailCell : UITableViewCell
@property (nonatomic , strong) UILabel *numlab;
@property (nonatomic , strong) UILabel *namelab;
@property (nonatomic , strong) UILabel *adresslab;
@property (nonatomic , strong) UILabel *peoplelab;
@property (nonatomic , strong) UILabel *phonelab;
@property (nonatomic , strong) UIButton *phonebtn;
@property (nonatomic , strong) UIButton *mapbtn;

-(void)setDataBydata:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
