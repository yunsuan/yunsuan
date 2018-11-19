//
//  RoomReportFailCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomReportFailCell;

typedef void(^RoomReportFailPhoneBlock)(NSInteger index);

@interface RoomReportFailCell : UITableViewCell

@property (nonatomic, copy) RoomReportFailPhoneBlock roomReportFailPhoneBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *reasonL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *lineView;
@end
