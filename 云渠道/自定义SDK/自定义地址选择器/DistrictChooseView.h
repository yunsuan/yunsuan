//
//  DistrictChooseView.h
//  云渠道
//
//  Created by 谷治墙 on 2020/3/8.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DistrictChooseViewConfirmBlock)(NSString * area,NSString *areaid);

@interface DistrictChooseView : UIView

@property(nonatomic, copy) DistrictChooseViewConfirmBlock districtChooseViewConfirmBlock;

- (instancetype)initWithFrame:(CGRect)frame cityId:(NSString *)city_id cityName:(NSString *)city_name;

@end

NS_ASSUME_NONNULL_END
