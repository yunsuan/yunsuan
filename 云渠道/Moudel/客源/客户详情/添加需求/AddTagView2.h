//
//  AddTagView2.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddTagView2Block)(void);

@interface AddTagView2 : UIView

@property (nonatomic, copy) AddTagView2Block addTagView2Block;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UICollectionView *tagColl;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

NS_ASSUME_NONNULL_END
