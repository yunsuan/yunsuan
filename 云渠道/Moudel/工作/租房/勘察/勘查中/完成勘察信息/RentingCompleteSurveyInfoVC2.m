//
//  RentingCompleteSurveyInfoVC2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/31.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingCompleteSurveyInfoVC2.h"
#import "RentingCompleteSurveyInfoVC3.h"

#import "BaseCollHeader.h"
#import "CompleteSurveyCollCell2.h"
#import "BaseCollCell.h"

@interface RentingCompleteSurveyInfoVC2 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_dataArr;
    NSArray *_titleArr;
    NSArray *_tagArr;
    NSArray *_contentArr;
}
@property (nonatomic, strong) UICollectionView *tagColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionViewLayout *layout;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation RentingCompleteSurveyInfoVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _contentArr = @[@"房子二梯三户边套，南北通透户型，产证面积89平实用95平，可谈朝南带阳台，厨房朝北带很大生活阳台，一个卧室朝南，二个朝南。非常方正，没有一点浪费空间。"];
    _tagArr = [self getDetailConfigArrByConfigState:PROJECT_TAGS_DEFAULT];
    _dataArr = [[NSMutableArray alloc] init];
    _titleArr = @[@"房源概况",@"装修描述",@"备注",@"房屋配套",@"已选标签"];
    //    for (int i = 0; i < array.count; i++) {
    //        [_tagArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //            if ([obj[@"id"] integerValue] == [array[i][@"id"] integerValue]) {
    //                [_dataArr addObject:obj];
    //                *stop = YES;
    //            }
    //        }];
    //    }
}

- (void)ActionSaveBtn:(UIButton *)btn{
    
    RentingCompleteSurveyInfoVC3 *nextVC = [[RentingCompleteSurveyInfoVC3 alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //    if (section == 0) {
    //
    //        return _tagArr.count;
    //    }
    //    return _dataArr.count;
    if (section < 3) {
        
        return 1;
    }
    return _tagArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 40 *SIZE);
    
}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    BaseCollHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BaseCollHeader" forIndexPath:indexPath];
    if (!header) {
        
        header = [[BaseCollHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    }
    header.titleL.text = _titleArr[indexPath.section];
    
    return header;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section < 3) {
        
        
        return CGSizeMake(SCREEN_Width, 60 *SIZE);
        //        CGSize size = [_contentArr[0] boundingRectWithSize:CGSizeMake(307 *SIZE, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13 *SIZE]} context:nil].size;
        //        return CGSizeMake(SCREEN_Width, size.height + 30 *SIZE);
    }else{
        
        CGSize size = [_tagArr[indexPath.row][@"param"] boundingRectWithSize:CGSizeMake(332 *SIZE, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13 *SIZE]} context:nil].size;
        return CGSizeMake(size.width + 28 *SIZE, size.height + 18 *SIZE);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section < 3) {
        
        CompleteSurveyCollCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell2" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[CompleteSurveyCollCell2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 90 *SIZE)];
        }
        
        //        cell.titleL.text = @"房子二梯三户边套，南北通透户型，产证面积89平实用95平，可谈朝南带阳台，厨房朝北带很大生活阳台，一个卧室朝南，二个朝南。非常方正，没有一点浪费空间。";
        
        return cell;
    }else{
        
        BaseCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BaseCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[BaseCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 30 *SIZE)];
        }
        cell.colorView.backgroundColor = COLOR(213, 242, 255, 1);
        cell.titleL.text = _tagArr[indexPath.row][@"param"];
        return cell;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //    if (indexPath.section == 0) {
    //
    //        if ([_dataArr containsObject:_tagArr[indexPath.item]]) {
    //
    //            [_dataArr removeObject:_tagArr[indexPath.item]];
    //        }else{
    //
    //            [_dataArr addObject:_tagArr[indexPath.item]];
    //        }
    //    }
    //    [collectionView reloadData];
}


- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"完成勘察信息";
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //    _flowLayout.estimatedItemSize = CGSizeMake(120 *SIZE, 40 *SIZE);
    _flowLayout.minimumInteritemSpacing = 2 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(17 *SIZE, 32 *SIZE, 31 *SIZE, 10 *SIZE);
    //    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _tagColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) collectionViewLayout:_flowLayout];
    _tagColl.backgroundColor = [UIColor whiteColor];
    _tagColl.delegate = self;
    _tagColl.dataSource = self;
    _tagColl.showsHorizontalScrollIndicator = NO;
    _tagColl.showsVerticalScrollIndicator = NO;
    
    [_tagColl registerClass:[BaseCollCell class] forCellWithReuseIdentifier:@"BaseCollCell"];
    [_tagColl registerClass:[CompleteSurveyCollCell2 class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell2"];
    [_tagColl registerClass:[BaseCollHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BaseCollHeader"];
    [self.view addSubview:_tagColl];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_nextBtn];
}

@end
