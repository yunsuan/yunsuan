//
//  XGToolBar.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/3.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XGToolBarDelegate <NSObject>

- (void)XGBarScrollToIndex:(NSInteger)index;

@end

@interface XGToolBar : UIView

//@property (nonatomic, strong) NSArray *albumArr;

@property (nonatomic, strong) UILabel *currentL;

@property (nonatomic, strong) UILabel *allL;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *XGColl;

@property (nonatomic, weak) id<XGToolBarDelegate> delegate;

//@property (nonatomic, strong) NSString *projectId;

-(instancetype)initWithFrame:(CGRect)frame projectId:(NSString *)projectId albumArr:(NSArray *)albumArr;

- (void)setTitleLabelWithCurrentIndex:(NSUInteger)index totalCount:(NSUInteger)totalCount;
@end
