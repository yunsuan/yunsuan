//
//  TagView.h
//  云渠道
//
//  Created by xiaoq on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagView : UIView

@property ( nonatomic , strong ) UICollectionView *collectionview;
@property (nonatomic , strong) UICollectionViewFlowLayout *layout;

-(instancetype)initWithFrame:(CGRect)frame
                        type:(NSString *)type;//type   1物业类型   2标签

-(void)setData:(NSArray *)datasouse;

@end
