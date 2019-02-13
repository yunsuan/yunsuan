//
//  SecondryStatusTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/13.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecondryStatusTableCell.h"

@implementation SecondryStatusTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _img1.image = [UIImage imageNamed:@"progressbar_gray"];
    _img2.image = [UIImage imageNamed:@"progressbar_gray"];
    _img3.image = [UIImage imageNamed:@"progressbar_gray"];
    _img4.image = [UIImage imageNamed:@"progressbar_gray"];
    
    _line1.backgroundColor = COLOR(191, 191, 191, 1);
    _line2.backgroundColor = COLOR(191, 191, 191, 1);
    _line3.backgroundColor = COLOR(191, 191, 191, 1);
    
    _content1.textColor = YJTitleLabColor;
    _content2.textColor = YJTitleLabColor;
    _content3.textColor = YJTitleLabColor;
    _content4.textColor = YJTitleLabColor;
    
    if ([dataDic[@"disabled_state"] integerValue] == 0) {
        
        _statusL.text = @"有效";
        _statusL.textColor = YJBlueBtnColor;
    }else{
        
        _statusL.text = @"无效";
        _statusL.textColor = YJContentLabColor;
    }
    
    _timeL.text = [NSString stringWithFormat:@"%@推荐",dataDic[@"recommend_time"]];
    _titleL.text = dataDic[@"store_name"];
    switch ([dataDic[@"current_state"] integerValue]) {
        case 1:
        {
            _img1.image = [UIImage imageNamed:@"progressbar"];
            _img2.image = [UIImage imageNamed:@"progressbar_gray"];
            _img3.image = [UIImage imageNamed:@"progressbar_gray"];
            _img4.image = [UIImage imageNamed:@"progressbar_gray"];
            
            _line1.backgroundColor = COLOR(191, 191, 191, 1);
            _line2.backgroundColor = COLOR(191, 191, 191, 1);
            _line3.backgroundColor = COLOR(191, 191, 191, 1);
            
            _content1.textColor = COLOR(255, 165, 29, 1);;
            _content2.textColor = YJTitleLabColor;
            _content3.textColor = YJTitleLabColor;
            _content4.textColor = YJTitleLabColor;
            
//            _timeL.text = [NSString stringWithFormat:@"%@推荐",dataDic[@"recommend_time"]];
            break;
        }
        case 2:
        {
            _img1.image = [UIImage imageNamed:@"progressbar"];
            _img2.image = [UIImage imageNamed:@"progressbar"];
            _img3.image = [UIImage imageNamed:@"progressbar_gray"];
            _img4.image = [UIImage imageNamed:@"progressbar_gray"];
            
            _line1.backgroundColor = COLOR(255, 165, 29, 1);
            _line2.backgroundColor = COLOR(191, 191, 191, 1);
            _line3.backgroundColor = COLOR(191, 191, 191, 1);
            
            _content1.textColor = COLOR(255, 165, 29, 1);
            _content2.textColor = COLOR(255, 165, 29, 1);
            _content3.textColor = YJTitleLabColor;
            _content4.textColor = YJTitleLabColor;
//            _timeL.text = [NSString stringWithFormat:@"%@接单",dataDic[@"recommend_time"]];
            break;
        }
        case 3:
        {
            _img1.image = [UIImage imageNamed:@"progressbar"];
            _img2.image = [UIImage imageNamed:@"progressbar"];
            _img3.image = [UIImage imageNamed:@"progressbar"];
            _img4.image = [UIImage imageNamed:@"progressbar_gray"];
            
            _line1.backgroundColor = COLOR(255, 165, 29, 1);
            _line2.backgroundColor = COLOR(255, 165, 29, 1);
            _line3.backgroundColor = COLOR(191, 191, 191, 1);
            
            _content1.textColor = COLOR(255, 165, 29, 1);;
            _content2.textColor = COLOR(255, 165, 29, 1);;
            _content3.textColor = COLOR(255, 165, 29, 1);;
            _content4.textColor = YJTitleLabColor;
//            _timeL.text = [NSString stringWithFormat:@"%@合同",dataDic[@"recommend_time"]];
            break;
        }
        case 4:
        {
            _img1.image = [UIImage imageNamed:@"progressbar"];
            _img2.image = [UIImage imageNamed:@"progressbar"];
            _img3.image = [UIImage imageNamed:@"progressbar"];
            _img4.image = [UIImage imageNamed:@"progressbar"];
            
            _line1.backgroundColor = COLOR(255, 165, 29, 1);
            _line2.backgroundColor = COLOR(255, 165, 29, 1);
            _line3.backgroundColor = COLOR(255, 165, 29, 1);
            
            _content1.textColor = COLOR(255, 165, 29, 1);;
            _content2.textColor = COLOR(255, 165, 29, 1);;
            _content3.textColor = COLOR(255, 165, 29, 1);;
            _content4.textColor = COLOR(255, 165, 29, 1);;
//            _timeL.text = [NSString stringWithFormat:@"%@过户",dataDic[@"recommend_time"]];
            break;
        }
        default:
            _img1.image = [UIImage imageNamed:@"progressbar"];
            _img2.image = [UIImage imageNamed:@"progressbar"];
            _img3.image = [UIImage imageNamed:@"progressbar"];
            _img4.image = [UIImage imageNamed:@"progressbar"];
            
            _line1.backgroundColor = COLOR(255, 165, 29, 1);
            _line2.backgroundColor = COLOR(255, 165, 29, 1);
            _line3.backgroundColor = COLOR(255, 165, 29, 1);
            
            _content1.textColor = COLOR(255, 165, 29, 1);;
            _content2.textColor = COLOR(255, 165, 29, 1);;
            _content3.textColor = COLOR(255, 165, 29, 1);;
            _content4.textColor = COLOR(255, 165, 29, 1);;
            
            _timeL.text = [NSString stringWithFormat:@"%@推荐",dataDic[@"state_change_time"]];
            break;
    }
    
    [_titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(27 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        //        make.right.equalTo(_timeL.mas_left).offset(-22 *SIZE);
        make.width.equalTo(@(_titleL.mj_textWith + 5 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-86 *SIZE);
    }];
}

