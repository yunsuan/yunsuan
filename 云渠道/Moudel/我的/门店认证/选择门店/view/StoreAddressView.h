//
//  StoreAddressView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/11/16.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class StoreAddressView;

NS_ASSUME_NONNULL_BEGIN

typedef void(^StoreAddressViewBlock)(NSString *code,NSString *name,NSArray *nextArr);//block 选中的省市地区，id  blook出来

@interface StoreAddressView : UIView

@property (nonatomic , strong) NSString *key;

@property(nonatomic, copy) StoreAddressViewBlock storeAddressViewBlock;

- (instancetype)initWithFrame:(CGRect)frame withdata:(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
