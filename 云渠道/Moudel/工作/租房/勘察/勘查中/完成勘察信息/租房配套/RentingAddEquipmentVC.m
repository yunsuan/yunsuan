//
//  RentingAddEquipmentVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/12/28.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "RentingAddEquipmentVC.h"

#import "StoreViewCollCell.h"

@interface RentingAddEquipmentVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_dataArr;
    NSMutableArray *_selectArr;
}
@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation RentingAddEquipmentVC

- (instancetype)initWithType:(NSInteger)type
{
    self = [super init];
    if (self) {
        
        _dataArr = [@[] mutableCopy];
        
        [BaseRequest GET:RentRecordUI_URL parameters:@{@"type":@(type)} success:^(id resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                _dataArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
                for (int i = 0; i < _dataArr.count; i++) {
                    
                    [_selectArr addObject:@(0)];
                }
                if (self.data.count) {
                    
                    for (int i = 0; i < self.data.count; i++) {
                        
                        _selectArr[[_dataArr indexOfObject:self.data[i]]] = @(1);
                    }
                }
                [_coll reloadData];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            
            [self showContent:@"网络错误"];
            NSLog(@"%@",error);
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectArr = [@[] mutableCopy];
    
    [self initUI];
}

- (void)ActionNextBtn:(UIButton *)btn{
    
    if (self.rentingAddEquipmentVCBlock) {
        
        if (self.titleStr.length) {
            
            //            NSMutableArray *matchArr = [@[] mutableCopy];
            NSMutableArray *tempArr = [@[] mutableCopy];
            for (int i = 0; i < _selectArr.count; i++) {
                
                if ([_selectArr[i] integerValue]) {
                    
                    [tempArr addObject:_dataArr[i]];
                }
            }
            NSString *str;
            for (int i = 0; i < tempArr.count; i++) {
                
                if (i == 0) {
                    
                    str = [NSString stringWithFormat:@"%@",tempArr[0][@"ui_id"]];
                }else{
                    
                    str = [NSString stringWithFormat:@"%@,%@",str,tempArr[i][@"ui_id"]];
                }
            }
            [BaseRequest POST:HouseSurveyUpdateHouseInfo_URL parameters:@{@"house_id":self.houseId,@"type":self.type,@"match_tags":str} success:^(id resposeObject) {
                
                NSLog(@"%@",resposeObject);
                if ([resposeObject[@"code"] integerValue] == 200) {
                    
                    self.rentingAddEquipmentVCBlock(tempArr);
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else{
                    
                    [self showContent:resposeObject[@"msg"]];
                }
            } failure:^(NSError *error) {
                
                NSLog(@"%@",error);
                [self showContent:@"网络错误"];
            }];
            //            if ([self.type integerValue] == 2) {
            //
            //                [BaseRequest POST:HouseSurveyUpdateHouseInfo_URL parameters:@{@"house_id":self.houseId,@"type":self.type,@"match_tags":@""} success:^(id resposeObject) {
            //
            //                    NSLog(@"%@",resposeObject);
            //                    if ([resposeObject[@"code"] integerValue] == 200) {
            //
            //
            //                    }else{
            //
            //
            //                    }
            //                } failure:^(NSError *error) {
            //
            //                    NSLog(@"%@",error);
            //                }];
            //            }else{
            //
            //                [BaseRequest POST:HouseSurveyUpdateHouseInfo_URL parameters:@{@"house_id":self.houseId,@"type":self.type,@"match_tags":@""} success:^(id resposeObject) {
            //
            //                    NSLog(@"%@",resposeObject);
            //                    if ([resposeObject[@"code"] integerValue] == 200) {
            //
            //
            //                    }else{
            //
            //
            //                    }
            //                } failure:^(NSError *error) {
            //
            //                    NSLog(@"%@",error);
            //                }];
            //            }
        }else{
            
            NSMutableArray *tempArr = [@[] mutableCopy];
            for (int i = 0; i < _selectArr.count; i++) {
                
                if ([_selectArr[i] integerValue]) {
                    
                    [tempArr addObject:_dataArr[i]];
                }
            }
            self.rentingAddEquipmentVCBlock(tempArr);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreViewCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[StoreViewCollCell alloc] initWithFrame:CGRectMake(0, 0, 72 *SIZE, 60 *SIZE)];
    }
    
    NSString *imageurl = _dataArr[indexPath.item][@"url"];
    if (imageurl.length>0) {
        
        [cell.typeImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataArr[indexPath.item][@"url"]]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if ([_selectArr[indexPath.item] integerValue]) {
                
                cell.typeImg.image = image;
            }else{
                
                cell.typeImg.image = [cell grayscaleImageForImage:image];
            }
        }];
    }
    else{
#warning 默认图片？？
    }
    cell.titleL.text = _dataArr[indexPath.item][@"name"];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_selectArr[indexPath.item] integerValue] == 1) {
        
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@(0)];
    }else{
        
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@(1)];
    }
    [collectionView reloadData];
}

- (void)initUI{
    
    if (self.title.length) {
        
        self.titleLabel.text = @"修改配套";
    }else{
        
        self.titleLabel.text = @"添加配套";
    }
    
    self.navBackgroundView.hidden = NO;
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.estimatedItemSize = CGSizeMake(72 *SIZE, 60 *SIZE);
    _flowLayout.minimumLineSpacing = 10 *SIZE *SIZE;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_HEIGHT) collectionViewLayout:_flowLayout];
    _coll.backgroundColor = [UIColor whiteColor];
    _coll.allowsMultipleSelection = YES;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[StoreViewCollCell class] forCellWithReuseIdentifier:@"StoreViewCollCell"];
    [self.view addSubview:_coll];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(0, SCREEN_Height - 40 *SIZE - TAB_BAR_HEIGHT, SCREEN_Width, 40 *SIZE + TAB_BAR_HEIGHT);
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_nextBtn addTarget:self action:@selector(ActionNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:YJBlueBtnColor];
    [self.view addSubview:_nextBtn];
}

@end
