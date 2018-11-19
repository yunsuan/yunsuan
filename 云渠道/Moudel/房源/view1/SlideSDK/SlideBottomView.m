//
//  SlideBottomView.m
//  SlideDemo
//
//  Created by 钟兴文 on 2017/5/16.
//  Copyright © 2017年 钟兴文. All rights reserved.
//

#import "SlideBottomView.h"
#import "RoomChildVC.h"
#import <UIKit/UIKit.h>

#define TitleScrollViewHeight   45.0   //标题栏的高度

#define LeftSpaceWidth   10.0   //左间隙
#define CenterSpaceWidth   10.0   //中间隙

#define MaxFontSize    18.0   //最大字体
#define MinFontSize    15.0   //最小字体

#define CurrentColorRed   0.10//0.75
#define CurrentColorGreen   0.60//0.22
#define CurrentColorBlue   1 //0.20

#define NormalColorRed    0.00
#define NormalColorGreen    0.00
#define NormalColorBlue    0.00

@interface SlideBottomView ()<UIScrollViewDelegate>
{
    NSMutableArray *_titleArr;//标题数组
    NSMutableArray *_controllerArr;//控制器数组
    
    //主要视图
    UIScrollView *_titleScrollView;//title视图
    UIScrollView *_controllerScrollView;//controller视图
}

@property (nonatomic,assign) NSInteger currentIndex;//选中分类，默认为0

@end

@implementation SlideBottomView

/**
 初始化对象

 @param frame frame
 @param titleArray 标题数组
 @param ctlArray ctl数组
 @return 对象
 */
-(instancetype)initWithFrame:(CGRect)frame WithTitleArray:(NSArray *)titleArray WithControllerArray:(NSArray *)ctlArray
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SetCity:) name:@"receiveCity" object:nil];
        //初始化视图
        self.currentIndex = 0;
        _titleArr = [[NSMutableArray alloc]initWithArray:titleArray];
        _controllerArr = [[NSMutableArray alloc]initWithArray:ctlArray];
        
        _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), TitleScrollViewHeight)];
        _titleScrollView.backgroundColor = [UIColor whiteColor];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.delegate = self;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, TitleScrollViewHeight, CGRectGetWidth(frame), 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0];
        [self addSubview:lineView];
        
        _controllerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), CGRectGetWidth(frame), CGRectGetHeight(frame)-CGRectGetMaxY(lineView.frame))];
        _controllerScrollView.showsHorizontalScrollIndicator = NO;
        _controllerScrollView.backgroundColor = [UIColor whiteColor];
        _controllerScrollView.pagingEnabled = YES;
        _controllerScrollView.delegate = self;
        
        [self addSubview:_titleScrollView];
        [self addSubview:_controllerScrollView];
        
        [self dealWithTitleArray];
    }
    
    return self;
}

- (void)SetCity:(NSNotification *)city{
    
    NSLog(@"%@",city);
    for (int i = 0; i < _controllerArr.count; i++) {
        
        RoomChildVC *ctl = _controllerArr[i];
        ctl.city = city.userInfo[@"city"];
        [ctl RequestMethod];
    }
}

/**
 根据标题数组获取标题label的frame
 */
-(void)dealWithTitleArray
{
    for (int i=0; i<_titleArr.count; i++) {
        
        //添加标题
        NSString *title = _titleArr[i];
        CGFloat titleWidth = [title boundingRectWithSize:CGSizeMake(100, TitleScrollViewHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12 *SIZE]} context:nil].size.width;
        
        if (i==0)
        {
            CGRect frame = CGRectMake(LeftSpaceWidth, 0, titleWidth+10, TitleScrollViewHeight);
            
            UILabel *label = [[UILabel alloc]initWithFrame:frame];
            label.tag = i+100;
            label.text = title;
            label.textColor = [UIColor colorWithRed:CurrentColorRed green:CurrentColorGreen blue:CurrentColorBlue alpha:1.0];
            label.font = [UIFont systemFontOfSize:12 *SIZE];
            label.userInteractionEnabled = YES;
            label.textAlignment = NSTextAlignmentCenter;
            [_titleScrollView addSubview:label];
            
            label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
            
            UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedAction:)];
            [label addGestureRecognizer:ges];
        }
        else
        {
            UILabel *preLabel = [_titleScrollView viewWithTag:100+i-1];
            
            CGRect frame = CGRectMake(CGRectGetMaxX(preLabel.frame)+CenterSpaceWidth, 0, titleWidth+10, TitleScrollViewHeight);
            
            UILabel *label = [[UILabel alloc]initWithFrame:frame];
            label.tag = i+100;
            label.text = title;
            label.textColor = [UIColor colorWithRed:NormalColorRed green:NormalColorGreen blue:NormalColorBlue alpha:1.0];
            label.font = [UIFont systemFontOfSize:12 *SIZE];
            label.userInteractionEnabled = YES;
            label.textAlignment = NSTextAlignmentCenter;
            [_titleScrollView addSubview:label];
            
            UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedAction:)];
            [label addGestureRecognizer:ges];
        }
        
        if (i==_titleArr.count-1)//设置_titleScrollView的size
        {
            UILabel *lastLabel = [_titleScrollView viewWithTag:100+i];
            
            _titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame)+10, TitleScrollViewHeight);
            _controllerScrollView.contentSize = CGSizeMake(CGRectGetWidth(_controllerScrollView.frame)*_titleArr.count, CGRectGetHeight(_controllerScrollView.frame));
        }
        
        //添加内容
        RoomChildVC *ctl = _controllerArr[i];
        ctl.view.frame = CGRectMake(_controllerScrollView.frame.size.width*i, 0, _controllerScrollView.frame.size.width, CGRectGetHeight(_controllerScrollView.frame));
        
        if (i==0) {
            
//            [ctl initDataAndView];
        }
    
        [_controllerScrollView addSubview:ctl.view];
    }
}

