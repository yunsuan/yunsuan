//
//  AddTagViewCollCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddTagViewCollCell;

typedef void(^DeleteBtnBlock)(NSInteger index);

@interface AddTagViewCollCell : UICollectionViewCell

@property (nonatomic, copy) void (^deleteBtnBlock)(NSUInteger );

@property(nonatomic, strong) UILabel *displayLabel;

@property (nonatomic, strong) UIView *colorView;

@property (nonatomic, strong) UIButton *cancelBtn;

-(void)setstylebytype:(NSString *)type andsetlab:(NSString *)str;

@end
