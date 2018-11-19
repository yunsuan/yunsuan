//
//  RoomReportWaitCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/12.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomReportWaitCell;

typedef void(^RoomReportWaitPhoneBlock)(NSInteger index);

@interface RoomReportWaitCell : UITableViewCell

@property (nonatomic, copy) RoomReportWaitPhoneBlock roomReportWaitPhoneBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *lineView;

@end
