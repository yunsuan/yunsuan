//
//  RoomChildVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "RoomListModel.h"
#import "SecdaryAllTableModel.h"
#import "SecdaryComModel.h"
#import "RentingAllTableModel.h"
#import "RentingComModel.h"
#import "RecommendInfoModel.h"

#import "AttentionHouseModel.h"
#import "AttetionComModel.h"
#import "AttetionRentingComModel.h"
#import "AtteionRentingHouseModel.h"

typedef void(^RoomChildVCSecModelBlock)(SecdaryAllTableModel *model);

typedef void(^RoomChildVCSecComModelBlock)(SecdaryComModel *model);

typedef void(^RoomChildVCRentModelBlock)(RentingAllTableModel *model);

typedef void(^RoomChildVCRentComModelBlock)(RentingComModel *model);

typedef void(^RoomChildVCRoomModelBlock)(RoomListModel *model);

typedef void(^RoomChildVCAttentionSecModelBlock)(AttentionHouseModel *model);

typedef void(^RoomChildVCAttentionSecComModelBlock)(AttetionComModel *model);

typedef void(^RoomChildVCAttentionRentModelBlock)(AtteionRentingHouseModel *model);

typedef void(^RoomChildVCAttentionRentComModelBlock)(AttetionRentingComModel *model);

//typedef void(^RoomChildVCRecommendBlock)(NSDictionary *dataDic);
typedef void(^RoomChildVCRecommendBlock)(RecommendInfoModel *model);

//typedef void(^RoomChildVCBlock)(RentingComModel *model);

//typedef void(^RoomChildVC)(<#arguments#>);
@interface RoomChildVC : BaseViewController

@property (nonatomic, copy) RoomChildVCAttentionSecModelBlock roomChildVCAttentionSecModelBlock;

@property (nonatomic, copy) RoomChildVCAttentionSecComModelBlock roomChildVCAttentionSecComModelBlock;

@property (nonatomic, copy) RoomChildVCAttentionRentModelBlock roomChildVCAttentionRentModelBlock;

@property (nonatomic, copy) RoomChildVCAttentionRentComModelBlock roomChildVCAttentionRentComModelBlock;

@property (nonatomic, copy) RoomChildVCRecommendBlock roomChildVCRecommendBlock;

@property (nonatomic, copy) RoomChildVCRentModelBlock roomChildVCRentModelBlock;

@property (nonatomic, copy) RoomChildVCRentComModelBlock roomChildVCRentComModelBlock;

@property (nonatomic, copy) RoomChildVCRoomModelBlock roomChildVCRoomModelBlock;

@property (nonatomic, copy) RoomChildVCSecModelBlock roomChildVCSecModelBlock;

@property (nonatomic, copy) RoomChildVCSecComModelBlock roomChildVCSecComModelBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *typeId;

@property (nonatomic, strong) NSString *param;

@property (nonatomic, assign) BOOL isFirstLoading;

- (instancetype)initWithType:(NSInteger )type;

- (void)RequestMethod;

@end
