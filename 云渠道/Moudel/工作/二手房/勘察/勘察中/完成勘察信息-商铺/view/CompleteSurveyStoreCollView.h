//
//  CompleteSurveyStoreCollView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlueTitleMoreHeader.h"

@interface CompleteSurveyStoreCollView : UIView

@property (nonatomic, strong) BlueTitleMoreHeader *titleView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end
