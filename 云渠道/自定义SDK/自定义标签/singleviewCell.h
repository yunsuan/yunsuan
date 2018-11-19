//
//  singleviewCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface singleviewCell : UICollectionViewCell
@property(nonatomic, strong) UILabel *displayLabel;
-(void)setstylebytype:(NSString *)type andsetlab:(NSString *)str;
@end