- (void)initUI{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 14 *SIZE, 7 *SIZE, 13 *SIZE)];
    titleView.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:titleView];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(310 *SIZE, 15 *SIZE, 35 *SIZE, 11 *SIZE)];
    _statusL.textColor = YJContentLabColor;
    _statusL.textAlignment = NSTextAlignmentRight;
    _statusL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_statusL];
    
    for (int i = 0; i < 4; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE + i * 100 *SIZE, 49 *SIZE, 17 *SIZE, 17 *SIZE)];
        img.image = [UIImage imageNamed:@"progressbar_gray"];
        
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE + i * 100 *SIZE, 75 *SIZE, 40 *SIZE, 11 *SIZE)];
        content.textColor = YJTitleLabColor;
        content.font = [UIFont systemFontOfSize:12 *SIZE];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(27 *SIZE + i * 100 *SIZE, 57 *SIZE, 83 *SIZE, SIZE)];
        line.backgroundColor = COLOR(191, 191, 191, 1);
        switch (i) {
            case 0:
            {
                _img1 = img;
                [self.contentView addSubview:_img1];
                
                _content1 = content;
                _content1.text = @"推荐";
                [self.contentView addSubview:_content1];
                
                _line1 = line;
                [self.contentView addSubview:_line1];
                break;
            }
            case 1:
            {
                _img2 = img;
                [self.contentView addSubview:_img2];
                
                _content2 = content;
                _content2.text = @"接单";
                [self.contentView addSubview:_content2];
                
                _line2 = line;
                [self.contentView addSubview:_line2];
                break;
            }
            case 2:
            {
                _img3 = img;
                [self.contentView addSubview:_img3];
                
                _content3 = content;
                _content3.text = @"合同";
                [self.contentView addSubview:_content3];
                
                _line3 = line;
                [self.contentView addSubview:_line3];
                break;
            }
            case 3:
            {
                _img4 = img;
                [self.contentView addSubview:_img4];
                
                _content4 = content;
                _content4.text = @"过户";
                [self.contentView addSubview:_content4];
                
                break;
            }
            default:
                break;
        }
    }
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(27 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        //        make.right.equalTo(_timeL.mas_left).offset(-22 *SIZE);
        make.width.equalTo(@(_titleL.mj_textWith + 5 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-86 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-50 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.left.equalTo(_titleL.mas_right).offset(22 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-86 *SIZE);
    }];
}

@end
