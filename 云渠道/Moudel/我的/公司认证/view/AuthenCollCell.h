//
//  AuthenCollCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AuthenCollCellDeleteBlock)(void);

@interface AuthenCollCell : UICollectionViewCell

@property (nonatomic, copy) AuthenCollCellDeleteBlock authenCollCellDeleteBlock;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *cancelBtn;

@end