/**
 分类选择事件,并滑动到指定分类

 @param ges 点击响应者
 */
-(void)selectedAction:(UIGestureRecognizer*)ges
{
    NSInteger tag = ges.view.tag;
    
    //判断是否已选中情况下点击
    if (tag-100 == self.currentIndex) {
        
        //判断代理和实现方法
        if (self.delegate != nil&&[self.delegate respondsToSelector:@selector(clickSelectedController:withIndex:)]) {
            [self.delegate clickSelectedController:_controllerArr[self.currentIndex] withIndex:self.currentIndex];
        }
        
        return;
    }
    
    //当前选中
    UILabel *currentLabel = [_titleScrollView viewWithTag:100+_currentIndex];
    
    //判断左右滑
    UILabel *nextLabel = [_titleScrollView viewWithTag:tag];
    
    [UIView animateWithDuration:.2 animations:^{
        
        currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        nextLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        
        //改变字体颜色
        currentLabel.textColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        
        nextLabel.textColor = [UIColor colorWithRed:CurrentColorRed green:CurrentColorGreen blue:CurrentColorBlue alpha:1.0];
    }];
    
    self.currentIndex = tag-100;
    
    [self goToCenter];
    
    [_controllerScrollView setContentOffset:CGPointMake(self.frame.size.width*(tag-100), 0) animated:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark- scrollviewdelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //根据滑动的效果实现头部标题栏的效果（标题文字效果）
    if (scrollView == _controllerScrollView) {
        
        self.currentIndex = (NSInteger)scrollView.contentOffset.x/scrollView.frame.size.width;
        
        UILabel *currentLabel = [_titleScrollView viewWithTag:100+_currentIndex];
        
        //判断左右滑
        UILabel *nextLabel = [_titleScrollView viewWithTag:scrollView.contentOffset.x>scrollView.frame.size.width*_currentIndex   ? 100+_currentIndex+1:100+_currentIndex-1];
        
        if (nextLabel != nil) {
            
            NSInteger index_i = nextLabel.tag-currentLabel.tag;
            CGFloat rate_i = (scrollView.contentOffset.x - scrollView.frame.size.width*_currentIndex)/scrollView.frame.size.width;
            
            //改变字体大小（通过改变字体大小会有锯齿的跳动感，效果不好）
//            currentLabel.font = [UIFont systemFontOfSize:index_i * (MinFontSize-MaxFontSize) * rate_i + MaxFontSize];
//            
//            nextLabel.font = [UIFont systemFontOfSize:index_i * (MaxFontSize-MinFontSize) * rate_i + MinFontSize];
            
            //通过拉伸label的x/y值来实现字体变大变小的即视效果
            currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,index_i * -0.2 * rate_i + 1.2,index_i * -0.2 * rate_i + 1.2);
            nextLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, index_i * 0.2 * rate_i + 1.0, index_i * 0.2 * rate_i + 1.0);
            
            //改变字体颜色
            currentLabel.textColor = [UIColor colorWithRed:(index_i * (NormalColorRed-CurrentColorRed) * rate_i + CurrentColorRed) green:(index_i * (NormalColorGreen-CurrentColorGreen) * rate_i + CurrentColorGreen) blue:(index_i * (NormalColorBlue-CurrentColorBlue) * rate_i + CurrentColorBlue) alpha:1.0];
            
            nextLabel.textColor = [UIColor colorWithRed:(index_i * (CurrentColorRed-NormalColorRed) * rate_i + NormalColorRed) green:(index_i * (CurrentColorGreen-NormalColorGreen) * rate_i + NormalColorGreen) blue:(index_i * (CurrentColorBlue-NormalColorBlue) * rate_i + NormalColorBlue) alpha:1.0];
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _controllerScrollView) {
        self.currentIndex = (NSInteger)scrollView.contentOffset.x/scrollView.frame.size.width;
    }
}

/**
 将选中的分类移到视图中央
 */
-(void)goToCenter
{
    UILabel *currentLabel = [_titleScrollView viewWithTag:100+_currentIndex];
    
    CGPoint point = currentLabel.center;
    
    if (point.x>_titleScrollView.center.x && _titleScrollView.contentSize.width-point.x>_titleScrollView.center.x)
    {
        [_titleScrollView setContentOffset:CGPointMake(point.x-_titleScrollView.center.x, 0) animated:YES];
    }
    else if (point.x>_titleScrollView.center.x && _titleScrollView.contentSize.width-point.x<_titleScrollView.center.x)
    {
        [_titleScrollView setContentOffset:CGPointMake(_titleScrollView.contentSize.width-_titleScrollView.frame.size.width, 0) animated:YES];
    }
    else if (point.x<_titleScrollView.center.x && _titleScrollView.contentSize.width-point.x>_titleScrollView.center.x)
    {
        [_titleScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

#pragma mark- 重写setting
-(void)setCurrentIndex:(NSInteger)currentIndex
{
    if (_currentIndex != currentIndex) {
        
        //代理方法已实现
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(slideViewWillDisappearWithController:withIndex:)])
        {
            [self.delegate slideViewWillDisappearWithController:_controllerArr[_currentIndex] withIndex:_currentIndex];
        }
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(slideViewWillAppearWithController:withIndex:)]) {
            [self.delegate slideViewWillAppearWithController:_controllerArr[currentIndex] withIndex:currentIndex];
        }
        
        _currentIndex = currentIndex;
        [self goToCenter];
    }
}

@end
