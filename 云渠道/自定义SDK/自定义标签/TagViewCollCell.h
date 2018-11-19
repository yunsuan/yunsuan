//
//  TagViewCollCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagViewCollCell : UICollectionViewCell

@property(nonatomic, strong) UILabel *displayLabel;

-(void)setstylebytype:(NSString *)type andsetlab:(NSString *)str;

@end
