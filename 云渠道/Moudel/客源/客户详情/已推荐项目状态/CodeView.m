//
//  CodeView.m
//  云渠道
//
//  Created by 谷治墙 on 2019/9/12.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CodeView.h"

@implementation CodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionShareBtn:(UIButton *)btn{
    
    if (self.codeViewShareBlock) {
        
        self.codeViewShareBlock();
    }
    [self removeFromSuperview];
}

- (void)ActionSaveBtn:(UIButton *)btn{
    
    if (self.codeViewSaveBlock) {
        
        self.codeViewSaveBlock();
    }
    [self removeFromSuperview];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.alpha = 0.4;
    alphaView.backgroundColor = [UIColor blackColor];
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(30 *SIZE, 100 *SIZE, 300 *SIZE, 320 *SIZE)];
    _whiteView.backgroundColor = CLWhiteColor;
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self addSubview:_whiteView];
    
    _codeImg = [[UIImageView alloc] initWithFrame:CGRectMake(60 *SIZE, 40 *SIZE, 180 *SIZE, 180 *SIZE)];
    [_whiteView addSubview:_codeImg];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 240 *SIZE + i * 20 *SIZE, 280 *SIZE, 15 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        if (i == 0) {
            
            _customL = label;
            [_whiteView addSubview:_customL];
        }else if (i == 1){
            
            _recommendL = label;
            [_whiteView addSubview:_recommendL];
        }else{
            
            _projectL = label;
            [_whiteView addSubview:_projectL];
        }
    }
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.frame = CGRectMake(260 *SIZE, 20 *SIZE, 30 *SIZE, 30 *SIZE);
    [_saveBtn addTarget:self action:@selector(ActionSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_saveBtn setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [_whiteView addSubview:_saveBtn];
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtn.frame = CGRectMake(260 *SIZE, 60 *SIZE, 30 *SIZE, 30 *SIZE);
    [_shareBtn addTarget:self action:@selector(ActionShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [_whiteView addSubview:_shareBtn];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self removeFromSuperview];
}

- (void)setErWeiMaWithUrl:(NSString *)url AndView:(UIView *)View{
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜的默认属性
    [filter setDefaults];
    // 2、设置数据
    NSString *string_data = url;
    // 将字符串转换成 NSdata (虽然二维码本质上是字符串, 但是这里需要转换, 不转换就崩溃)
    NSData *qrImageData = [string_data dataUsingEncoding:NSUTF8StringEncoding];
    
    // 设置过滤器的输入值, KVC赋值
    [filter setValue:qrImageData forKey:@"inputMessage"];
    
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    // 图片小于(27,27),我们需要放大
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    // 4、将CIImage类型转成UIImage类型
    UIImage *start_image = [UIImage imageWithCIImage:outputImage];
    
    // - - - - - - - - - - - - - - - - 添加中间小图标 - - - - - - - - - - - - - - - -
    // 5、开启绘图, 获取图形上下文 (上下文的大小, 就是二维码的大小)
    UIGraphicsBeginImageContext(start_image.size);
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [start_image drawInRect:CGRectMake(0, 0, start_image.size.width, start_image.size.height)];
    // 再把小图片画上去
    NSString *icon_imageName = @"appi";
    UIImage *icon_image = [UIImage imageNamed:icon_imageName];
    CGFloat icon_imageW = 80 *SIZE;
    CGFloat icon_imageH = icon_imageW;
    CGFloat icon_imageX = (start_image.size.width - icon_imageW) * 0.5;
    CGFloat icon_imageY = (start_image.size.height - icon_imageH) * 0.5;
    [icon_image drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH)];
    // 6、获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    // 7、关闭图形上下文
    UIGraphicsEndImageContext();
    // 8、借助UIImageView显示二维码
    UIImageView *imageView = [[UIImageView alloc] init];
    CGFloat imageViewW = 110;
    CGFloat imageViewH = imageViewW;
    CGFloat imageViewX = 0;
    CGFloat imageViewY = 0;
    imageView.frame =CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    [View addSubview:imageView];
    // 9、将最终合得的图片显示在UIImageView上
    _codeImg.image = final_image;
}

- (void)creatQRCodeWith:(NSString *)urlString{
    
        // 1.实例化二维码滤镜
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
        // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
        [filter setDefaults];
    
        NSData *data  = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    
        // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
        [filter setValue:data forKey:@"inputMessage"];
    
        // 5.生成二维码
        CIImage *outputImage = filter.outputImage;
        CGFloat scale = _codeImg.frame.size.width/ CGRectGetWidth(outputImage.extent);
        CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale); // scale 为放大倍数
        CIImage *transformImage = [outputImage imageByApplyingTransform:transform];
    
        // 保存
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef imageRef = [context createCGImage:transformImage fromRect:transformImage.extent];
        UIImage *qrCodeImage = [UIImage imageWithCGImage:imageRef];
    
        // 6.设置生成好得二维码到imageView上
        _codeImg.image  = qrCodeImage;
}

@end
