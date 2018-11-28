//
//  RoomAgencyAddProtocolCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTF.h"
#import "DropDownBtn.h"

typedef void(^RoomAgencyAddProtocolCellBlock)(NSInteger index);

typedef void(^RoomAgencyAddProtocolCellSexBlock)(NSInteger index);

typedef void(^RoomAgencyAddProtocolCellCardBlock)(NSInteger index);

typedef void(^RoomAgencyBlock)(NSInteger index,NSDictionary *datadic);

@interface RoomAgencyAddProtocolCell : UITableViewCell

@property (nonatomic, copy) RoomAgencyBlock RoomAgencyBlock;

@property (nonatomic, copy) RoomAgencyAddProtocolCellBlock roomAgencyAddProtocolCellBlock;

@property (nonatomic, copy) RoomAgencyAddProtocolCellSexBlock roomAgencyAddProtocolCellSexBlock;

@property (nonatomic, copy) RoomAgencyAddProtocolCellCardBlock roomAgencyAddProtocolCellCardBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, copy) BorderTF *nameTF;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, copy) DropDownBtn *genderBtn;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, copy) BorderTF *phoneTF;

@property (nonatomic, strong) UILabel *phoneL2;

@property (nonatomic, copy) BorderTF *phoneTF2;

@property (nonatomic, strong) UILabel *certTypeL;

@property (nonatomic, copy) DropDownBtn *certTypeBtn;

@property (nonatomic, strong) UILabel *certNumL;

@property (nonatomic, copy) BorderTF *certNumTF;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, copy) BorderTF *addressTF;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableDictionary *dic;

@property (nonatomic , strong) NSMutableDictionary *data;

//@property(nonatomic ,strong) id model;


@end
