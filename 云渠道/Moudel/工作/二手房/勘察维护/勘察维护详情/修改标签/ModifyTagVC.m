//
//  ModifyTagVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ModifyTagVC.h"
#import "AddTagViewCollCell.h"
#import "AddTagCollHeader.h"
#import "AddTagCollFooter.h"

@interface ModifyTagVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_dataArr;
    NSArray *_tagArr;
    NSInteger _type;
    bool _isContain;
}
@property (nonatomic, strong) UICollectionView *tagColl;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation ModifyTagVC

- (instancetype)initWithArray:(NSArray *)array type:(NSInteger)type
{
    self = [super init];
    if (self) {
        
        _type = type;
        if (type == 1) {
            
            _tagArr = [self getDetailConfigArrByConfigState:HOUSE_TAGS_HOUSE];
        }else if (type == 2){
            
            _tagArr = [self getDetailConfigArrByConfigState:HOUSE_TAGS_SHOP];
        }else{
            
            _tagArr = [self getDetailConfigArrByConfigState:HOUSE_TAGS_OFFICE];
        }
        
        _dataArr = [[NSMutableArray alloc] init];//WithArray:array];
        for (NSUInteger i = 0; i < array.count; i++) {
            
            NSDictionary *dic = @{@"id":array[i][@"tag_id"],
                                  @"param":array[i][@"tag_name"]
                                  };
            [_dataArr addObject:dic];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
}

- (void)ActionSaveBtn:(UIButton *)btn{
    
    NSString *tags;
    for (NSUInteger i = 0; i < _dataArr.count; i++) {

        tags = i == 0 ? _dataArr[0][@"id"] : [NSString stringWithFormat:@"%@,%@", tags, _dataArr[i][@"id"]];
    }
    if(!tags.length){
        
        tags = @"";
    }
    NSDictionary *dic = @{@"house_id":self.houseId,
                          @"house_tags":tags,
                          @"type":[NSString stringWithFormat:@"%ld",_type]
                          };
    [BaseRequest POST:HouseSurveyUpdateHouseInfo_URL parameters:dic success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (self.modifyTagSaveBtnBlock) {
                self.modifyTagSaveBtnBlock(_dataArr);
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
    
    return CGSizeMake(80 *SIZE, 37*SIZE);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return _tagArr.count;
    }
    return _dataArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 40 *SIZE);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return CGSizeMake(SCREEN_Width, 7 *SIZE);
    }else{
        
        return CGSizeZero;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        AddTagCollHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AddTagCollHeader" forIndexPath:indexPath];
        if (!header) {
            
            header = [[AddTagCollHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
        }
        
        if (indexPath.section == 0) {
            
            header.titleL.text = @"所有标签";
        }else{
            
            header.titleL.text = @"已选标签";
        }
        
        return header;
    }else{
        
        AddTagCollFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"AddTagCollFooter" forIndexPath:indexPath];
        if (!footer) {
            
            footer = [[AddTagCollFooter alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 7 *SIZE)];
        }
        
        return footer;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AddTagViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddTagViewCollCell" forIndexPath:indexPath];
    
    cell.tag = indexPath.item;
    
    if (indexPath.section == 0) {
        
        cell.cancelBtn.hidden = YES;
        [cell setstylebytype:@"0" andsetlab:_tagArr[(NSUInteger) indexPath.item][@"param"]];
    }else{
        
        cell.cancelBtn.hidden = NO;
        
        [cell setstylebytype:@"0" andsetlab:_dataArr[(NSUInteger) indexPath.item][@"param"]];
    }

    cell.deleteBtnBlock = ^(NSUInteger index) {

        [_dataArr removeObjectAtIndex:index];
        [collectionView reloadData];
        [self reloadInputViews];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        _isContain = NO;
        [_dataArr enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([dic[@"id"] integerValue] == [_tagArr[indexPath.item][@"id"] integerValue]) {
                
                [_dataArr removeObjectAtIndex:idx];
                _isContain = YES;
                *stop = YES;
            }
        }];
        if (!_isContain){
            
            [_dataArr addObject:_tagArr[(NSUInteger) indexPath.item]];
        }
    }
    [collectionView reloadData];
}

- (void)initUI{
    
    self.navBackgroundView.hidden = NO;
    self.titleLabel.text = @"修改标签";
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumInteritemSpacing = 2 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 32 *SIZE, 31 *SIZE, 0);
    //    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _tagColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) collectionViewLayout:_flowLayout];
    _tagColl.backgroundColor = [UIColor whiteColor];
    _tagColl.delegate = self;
    _tagColl.dataSource = self;
    _tagColl.showsHorizontalScrollIndicator = NO;
    _tagColl.showsVerticalScrollIndicator = NO;
    
    [_tagColl registerClass:[AddTagViewCollCell class] forCellWithReuseIdentifier:@"AddTagViewCollCell"];
    [_tagColl registerClass:[AddTagCollHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AddTagCollHeader"];
    [_tagColl registerClass:[AddTagCollFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"AddTagCollFooter"];
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
