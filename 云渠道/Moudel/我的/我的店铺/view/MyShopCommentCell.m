//
//  MyShopCommentCell.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopCommentCell.h"

#import "MyShopCustomCommentCell.h"

@interface MyShopCommentCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextViewDelegate>
{
    
    NSMutableArray *_dataArr;
    
    NSMutableArray *_commentArr;
}
@end

@implementation MyShopCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _dataArr = [[NSMutableArray alloc] init];
        _commentArr = [[NSMutableArray alloc] init];
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dataDic[@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            _headImg.image = [UIImage imageNamed:@"def_head"];
        }
    }];
    
    _nameL.text = dataDic[@"nick_name"];
    _timeL.text = dataDic[@"create_time"];
    if (![dataDic[@"house_id"] isKindOfClass:[NSNull class]] &&  [dataDic[@"house_id"] integerValue]) {
        
        NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@ %@",@"@",dataDic[@"project_name"],dataDic[@"build_name"],dataDic[@"unit_name"],dataDic[@"house_name"],dataDic[@"comment"]];
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
        [attr addAttribute:NSForegroundColorAttributeName value:YJBlueBtnColor range:NSMakeRange(0, attr.length - [dataDic[@"comment"] length])];
        _contentL.attributedText = attr;;
        _contentL.userInteractionEnabled = YES;
//        _contentL.text = @"";
    }else{
        
//        _contentL.attributedText = ;
        _contentL.text = dataDic[@"comment"];
        _contentL.userInteractionEnabled = NO;
    }
    
    _scoreL.text = [NSString stringWithFormat:@"%@分",dataDic[@"grade"]];
    
    _dataArr = [NSMutableArray arrayWithArray:dataDic[@"comment_tags"]];
    _commentArr = [NSMutableArray arrayWithArray:dataDic[@"replyList"]];
    
    if (_dataArr.count) {
        
        [_contentL mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView).offset(10 *SIZE);
            make.top.equalTo(self->_coll.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(self.contentView).offset(-10 *SIZE);
        }];
    }else{
        
        [_contentL mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView).offset(10 *SIZE);
            make.top.equalTo(self->_headImg.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(self.contentView).offset(-10 *SIZE);
        }];
    }
    
    [_coll reloadData];
    [_contentColl reloadData];
    
    [_coll mas_updateConstraints:^(MASConstraintMaker *make) {
       make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
    [_contentColl mas_updateConstraints:^(MASConstraintMaker *make) {
       make.height.mas_equalTo(_contentColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
}

- (void)ActionTap{
    
    if (self.myShopCommentCellLabelBlock) {
        
        self.myShopCommentCellLabelBlock();
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (collectionView == _coll) {
        
        return CGSizeMake(65 *SIZE, 25 *SIZE);
    }else{
        
        NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:11 *SIZE]};
        CGSize maxSize = CGSizeMake(340 *SIZE, MAXFLOAT);

        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

        // 计算文字占据的宽高
        CGSize size = [[NSString stringWithFormat:@"%@ 回复 %@：%@",_commentArr[indexPath.item][@"agent_name"],_commentArr[indexPath.item][@"nick_name"],_commentArr[indexPath.item][@"reply_comment"]] boundingRectWithSize:maxSize options:options attributes:attrs context:nil].size;
        return CGSizeMake(340 *SIZE, size.height + 10 *SIZE);
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _coll) {
        
        return _dataArr.count;
    }else{
        
        return _commentArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _coll) {
        
        TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
        
        cell.tag = indexPath.item;
        
        cell.contentL.text = _dataArr[indexPath.item];
        if (indexPath.item % 3 == 0) {
            
            cell.contentView.backgroundColor = COLOR(213, 242, 255, 1);
            cell.contentL.textColor = COLOR(64, 169, 255, 1);
        }else if (indexPath.item % 3 == 1){
            
            cell.contentView.backgroundColor = COLOR(234, 242, 237, 1);
            cell.contentL.textColor = COLOR(108, 187, 166, 1);
        }else if (indexPath.item % 3 == 2){
            
            cell.contentView.backgroundColor = COLOR(208, 243, 245, 1);
            cell.contentL.textColor = COLOR(36, 185, 195, 1);
        }
        
        return cell;
    }else{
        
        MyShopCustomCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyShopCustomCommentCell" forIndexPath:indexPath];
        if (!cell) {
            
            cell = [[MyShopCustomCommentCell alloc] initWithFrame:CGRectMake(0, 0, 340 *SIZE, 20 *SIZE)];
        }
        cell.tag = indexPath.item;
        
        cell.contentL.text = [NSString stringWithFormat:@"%@ 回复 %@：%@",_commentArr[indexPath.item][@"agent_name"],_commentArr[indexPath.item][@"nick_name"],_commentArr[indexPath.item][@"reply_comment"]];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.myShopCommentCellBlock) {
        
        self.myShopCommentCellBlock();
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    
    return YES;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] init];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.layer.cornerRadius = 20 *SIZE;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _flowLayout = [[GZQFlowLayout alloc] initWithType:0 betweenOfCell:2 *SIZE];
        
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) collectionViewLayout:_flowLayout];
    _coll.backgroundColor = [UIColor whiteColor];
    _coll.delegate = self;
    _coll.dataSource = self;
    _coll.showsVerticalScrollIndicator = NO;
    _coll.showsHorizontalScrollIndicator = NO;
    [_coll registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_coll];
    
    _contentLayout = [[GZQFlowLayout alloc] initWithType:0 betweenOfCell:2 *SIZE];
//    _contentLayout.estimatedItemSize = CGSizeMake(340 *SIZE, 20 *SIZE);
        
    _contentColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) collectionViewLayout:_contentLayout];
    _contentColl.backgroundColor = CLBackColor;;
    _contentColl.delegate = self;
    _contentColl.dataSource = self;
    _contentColl.showsVerticalScrollIndicator = NO;
    _contentColl.showsHorizontalScrollIndicator = NO;
    [_contentColl registerClass:[MyShopCustomCommentCell class] forCellWithReuseIdentifier:@"MyShopCustomCommentCell"];
    [self.contentView addSubview:_contentColl];
    
    _nameL = [[UILabel alloc] init];
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    _nameL.textColor = YJTitleLabColor;
    [self.contentView addSubview:_nameL];
    
    _scoreL = [[UILabel alloc] init];
    _scoreL.font = [UIFont systemFontOfSize:13 *SIZE];
    _scoreL.textColor = [UIColor redColor];
    [self.contentView addSubview:_scoreL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _timeL.textColor = YJTitleLabColor;
    [self.contentView addSubview:_timeL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contentL.textColor = YJTitleLabColor;
    _contentL.numberOfLines = 0;
    _contentL.adjustsFontSizeToFitWidth = YES;
//    _contentL.userInteractionEnabled =
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(ActionTap)];
    [_contentL addGestureRecognizer:tap];
    [self.contentView addSubview:_contentL];
    
//    _contentL = [[UITextView alloc] init];
//    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
//    _contentL.textColor = YJTitleLabColor;
//    _contentL.delegate = self;
//    _contentL.editable = NO;
//    _contentL.scrollEnabled = NO;
//    [self.contentView addSubview:_contentL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.height.mas_equalTo(40 *SIZE);
    }];
    
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(60 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_lessThanOrEqualTo(120 *SIZE);
    }];
    
    [_scoreL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self->_nameL.mas_right).offset(5 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(60 *SIZE);
        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_coll.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_contentColl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_contentL.mas_bottom).offset(10 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(_contentColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self->_contentColl.mas_bottom).offset(10*SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(1 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
