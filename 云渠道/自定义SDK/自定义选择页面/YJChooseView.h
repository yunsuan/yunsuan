//
//  YJChooseView.h
//  云渠道
//
//  Created by xiaoq on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YJChooseView : UIView

@property (nonatomic , assign) NSInteger type;
@property (nonatomic , strong) UILabel *titlelab;
@property (nonatomic , strong) UICollectionView *mycollectionView;




-(instancetype)initWithFrame:(CGRect)frame
                   NumOfitem:(NSInteger)itemnum
                       Title:(NSString *)name
                   DataSouce:(NSArray *)datasouce;

-(NSString *)GetDidID;



@end
