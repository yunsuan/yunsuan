//
//  AddTagView2.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AddTagView2.h"
#import "AddTagViewCollCell.h"


@interface AddTagView2 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

//@property (nonatomic, strong) UICollectionView *tagColl;

@end

@implementation AddTagView2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.addTagView2Block) {
        
        self.addTagView2Block();
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(80 *SIZE, 37*SIZE);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddTagViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddTagViewCollCell" forIndexPath:indexPath];
    
    cell.tag = indexPath.item;
    
    [cell setstylebytype:@"0" andsetlab:_dataArr[(NSUInteger) indexPath.item][@"name"]];
    cell.deleteBtnBlock = ^(NSUInteger index) {
        
        [_dataArr removeObjectAtIndex:index];
        [collectionView reloadData];
        [self reloadInputViews];
    };
    return cell;
}

- (void)initUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(11 *SIZE, 13 *SIZE, 7 *SIZE, 13 *SIZE)];
    view.backgroundColor = YJBlueBtnColor;
    [self addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(33 *SIZE, 13 *SIZE, 100 *SIZE, 14 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:15 *SIZE];
    label.text = @"需求标签";
    [self addSubview:label];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(308 *SIZE, 3 *SIZE, 35 *SIZE, 35 *SIZE);
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_addBtn setImage:[UIImage imageNamed:@"add_2"] forState:UIControlStateNormal];
    [self addSubview:_addBtn];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumInteritemSpacing = 7 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 32 *SIZE, 0, 0);
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _tagColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60 *SIZE, SCREEN_Width, 37 *SIZE) collectionViewLayout:_flowLayout];
    _tagColl.backgroundColor = [UIColor whiteColor];
    _tagColl.delegate = self;
    _tagColl.dataSource = self;
    _tagColl.showsHorizontalScrollIndicator = NO;
    _tagColl.showsVerticalScrollIndicator = NO;
    
    [_tagColl registerClass:[AddTagViewCollCell class] forCellWithReuseIdentifier:@"AddTagViewCollCell"];
    [self addSubview:_tagColl];
    
    
}

@end
