//
//  MyShopTagVC.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopTagVC.h"

#import "GZQFlowLayout.h"

#import "AddTagViewCollCell.h"
#import "CompleteCustomCollCell.h"

@interface MyShopTagVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UICollectionView *tagColl;

@property (nonatomic, strong) GZQFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation MyShopTagVC

- (instancetype)initWithTagArr:(NSArray *)tagArr
{
    self = [super init];
    if (self) {
    
        _dataArr = [[NSMutableArray alloc] initWithArray:tagArr];
        [self initUI];
    }
    return self;
}

- (void)ActionSaveBtn:(UIButton *)btn{
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    if (_dataArr.count) {
        
        NSString *str = [_dataArr componentsJoinedByString:@","];
        [tempDic setValue:str forKey:@"self_tags"];
    }else{
        
        [tempDic setValue:@"" forKey:@"self_tags"];
    }
    [BaseRequest POST:UpdateOnlineStoreInfo_URL parameters:tempDic success:^(id resposeObject) {

        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {

            if (self.myShopTagVCBlock) {
                self.myShopTagVCBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{

            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {

        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item >= _dataArr.count) {
        
        return CGSizeMake(SCREEN_Width, 40 *SIZE);
    }
    return CGSizeMake(70 *SIZE, 37*SIZE);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _dataArr.count + 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item < _dataArr.count) {
        
        AddTagViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddTagViewCollCell" forIndexPath:indexPath];
        
        cell.tag = indexPath.item;
        cell.cancelBtn.hidden = NO;
        
        [cell setstylebytype:@"0" andsetlab:_dataArr[(NSUInteger) indexPath.item]];
        
        cell.deleteBtnBlock = ^(NSUInteger index) {
        
            [_dataArr removeObjectAtIndex:index];
            [collectionView reloadData];
            [self reloadInputViews];
        };
        return cell;
    }else{
        
        CompleteCustomCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteCustomCollCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[CompleteCustomCollCell alloc] initWithFrame:CGRectMake(0, 0, 280 *SIZE, 40 *SIZE)];
        }
        
        cell.completeCustomCollCellBlock = ^(NSString * _Nonnull str) {
            
            [_dataArr addObject:str];
            [collectionView reloadData];
        };
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [collectionView reloadData];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"修改标签";
    
    _flowLayout = [[GZQFlowLayout alloc] initWithType:0 betweenOfCell:2 *SIZE];
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 32 *SIZE, 31 *SIZE, 0);
    
    
    _tagColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) collectionViewLayout:_flowLayout];
    _tagColl.backgroundColor = [UIColor whiteColor];
    _tagColl.delegate = self;
    _tagColl.dataSource = self;
    _tagColl.showsHorizontalScrollIndicator = NO;
    _tagColl.showsVerticalScrollIndicator = NO;
    [_tagColl registerClass:[AddTagViewCollCell class] forCellWithReuseIdentifier:@"AddTagViewCollCell"];
    [_tagColl registerClass:[CompleteCustomCollCell class] forCellWithReuseIdentifier:@"CompleteCustomCollCell"];
    [self.view addSubview:_tagColl];
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_MORE, SCREEN_Width, 40 *SIZE + TAB_BAR_MORE);
    _saveBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_saveBtn addTarget:self action:@selector(ActionSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_saveBtn];
}
@end
