//
//  MyShopCommentCell.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TagCollCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyShopCommentCellBlock)(void);

typedef void(^MyShopCommentCellLabelBlock)(void);

@interface MyShopCommentCell : UITableViewCell

@property (nonatomic, copy) MyShopCommentCellBlock myShopCommentCellBlock;

@property (nonatomic, copy) MyShopCommentCellLabelBlock myShopCommentCellLabelBlock;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *scoreL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *contentL;

//@property (nonatomic, strong) UITextView *contentL;

@property (nonatomic, strong) GZQFlowLayout *contentLayout;

@property (nonatomic, strong) UICollectionView *contentColl;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
