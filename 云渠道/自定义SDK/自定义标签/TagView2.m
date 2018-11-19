//
//  TagView2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "TagView2.h"
#import "TagViewCollCell.h"
//#import "singleviewCell.h"

@interface TagView2 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation TagView2

- (instancetype)initWithFrame:(CGRect)frame
                   DataSouce:(NSArray *)datasouce
                        type:(NSString *)type
                  flowLayout:(UICollectionViewFlowLayout *)layout
{
    self = [super initWithFrame:frame];
    if (self) {
        _data = [NSMutableArray arrayWithArray:datasouce];
        _type = type;
        _layout = layout;
        self.clipsToBounds = YES;
        [self addSubview:self.collectionview];
    }
    return self;
}


-(UICollectionView *)collectionview
{
    if (!_collectionview) {
    
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:self.layout];
        _collectionview.dataSource = self;
        _collectionview.delegate = self;
        _collectionview.backgroundColor = [UIColor clearColor];
        _collectionview.bounces = NO;
        _collectionview.showsVerticalScrollIndicator = NO;
        _collectionview.showsHorizontalScrollIndicator = NO;
        [_collectionview registerClass:[TagViewCollCell class] forCellWithReuseIdentifier:@"TagViewCollCell"];
    }
    return _collectionview;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = _data[indexPath.row];
    return CGSizeMake(13 *SIZE * str.length + 20 *SIZE * 2, 30 *SIZE);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagViewCollCell" forIndexPath:indexPath];
    [cell setstylebytype:_type andsetlab:_data[indexPath.row]];
    return cell;
}


- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        //设置item的大小
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 11*SIZE;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //        _layout.sectionHeadersPinToVisibleBounds = YES;
    }
    return _layout;
}
@end
