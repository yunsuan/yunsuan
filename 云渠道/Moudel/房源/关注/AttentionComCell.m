//
//  AttentionComCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/11/16.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "AttentionComCell.h"

@implementation AttentionComCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(AttetionComModel *)model{
    
    if (model.img_url.length>0) {
        
        [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,model.img_url]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                _headImg.image =   [UIImage imageNamed:@"default_3"];
            }
        }];
    }else{
        
        _headImg.image =   [UIImage imageNamed:@"default_3"];
    }
    
    _titleL.text = model.project_name;
    _contentL.text = model.absolute_address;
    NSMutableAttributedString *PriceAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"均价：%@元/平",model.average_price]];;
    [PriceAttr addAttribute:NSForegroundColorAttributeName value:YJ86Color range:NSMakeRange(0, 3)];
    [PriceAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11 *SIZE] range:NSMakeRange(0, 3)];
    _averageL.attributedText = PriceAttr;
    
    _codeL.text = [NSString stringWithFormat:@"%@%@",@"小区编号：",model.project_code];
    NSMutableAttributedString *onSaleAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"在售：%@套",model.on_sale]];
    [onSaleAttr addAttribute:NSForegroundColorAttributeName value:YJ86Color range:NSMakeRange(0, 2)];
    [onSaleAttr addAttribute:NSForegroundColorAttributeName value:YJ86Color range:NSMakeRange(onSaleAttr.length - 1, 1)];
    _onSaleL.attributedText = onSaleAttr;
    _attionL.text = [NSString stringWithFormat:@"关注人数：%@人",model.subs_num];
    
    _reasonL.text = model.comment;
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(12 *SIZE, 16 *SIZE, 100 *SIZE, 88 *SIZE)];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    _titleL.numberOfLines = 0;
    [self.contentView addSubview:_titleL];
    
    _contentL = [[UILabel alloc] init];
    _contentL.textColor = YJContentLabColor;
    _contentL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contentL.numberOfLines = 0;
    [self.contentView addSubview:_contentL];
    
    _averageL = [[UILabel alloc] init];
    _averageL.textColor = COLOR(255, 70, 70, 1);
    _averageL.font = [UIFont systemFontOfSize:13 *SIZE];
    _averageL.numberOfLines = 0;
    [self.contentView addSubview:_averageL];
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJContentLabColor;
    _codeL.font = [UIFont systemFontOfSize:11 *SIZE];
    _codeL.numberOfLines = 0;
    //    _codeL.preferredMaxLayoutWidth = 120 *SIZE;
    [self.contentView addSubview:_codeL];
    
    _onSaleL = [[UILabel alloc] init];
    _onSaleL.textColor = YJBlueBtnColor;
    _onSaleL.textAlignment = NSTextAlignmentRight;
    _onSaleL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_onSaleL];
    
    _attionL = [[UILabel alloc] init];
    _attionL.textColor = YJContentLabColor;
    _attionL.font = [UIFont systemFontOfSize:11 *SIZE];
    _attionL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_attionL];
    
    _reasonL = [[UILabel alloc] init];
    _reasonL.textColor = YJContentLabColor;
    _reasonL.numberOfLines = 0;
    _reasonL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self.contentView addSubview:_reasonL];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_averageL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-90 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_averageL.mas_bottom).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
    }];
    
    [_onSaleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(280 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(11 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_attionL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(_averageL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_reasonL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_attionL.mas_bottom).offset(18 *SIZE);
        make.width.equalTo(@(340 *SIZE));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_reasonL.mas_bottom).offset(9 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
}

@end
