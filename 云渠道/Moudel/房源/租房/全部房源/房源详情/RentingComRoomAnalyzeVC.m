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

@interface RentingComRoomAnalyzeVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@end

@implementation RentingComRoomAnalyzeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 13;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

//    return UICollectionViewFlowLayoutAutomaticSize;
    return CGSizeMake(50 *SIZE , 60 *SIZE);
//    if (indexPath.section == 0) {
//
//        return <#expression#>
//    }else{
//
//
//    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

//    if (indexPath.section == 0) {

        RentingComRoomAnalyzeColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RentingComRoomAnalyzeColCell" forIndexPath:indexPath];
        if (!cell) {

            cell = [[RentingComRoomAnalyzeColCell alloc] initWithFrame:CGRectMake(0, 0, 50 *SIZE, 60 *SIZE)];
        }
        cell.bigImg.image = [UIImage imageNamed:@"commission_2"];
        cell.titleL.text = @"床";

        return cell;
//    }else{
//
//        RentingComRoomAnalyzeColCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RentingComRoomAnalyzeColCell2" forIndexPath:indexPath];
//        if (!cell) {
//
//            cell = [[RentingComRoomAnalyzeColCell2 alloc] initWithFrame:CGRectMake(0, 0, 50 *SIZE, 60 *SIZE)];
//        }
//        cell.contentL.text = @"房子是业主自住装修，客厅和卧室铺了木地板，有吊顶，卫生间做的蹲便，贴的瓷砖。";
//
//        return cell;
//    }
}

- (void)initUI{

    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.estimatedItemSize = CGSizeMake(50 *SIZE, 60 *SIZE);
//    if (@available(iOS 10.0, *)) {
//        self.layout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
//    } else {
//        // Fallback on earlier versions
//    }
    self.layout.minimumLineSpacing = 10 *SIZE;


    self.coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT) collectionViewLayout:self.layout];
    self.coll.backgroundColor = self.view.backgroundColor;
    self.coll.delegate = self;
    self.coll.dataSource = self;
    [self.coll registerClass:[RentingComRoomAnalyzeColCell2 class] forCellWithReuseIdentifier:@"RentingComRoomAnalyzeColCell2"];
    [self.coll registerClass:[RentingComRoomAnalyzeColCell class] forCellWithReuseIdentifier:@"RentingComRoomAnalyzeColCell"];
    [self.view addSubview:self.coll];
}

@end
