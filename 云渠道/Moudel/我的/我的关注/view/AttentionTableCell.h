//
//  AttentionTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagView.h"
#import "MyAttentionModel.h"

@interface AttentionTableCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *attributeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) TagView *tagView;

@property (nonatomic, strong) MyAttentionModel *model;

-(void)settagviewWithdata:(NSArray *)data;

@end
