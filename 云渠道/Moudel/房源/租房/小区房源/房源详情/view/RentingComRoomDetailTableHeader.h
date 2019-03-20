//
//  RentingComRoomDetailTableHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/11/29.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecAllRoomDetailHeaderModel.h"

//#import "TagView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentingAllDetailHeaderImgBtnBlock)(NSInteger num,NSArray *imgArr);

typedef void(^RentingComHeaderTagBlock)(NSInteger btnNum);

@interface RentingComRoomDetailTableHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) RentingComHeaderTagBlock rentingComHeaderTagBlock;

@property (nonatomic, copy) RentingAllDetailHeaderImgBtnBlock rentingAllDetailHeaderImgBtnBlock;

@property (nonatomic, strong) SecAllRoomDetailHeaderModel *model;

@property (nonatomic, strong) NSMutableArray *imgArr;

@property (nonatomic, strong) UIScrollView *imgScroll;

@property (nonatomic, strong) UIButton *ImgBtn;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UIButton *attentBtn;

@property (nonatomic, strong) UILabel *payL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIImageView *addressImg;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) UIView *btnView;

@end

NS_ASSUME_NONNULL_END
