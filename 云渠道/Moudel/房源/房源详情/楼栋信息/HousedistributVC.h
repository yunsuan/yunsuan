//
//  HousedistributVC.h
//  云渠道
//
//  Created by xiaoq on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"
#import "KyoRowIndexView.h"
#import "KyoCenterLineView.h"

#import "SMCinameSeatScrollViewDelegate.h"

//@protocol SMCinameSeatScrollViewDelegate;
@interface HousedistributVC : BaseViewController
@property (weak, nonatomic) id<SMCinameSeatScrollViewDelegate> SMCinameSeatScrollViewDelegate;

@property (nonatomic , strong)NSMutableArray *myarr;
@property (nonatomic , strong)NSMutableArray *LDinfo;
@property (nonatomic , strong)NSString *project_id;
@property (nonatomic , strong)NSString *build_id;
@property (nonatomic , strong)NSString *unit_id;
@property (nonatomic , strong)NSDictionary *LDdic;
@property (nonatomic , strong)NSString *titleinfo;

@property (nonatomic, strong) NSString *titleStr;

//status 0 有返回按钮
@property(nonatomic,strong)NSString * statusStr;

@property (nonatomic, strong) NSString *status;

@end

//@protocol SMCinameSeatScrollViewDelegate <NSObject>
//
//@optional
//- (KyoCinameSeatState)kyoCinameSeatScrollViewSeatStateWithRow:(NSUInteger)row withColumn:(NSUInteger)column;
//- (void)kyoCinameSeatScrollViewDidTouchInSeatWithRow:(NSUInteger)row withColumn:(NSUInteger)column;
////返回选中行的数据
//-(void)ReturnSelectData:(NSDictionary *)datasource;
//
//@end
