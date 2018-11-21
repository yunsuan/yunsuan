//
//  RoomBrokerageTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomBrokerageTableCell : UITableViewCell

@property (nonatomic, strong) UILabel *ruleL;

@property (nonatomic, strong) UILabel *standL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *rankL;

@property (nonatomic, strong) UIImageView *statusImg;

@property (nonatomic, strong) UIImageView *speedImg1;

@property (nonatomic, strong) UIImageView *speedImg2;

@property (nonatomic, strong) UIImageView *speedImg3;

@property (nonatomic, strong) UIImageView *speedImg4;

@property (nonatomic, strong) UIImageView *speedImg5;

@property (nonatomic, strong) UIView *ruleView;

@property (nonatomic, strong) UIImageView *ruleImg;

@property (nonatomic, strong) UIView *standView;

@property (nonatomic, strong) UIImageView *standImg;



- (void)SetLevel:(NSInteger )level;

@end
