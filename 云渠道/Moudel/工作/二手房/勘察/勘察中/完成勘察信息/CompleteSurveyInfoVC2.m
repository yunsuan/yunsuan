//
//  CompleteSurveyInfoVC2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompleteSurveyInfoVC2.h"

#import "CompleteSurveyInfoVC4.h"

#import "BaseCollHeader.h"
#import "CompleteSurveyCollCell2.h"
#import "BaseCollCell.h"

@interface CompleteSurveyInfoVC2 ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_dataArr;
    NSArray *_titleArr;
    NSArray *_tagArr;
    NSArray *_contentArr;
    NSString *_str1;
    NSString *_str2;
}
@property (nonatomic, strong) UICollectionView *tagColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionViewLayout *layout;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation CompleteSurveyInfoVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _contentArr = @[@"房子二梯三户边套，南北通透户型，产证面积89平实用95平，可谈朝南带阳台，厨房朝北带很大生活阳台，一个卧室朝南，二个朝南。非常方正，没有一点浪费空间。"];
    
    _dataArr = [[NSMutableArray alloc] init];
    if ([self.dic[@"type"] integerValue] == 1) {
        
        _titleArr = @[@"核心卖点",@"装修描述",@"房源标签",@"已选标签"];
        _tagArr = [self getDetailConfigArrByConfigState:HOUSE_TAGS_HOUSE];
    }else if ([self.dic[@"type"] integerValue] == 2){
        
        _titleArr = @[@"商铺描述",@"铺面优势",@"房源标签",@"已选标签"];
        _tagArr = [self getDetailConfigArrByConfigState:HOUSE_TAGS_SHOP];
    }else{
        
        _titleArr = @[@"房源描述",@"房源优势",@"房源标签",@"已选标签"];
        _tagArr = [self getDetailConfigArrByConfigState:HOUSE_TAGS_OFFICE];
    }
    
//    for (int i = 0; i < _tagArr.count; i++) {
//        [_tagArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([obj[@"id"] integerValue] == [_tagArr[i][@"id"] integerValue]) {
//                [_dataArr addObject:obj];
//                *stop = YES;
//            }
//        }];
//    }
}

- (void)ActionSaveBtn:(UIButton *)btn{
    
    if (_dataArr.count) {
        
        __block NSString *str;
        [_dataArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                str = obj[@"id"];
            }else{
                
                str = [NSString stringWithFormat:@"%@,%@",str,obj[@"id"]];
            }
            
        }];
        [self.dic setObject:str forKey:@"house_tags"];
    }
    
    if (_str1.length) {
        
        if ([self.dic[@"type"] integerValue] == 1) {
         
            [self.dic setObject:_str1 forKey:@"core_selling"];
        }else if ([self.dic[@"type"] integerValue] == 2) {
            
            [self.dic setObject:_str1 forKey:@"describe"];
        }else{
            
            [self.dic setObject:_str1 forKey:@"describe"];
        }
    }
    
    if (_str2.length) {
        
        if ([self.dic[@"type"] integerValue] == 1) {
            
            [self.dic setObject:_str2 forKey:@"decoration_standard"];
        }else if ([self.dic[@"type"] integerValue] == 2) {
            
            [self.dic setObject:_str2 forKey:@"advantage"];
        }else{
            
            [self.dic setObject:_str2 forKey:@"advantage"];
        }
    }

    CompleteSurveyInfoVC4 *nextVC = [[CompleteSurveyInfoVC4 alloc] init];
    nextVC.completeSurveyInfoVCBlock4 = ^{
        
        if (self.completeSurveyInfoVCBlock2) {
            
            self.completeSurveyInfoVCBlock2();
        }
    };
    nextVC.dic = [NSMutableDictionary dictionaryWithDictionary:self.dic];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section < 2) {
        
        return 1;
    }else if (section == 2){
        
        return _tagArr.count;
    }else{
        
        return _dataArr.count;
    }
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

    if (indexPath.section < 2) {

        
//        return CGSizeMake(SCREEN_Width, 60 *SIZE);
        CGSize size = [_contentArr[0] boundingRectWithSize:CGSizeMake(307 *SIZE, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13 *SIZE]} context:nil].size;
        return CGSizeMake(SCREEN_Width, size.height + 30 *SIZE);
    }else{
        
        CGSize size = [_tagArr[indexPath.row][@"param"] boundingRectWithSize:CGSizeMake(332 *SIZE, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13 *SIZE]} context:nil].size;
        return CGSizeMake(size.width + 28 *SIZE, size.height + 18 *SIZE);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section < 2) {
        
        CompleteSurveyCollCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell2" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[CompleteSurveyCollCell2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 90 *SIZE)];
        }
        
        cell.completeSurveyCollCell2Block = ^(NSString *str) {
          
            if (indexPath.section == 0) {
                
                _str1 = str;
            }else{
                
                _str2 = str;
            }
        };
        
        if (indexPath.section == 0) {
            
            cell.contentTV.text = _str1;
        }else{
            
            cell.contentTV.text = _str2;
        }
//        cell.titleL.text = @"房子二梯三户边套，南北通透户型，产证面积89平实用95平，可谈朝南带阳台，厨房朝北带很大生活阳台，一个卧室朝南，二个朝南。非常方正，没有一点浪费空间。";
        
        return cell;
    }else{
        
        if (indexPath.section == 2) {
            
            BaseCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BaseCollCell" forIndexPath:indexPath];
            if (!cell) {
                
                cell = [[BaseCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 30 *SIZE)];
            }
            cell.colorView.backgroundColor = COLOR(213, 242, 255, 1);
            cell.titleL.text = _tagArr[indexPath.row][@"param"];
            return cell;
        }else{
            
            BaseCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BaseCollCell" forIndexPath:indexPath];
            if (!cell) {
                
                cell = [[BaseCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 30 *SIZE)];
            }
            cell.colorView.backgroundColor = COLOR(213, 242, 255, 1);
            cell.titleL.text = _dataArr[indexPath.row][@"param"];
            return cell;
        }
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {

        if ([_dataArr containsObject:_tagArr[indexPath.item]]) {

            [_dataArr removeObject:_tagArr[indexPath.item]];
        }else{

            [_dataArr addObject:_tagArr[indexPath.item]];
        }
    }
    [collectionView reloadData];
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
