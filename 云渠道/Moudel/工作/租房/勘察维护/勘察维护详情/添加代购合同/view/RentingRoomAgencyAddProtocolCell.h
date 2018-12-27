//
//  RentingRoomAgencyAddProtocolCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/27.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTF.h"
#import "DropDownBtn.h"

typedef void(^RentingRoomAgencyAddProtocolCellBlock)(NSInteger index);

typedef void(^RentingRoomAgencyAddProtocolCellSexBlock)(NSInteger index);

typedef void(^RentingRoomAgencyAddProtocolCellCardBlock)(NSInteger index);

typedef void(^RentingRoomAgencyBlock)(NSInteger index,NSDictionary *datadic);

NS_ASSUME_NONNULL_BEGIN

@interface RentingRoomAgencyAddProtocolCell : UITableViewCell

@property (nonatomic, copy) RentingRoomAgencyBlock rentingRoomAgencyBlock;

@property (nonatomic, copy) RentingRoomAgencyAddProtocolCellBlock rentingRoomAgencyAddProtocolCellBlock;

@property (nonatomic, copy) RentingRoomAgencyAddProtocolCellSexBlock rentingRoomAgencyAddProtocolCellSexBlock;

@property (nonatomic, copy) RentingRoomAgencyAddProtocolCellCardBlock rentingRoomAgencyAddProtocolCellCardBlock;

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

@end

NS_ASSUME_NONNULL_END
