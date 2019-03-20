//
//  RentingAllRoomDetailTableHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/17.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "TagView.h"

#import "RentingAllRoomProjectModel.h"
#import "RentingAllRoomStoreModel.h"
#import "RentingAllRoomOfficeModel.h"


typedef void(^RentingAllRoomDetailTableHeaderImgBlock)(NSInteger num,NSArray *imgArr);

@interface RentingAllRoomDetailTableHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) RentingAllRoomDetailTableHeaderImgBlock rentingAllRoomDetailTableHeaderImgBlock;

@property (nonatomic, strong) RentingAllRoomProjectModel *model;

@property (nonatomic, strong) RentingAllRoomStoreModel *storeModel;

@property (nonatomic, strong) RentingAllRoomOfficeModel *officeModel;

@property (nonatomic, strong) UIScrollView *imgScroll;

@property (nonatomic, strong) UIView *alphaView;

@property (nonatomic, strong) UICollectionView *imgColl;

@property (nonatomic, strong) NSMutableArray *imgArr;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *attentL;

//@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *priceTL;

@property (nonatomic, strong) UIImageView *statusImg;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *typeTL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *areaTL;

@property (nonatomic, strong) UIView *moreView;

@property (nonatomic, assign) NSInteger type;

@end
