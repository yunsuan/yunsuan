//
//  SurveySuccessDetailHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseHeader.h"

@protocol SurveySuccessDetailHeaderDelegate;

@protocol SurveySuccessDetailHeaderDelegate <NSObject>

- (void)surveySuccessDetailHeaderCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SurveySuccessDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) BaseHeader *baseHeader;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UILabel *mortgageL;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) UILabel *seeWayL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) UILabel *reasonL;

@property (nonatomic, strong) UICollectionView *headerColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, weak) id<SurveySuccessDetailHeaderDelegate> delegate;

@end
