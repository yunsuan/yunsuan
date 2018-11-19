//
//  TagView2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagView2 : UIView

@property (nonatomic , strong) UICollectionView *collectionview;
@property (nonatomic , strong) UICollectionViewFlowLayout *layout;
@property (nonatomic , strong) NSMutableArray *data;
@property (nonatomic , strong) NSString *type;

- (instancetype)initWithFrame:(CGRect)frame
                   DataSouce:(NSArray *)datasouce
                        type:(NSString *)type
                  flowLayout:(UICollectionViewFlowLayout *)layout;//type   1物业类型   2标签

@end
