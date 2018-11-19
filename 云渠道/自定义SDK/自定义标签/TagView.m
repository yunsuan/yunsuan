//
//  TagView.m
//  云渠道
//
//  Created by xiaoq on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "TagView.h"
#import "singleviewCell.h"
@interface TagView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
//@property ( nonatomic , strong ) UICollectionView *collectionview;
//@property (nonatomic , strong) UICollectionViewFlowLayout *layout;
@property (nonatomic , strong) NSArray *data;
@property (nonatomic , strong) NSString *type;
@end

@implementation TagView

-(instancetype)initWithFrame:(CGRect)frame
                        type:(NSString *)type
{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        self.clipsToBounds = YES;
        [self addSubview:self.collectionview];
    }
    return self;
}

-(void)setData:(NSArray *)datasouse
{
    _data = datasouse;
    [self.collectionview reloadData];
}

-(UICollectionView *)collectionview
{
    if (!_collectionview) {
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 16.7*SIZE) collectionViewLayout:self.layout];
        _collectionview.dataSource = self;
        _collectionview.delegate = self;
        _collectionview.backgroundColor = [UIColor clearColor];
        _collectionview.bounces = NO;
        _collectionview.showsVerticalScrollIndicator = NO;
        _collectionview.showsHorizontalScrollIndicator = NO;
        [_collectionview registerClass:[singleviewCell class] forCellWithReuseIdentifier:@"singleviewCell"];
    }
    return _collectionview;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _data.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = _data[indexPath.row];
    return CGSizeMake(12*SIZE * str.length + 4.7*SIZE *2, 16.7*SIZE);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    singleviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"singleviewCell" forIndexPath:indexPath];
    [cell setstylebytype:_type andsetlab:_data[indexPath.row]];
    return cell;
}


- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        //设置item的大小
        _layout.minimumLineSpacing = 5 *SIZE;
        _layout.minimumInteritemSpacing = 7 *SIZE;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}



@end
