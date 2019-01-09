//
//  RecommendWaitCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/9.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "RecommendWaitCell.h"

@implementation RecommendWaitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _codeL = [[UILabel alloc] init];
    _codeL.textColor = YJTitleLabColor;
    _codeL.font = [UIFont systemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_codeL];
    
    _nameL = [[UILabel alloc] init];
    _nameL.textColor = YJ86Color;
    _nameL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _phoneL = [[UILabel alloc] init];
    _phoneL.textColor = YJ86Color;
    _phoneL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_phoneL];
    
    _levelL = [[UILabel alloc] init];
    _levelL.textColor = YJ86Color;
    _levelL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_levelL];
    
    _demandL = [[UILabel alloc] init];
    _demandL.textColor = YJ86Color;
    _demandL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_demandL];
    
    _progressL = [[UILabel alloc] init];
    _progressL.textColor = YJ86Color;
    _progressL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_progressL];
    
    _numL = [[UILabel alloc] init];
    _numL.textColor = YJ86Color;
    _numL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_numL];
    
    _matchL = [[UILabel alloc] init];
    _matchL.textColor = YJ86Color;
    _matchL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_matchL];
}

@end
