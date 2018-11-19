//
//  StoreViewCollCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewCollCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *grayImg;

@property (nonatomic, strong) UIImageView *typeImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

- (UIImage*)grayImage:(UIImage*)sourceImage;

- (UIImage*)grayscaleImageForImage:(UIImage*)image;

@end
