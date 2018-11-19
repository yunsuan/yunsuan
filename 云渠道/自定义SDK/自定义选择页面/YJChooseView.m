//
//  YJChooseView.m
//  云渠道
//
//  Created by xiaoq on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "YJChooseView.h"
#import "YJChooseViewCell.h"

@interface YJChooseView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , assign) NSInteger row;
@property (nonatomic , assign) NSInteger column;
@property (nonatomic , assign) NSInteger numofitem;

@property (nonatomic , strong) UICollectionViewFlowLayout *layout;
@property (nonatomic , strong) NSArray *datasouce;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *idnum;
//@property (nonatomic , assign) NSInteger slectnum;







@end

@implementation YJChooseView

-(instancetype)initWithFrame:(CGRect)frame
                   NumOfitem:(NSInteger)itemnum
                       Title:(NSString *)name
                   DataSouce:(NSArray *)datasouce;
{
    self = [super initWithFrame:frame];
    if (self) {
        _row = 2;
        _column = itemnum%2==0?itemnum/2:itemnum/2+1;
        _numofitem = itemnum;
        _datasouce = datasouce;
        _name = name;
        _idnum = datasouce[0][@"id"];

        self.backgroundColor  = [UIColor whiteColor];
        [self addSubview:self.titlelab];
        [self addSubview:self.mycollectionView];
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.mycollectionView selectItemAtIndexPath:selectedIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        
    }
    return self;
    
}

-(UILabel *)titlelab
{
    if (!_titlelab) {
        _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(9*SIZE, 20*SIZE, 320*SIZE, 13*SIZE)];
        _titlelab.text = _name;
        _titlelab.textColor = YJTitleLabColor;
        _titlelab.font = [UIFont systemFontOfSize:12*SIZE];
    }
    return _titlelab;
}

-(UICollectionView *)mycollectionView
{
    if (!_mycollectionView) {
        _mycollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(80*SIZE, 20*SIZE, 280*SIZE, self.frame.size.height-20*SIZE) collectionViewLayout:self.layout];
        _mycollectionView.dataSource = self;
        _mycollectionView.delegate = self;
        _mycollectionView.backgroundColor = [UIColor clearColor];
        _mycollectionView.bounces = NO;
        //注册item
        [_mycollectionView registerClass:[YJChooseViewCell class] forCellWithReuseIdentifier:@"YJChooseViewCell"];
        
    
    }
    return _mycollectionView;
}




- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _numofitem;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        YJChooseViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YJChooseViewCell" forIndexPath:indexPath];
        cell.displayLabel.text = _datasouce[indexPath.row][@"param"];
        if (indexPath.row == 0) {
            cell.selected = YES;
        }
        if ([_datasouce[indexPath.row][@"param"] isEqualToString:@""]) {
            cell.userInteractionEnabled  = NO;
        }
        
        cell.displayLabel.font = [UIFont systemFontOfSize:13*SIZE];
        
        return cell;
        
   
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

        _idnum = _datasouce[indexPath.row][@"id"];
//        _slectnum = indexPath.row;
}




- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        //设置item的大小
        _layout.itemSize = CGSizeMake(self.mycollectionView.bounds.size.width / _row, 14*sIZE);
        _layout.minimumLineSpacing = 33*SIZE;
        _layout.minimumInteritemSpacing = 0;
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //        _layout.sectionHeadersPinToVisibleBounds = YES;
    }
    return _layout;
}

-(NSString *)GetDidID
{
    return _idnum;
}




@end
