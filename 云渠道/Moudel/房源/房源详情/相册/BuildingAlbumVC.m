//
//  BuildingAlbumVC.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/4.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BuildingAlbumVC.h"
#import "BuildingAlbumCollCell.h"

@interface BuildingAlbumVC ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSInteger _num;
    NSMutableArray *_imgArr;
    NSMutableArray *_allArr;
    NSString *_info_id;
    NSInteger _total;
    NSInteger _current;
}

@property (nonatomic, strong) UILabel *currentL;

@property (nonatomic, strong) UILabel *allL;
@end

@implementation BuildingAlbumVC

//- (instancetype)initWithNum:(NSInteger)num imgArr:(NSArray *)imgArr
//{
//    self = [super init];
//    if (self) {
//
//        _num = num;
//        _imgArr = [NSMutableArray arrayWithArray:imgArr];
//    }
//    return self;
//}

- (instancetype)initWithNum:(NSInteger)num infoid:(NSString *)infoid
{
    self = [super init];
    if (self) {
        
        _num = 1;
        _info_id = infoid;
        _allArr = [@[] mutableCopy];
        _imgArr = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
    [self RequestMethod];
//    [self setNeedsStatusBarAppearanceUpdate];
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationSlide;
}
//- (void)setNeedsStatusBarAppearanceUpdate{
//
//    [super setNeedsStatusBarAppearanceUpdate];
//}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}


- (void)RequestMethod{
    
    [BaseRequest GET:GetImg_URL parameters:@{@"info_id":_info_id} success:^(id resposeObject) {

        if ([resposeObject[@"code"] integerValue] == 200) {
            
            if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
                
                [self SetData:resposeObject[@"data"]];
            }else{
                
//                [self showContent:@"暂无数据"];
            }
        }else if([resposeObject[@"code"] integerValue] == 400){
            
//            [self showContent:resposeObject[@"msg"]];
        }
        else{
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        
//        NSLog(@"%@",error);
        [self showContent:@"网络错误"];
    }];
}

- (void)SetData:(NSArray *)data{
    
    for ( int i = 0; i < data.count; i++) {
        
        if ([data[i] isKindOfClass:[NSDictionary class]]) {
            
            NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data[i]];
            
            [_imgArr addObject:tempDic];
            
            
            for (int j = 0; j < [tempDic[@"data"] count]; j++) {
                
                _total = _total + 1;
                [_allArr addObject:tempDic[@"data"][j]];
            }
        }
    }
    
    [_scrollView setContentSize:CGSizeMake(SCREEN_Width * _total, _scrollView.frame.size.height)];
    for (int i = 0; i < _total; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width * i, 0, SCREEN_Width, _scrollView.frame.size.height)];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:img];
        NSString *imgname = _allArr[i][@"img_url"];
        if (imgname.length>0) {
            [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_allArr[i][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"banner_default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (error) {
                    
                    img.image = [UIImage imageNamed:@"banner_default_2"];
                }
            }];
        }else{
            img.image = [UIImage imageNamed:@"banner_default_2"];
        }
        
    }
    [_albumColl reloadData];
    [_albumColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
//    [_scrollView setContentOffset:CGPointMake(_num *SCREEN_Width, 0)];
    _allL.text = [NSString stringWithFormat:@"全部1/%ld",_total];
    _currentL.text = [NSString stringWithFormat:@"%@1/%ld",_imgArr[0][@"name"],[_imgArr[0][@"data"] count]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _num = (scrollView.contentOffset.x / SCREEN_Width) + 1;
    _allL.text = [NSString stringWithFormat:@"全部%ld/%ld",_num,_total];
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        
        if (([_imgArr[i][@"data"] count]  + count)< _num) {
            
            count = count + [_imgArr[i][@"data"] count];
        }else{
            
            [_albumColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:NO scrollPosition:0];
            _currentL.text = [NSString stringWithFormat:@"%@%ld/%lu",_imgArr[i][@"name"],_num - count,[_imgArr[i][@"data"] count]];
            break;
        }
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BuildingAlbumCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BuildingAlbumCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BuildingAlbumCollCell alloc] initWithFrame:CGRectMake(0, 0, 50 *SIZE, 27 *SIZE)];
    }
    
    cell.contentL.text = _imgArr[indexPath.item][@"name"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        if (i < indexPath.item) {
            
            count = count + [_imgArr[i][@"data"] count];
        }
    }
    [_scrollView setContentOffset:CGPointMake(count * SCREEN_Width, 0) animated:NO];
    
    _currentL.text = [NSString stringWithFormat:@"%@1/%d",_imgArr[indexPath.item][@"name"],(unsigned)[_imgArr[indexPath.item][@"data"] count]];
}


- (void)initUI{
    
    self.titleLabel.text = @"楼盘相册";
    self.navBackgroundView.hidden = NO;
    self.titleLabel.textColor = CH_COLOR_white;
    self.line.hidden = YES;
    self.navBackgroundView.backgroundColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor blackColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 55 *SIZE - TAB_BAR_MORE)];
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(SCREEN_Width * _imgArr.count, _scrollView.bounds.size.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(50 *SIZE, 27 *SIZE);
    _flowLayout.minimumInteritemSpacing = 7 *SIZE;
    _flowLayout.sectionInset = UIEdgeInsetsMake(SIZE, 10 *SIZE, 27 *SIZE, 10 *SIZE);
    
    _currentL = [[UILabel alloc] initWithFrame:CGRectMake(9 *SIZE, SCREEN_Height - 75 *SIZE - TAB_BAR_MORE, 100 *SIZE, 12 *SIZE)];
    _currentL.textColor = YJContentLabColor;
    _currentL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.view addSubview:_currentL];
    
    _allL = [[UILabel alloc] initWithFrame:CGRectMake(250 *SIZE, SCREEN_Height - 75 *SIZE - TAB_BAR_MORE, 100 *SIZE, 12 *SIZE)];
    _allL.textColor = YJContentLabColor;
    _allL.font = [UIFont systemFontOfSize:12 *SIZE];
    _allL.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_allL];
    
    _albumColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_Height - 55 *SIZE - TAB_BAR_MORE, SCREEN_Width, 55 *SIZE) collectionViewLayout:_flowLayout];
    _albumColl.backgroundColor = [UIColor blackColor];
    _albumColl.delegate = self;
    _albumColl.dataSource = self;
    
    [_albumColl registerClass:[BuildingAlbumCollCell class] forCellWithReuseIdentifier:@"BuildingAlbumCollCell"];
    [self.view addSubview:_albumColl];
    
}

@end
