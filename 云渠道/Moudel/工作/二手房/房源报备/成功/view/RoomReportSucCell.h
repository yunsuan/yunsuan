//
//  RoomReportSucCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomReportSucCell;

typedef void(^RoomReportSucPhoneBlock)(NSInteger index);

@interface RoomReportSucCell : UITableViewCell

@property (nonatomic, copy) RoomReportSucPhoneBlock roomReportSucPhoneBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *sexImg;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *lineView;

@end
