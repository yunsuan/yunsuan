//
//  MaintainRoomInfoCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainRoomInfoCell.h"
#import "MaintainInfoImgCollCell.h"

@interface MaintainRoomInfoCell()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_imgArr;
}

@end

@implementation MaintainRoomInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgArr = [@[] mutableCopy];
        self.dataArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    
    _imgArr = [NSMutableArray arrayWithArray:dataArr];
    [_imgColl reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MaintainInfoImgCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MaintainInfoImgCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[MaintainInfoImgCollCell alloc] initWithFrame:CGRectMake(0, 0, 122 *SIZE, 140 *SIZE)];
    }

    cell.titleL.text = self.dataArr[indexPath.item][@"name"];
    NSString *imageurl = _imgArr[indexPath.item][@"img_url"];
   
    if (imageurl.length>0) {
    
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_imgArr[indexPath.item][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
            if (error) {
            
                cell.imgView.image = [UIImage imageNamed:@"default_3"];
            }
        }];
    }else{
     
        cell.imgView.image = [UIImage imageNamed:@"default_3"];
    }
    return cell;
}

- (void)initUI{
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(122 *SIZE, 140 *SIZE);
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _imgColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 140 *SIZE) collectionViewLayout:_flowLayout];
    _imgColl.backgroundColor = self.contentView.backgroundColor;
    _imgColl.showsVerticalScrollIndicator = NO;
    _imgColl.showsHorizontalScrollIndicator = NO;
    _imgColl.delegate = self;
    _imgColl.dataSource = self;
    [_imgColl registerClass:[MaintainInfoImgCollCell class] forCellWithReuseIdentifier:@"MaintainInfoImgCollCell"];
    [self.contentView addSubview:_imgColl];
    
    [_imgColl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(140 *SIZE);
        make.bottom .equalTo(self.contentView).offset(0);
    }];
}

@end
