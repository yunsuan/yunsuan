//
//  RentingComRoomAnalyzeVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RentingComRoomAnalyzeVC.h"

#import "RentingComRoomAnalyzeColCell.h"
#import "RentingComRoomAnalyzeColCell2.h"
#import "RentingAnalysisHeaderView.h"
#import "RentingAnalysisFooterView.h"

@interface RentingComRoomAnalyzeVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableDictionary *_dataDic;
    NSString *_projectId;
    NSInteger _type;
}
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@end

@implementation RentingComRoomAnalyzeVC

- (instancetype)initWithHouseId:(NSString *)houseId type:(NSInteger)type
{
    self = [super init];
    if (self) {
        
        _projectId = houseId;
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _dataDic = [@{} mutableCopy];
    [self RequestMethod];
}

- (void)RequestMethod{
    
    [BaseRequest GET:RentHouseGetHouseAnalyse_URL parameters:@{@"house_id":_projectId,@"type":@(_type)} success:^(id resposeObject) {
        
        NSLog(@"%@",resposeObject);
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                
                _dataDic = [NSMutableDictionary dictionaryWithDictionary:resposeObject[@"data"]];
            }else{
                
                
            }
        }else if([resposeObject[@"code"] integerValue] == 400){
            
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
        [_coll reloadData];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (section == 0) {
        
        return 13;
    }else{
        
        return 1;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 40 *SIZE);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 15 *SIZE);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        RentingAnalysisHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RentingAnalysisHeaderView" forIndexPath:indexPath];
        if (!header) {
            
            header = [[RentingAnalysisHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
        }
        header.titleL.text = @"房源分析";
        
        return header;
    }else{
        
        RentingAnalysisFooterView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"RentingAnalysisFooterView" forIndexPath:indexPath];
        if (!header) {
            
            header = [[RentingAnalysisFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 15 *SIZE)];
        }
        
        return header;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //    return UICollectionViewFlowLayoutAutomaticSize;
    //    return CGSizeMake(50 *SIZE , 60 *SIZE);
    if (indexPath.section == 0) {
        
        return CGSizeMake(50 *SIZE , 60 *SIZE);
    }else{
        
        return CGSizeMake(50 *SIZE , 60 *SIZE);
        //        return UICollectionViewFlowLayoutAutomaticSize;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {

        RentingComRoomAnalyzeColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RentingComRoomAnalyzeColCell" forIndexPath:indexPath];
        if (!cell) {

            cell = [[RentingComRoomAnalyzeColCell alloc] initWithFrame:CGRectMake(0, 0, 50 *SIZE, 60 *SIZE)];
        }
        cell.bigImg.image = [UIImage imageNamed:@"Focus_selected"];
        cell.titleL.text = @"床";

        return cell;
    }else{

        RentingComRoomAnalyzeColCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RentingComRoomAnalyzeColCell2" forIndexPath:indexPath];
        if (!cell) {

            cell = [[RentingComRoomAnalyzeColCell2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width *SIZE, 60 *SIZE)];
        }
        cell.contentL.text = @"房子是业主自住装修，客厅和卧室铺了木地板，有吊顶，卫生间做的蹲便，贴的瓷砖。";

        return cell;
    }
}

- (void)initUI{

    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.estimatedItemSize = CGSizeMake(50 *SIZE, 60 *SIZE);
//    self.layout.se
    if (@available(iOS 10.0, *)) {
        self.layout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
    } else {
        // Fallback on earlier versions
    }
    self.layout.minimumLineSpacing = 10 *SIZE;


    self.coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT) collectionViewLayout:self.layout];
    self.coll.backgroundColor = [UIColor whiteColor];
    self.coll.delegate = self;
    self.coll.dataSource = self;
    [self.coll registerClass:[RentingComRoomAnalyzeColCell2 class] forCellWithReuseIdentifier:@"RentingComRoomAnalyzeColCell2"];
    [self.coll registerClass:[RentingComRoomAnalyzeColCell class] forCellWithReuseIdentifier:@"RentingComRoomAnalyzeColCell"];
    [self.coll registerClass:[RentingAnalysisHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RentingAnalysisHeaderView"];
    [self.coll registerClass:[RentingAnalysisFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"RentingAnalysisFooterView"];
    [self.view addSubview:self.coll];
}

@end
