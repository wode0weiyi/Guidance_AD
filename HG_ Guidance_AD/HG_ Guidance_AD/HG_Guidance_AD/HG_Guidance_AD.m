//
//  HG_Guidance_AD.m
//  HG_ Guidance_AD
//
//  Created by 胡志辉 on 2017/6/5.
//  Copyright © 2017年 胡志辉. All rights reserved.
//

#import "HG_Guidance_AD.h"
#import "DrawCircleProgressButton.h"

#define DEVICE_WIDTH  [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface HG_Guidance_AD ()<UIScrollViewDelegate>
{
//    判断是否用到了第二类的引导页样式
}
@property (nonatomic , strong)UIPageControl * pageControl;
@property (nonatomic , strong)UIScrollView * scrollerView;
@end

@implementation HG_Guidance_AD

- (instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
    }
    return self;
}


/*注释*/
- (UIPageControl *)pageControl
{
    if(!_pageControl){
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}

/*注释*/
- (UIScrollView *)scrollerView
{
    if(!_scrollerView){
        _scrollerView = [[UIScrollView alloc] initWithFrame:self.frame];
    }
    return _scrollerView;
}
/*引导页的实现方法1,此方法是传入titleAry desAry imageAry的数据方法，这个方法是常用的方法*/
- (void)hg_setGuidance_AdWithTitleAry:(NSArray *)titleAry desAry:(NSArray *)desAry imageAry:(NSArray *)imgAry{
//scrollerView的初始化
    self.scrollerView = [[UIScrollView alloc] initWithFrame:self.frame];
    self.scrollerView.contentSize = CGSizeMake(DEVICE_WIDTH * imgAry.count, DEVICE_HEIGHT);
    self.scrollerView.delegate = self;
    self.scrollerView.pagingEnabled = YES;
    self.scrollerView.bounces = NO;
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollerView];
    
//    clickBtn的初始化
    UIButton * clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBtn.frame = CGRectMake(30, DEVICE_HEIGHT - 70, DEVICE_WIDTH - 60, 40);
    clickBtn.backgroundColor = [UIColor orangeColor];
    [clickBtn setTitle:@"点击进入" forState:UIControlStateNormal];
    [clickBtn addTarget:self action:@selector(hg_removeGuidance:) forControlEvents:UIControlEventTouchUpInside];
    
//  根据数组的不同。添加控件
#pragma mark 这里要确保titleAry desAry imgAry的对象个数一致
    for (int i = 0; i < imgAry.count; i ++) {
        HG_GuidanceFirstView * view = [[HG_GuidanceFirstView alloc] initWithFrame:CGRectMake(0 + DEVICE_WIDTH * i, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        [view hg_setGuidanceFirstViewWithTitle:[titleAry objectAtIndex:i] des:[desAry objectAtIndex:i] imageName:[imgAry objectAtIndex:i]];
        view.userInteractionEnabled = NO;
        view.guidanceType = hg_GuidanceTypeDefault;
        view.tag = 100 + i;
        if (i == imgAry.count - 1) {
            [view addSubview:clickBtn];
        }
        [self.scrollerView addSubview:view];
        
    }
//    pageControl的初始化
    self.pageControl.center = CGPointMake(DEVICE_WIDTH / 2, DEVICE_HEIGHT - 40 + 20);
    self.pageControl.numberOfPages = imgAry.count;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self addSubview:self.pageControl];

}

/*
 根据文字图片名称和图片名称数据设置引导页的方法
 textImgAry:文字图片名称数组
 imgAry:图片名称数组
 secondImgAry:类型为hg_GuidanceTypeFirstType的时候图片名称数组，一般用在最后一页
 */
-(void)hg_setGuidanceWithTextImgNameAry:(NSArray *)textImgName imgNameAry:(NSArray *)imgNameAry secondImgAry:(NSArray *)secondImgAry{
    self.scrollerView = [[UIScrollView alloc] initWithFrame:self.frame];
    self.scrollerView.contentSize = CGSizeMake(DEVICE_WIDTH * (imgNameAry.count + 1), DEVICE_HEIGHT);
    self.scrollerView.delegate = self;
    self.scrollerView.pagingEnabled = YES;
    self.scrollerView.bounces = NO;
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollerView];
    
    //    clickBtn的初始化
    UIButton * clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBtn.frame = CGRectMake(50, DEVICE_HEIGHT - 70, DEVICE_WIDTH - 100, 40);
    clickBtn.backgroundColor = [UIColor blackColor];
    clickBtn.alpha = 0.09;
    clickBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    clickBtn.layer.borderWidth = 1;
    clickBtn.layer.cornerRadius = 20;
    clickBtn.layer.masksToBounds = YES;
    [clickBtn setTitle:@"点击进入" forState:UIControlStateNormal];
    [clickBtn addTarget:self action:@selector(hg_removeGuidance:) forControlEvents:UIControlEventTouchUpInside];
    
    //    根据传入的数组进行赋值
    for (int i = 0; i < imgNameAry.count;  i ++) {
        HG_GuidanceFirstView * view = [[HG_GuidanceFirstView alloc] initWithFrame:CGRectMake(0 + DEVICE_WIDTH * i, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        view.tag = 100 + i;
        view.guidanceType = hg_GuidanceTypeFirstType;
        [view hg_setGuidanceFirstViewWithTextImageName:[textImgName objectAtIndex:i] imageName:[imgNameAry objectAtIndex:i]];
        [self.scrollerView addSubview:view];
    }
    if (secondImgAry.count > 0) {
        HG_GuidanceSecondView * view = [[HG_GuidanceSecondView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH * imgNameAry.count, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        self.isGuidanceFirstType = YES;
        view.tag = 200;
        [view hg_setGuidanceSecondViewWithImageAry:secondImgAry];
        [view addSubview:clickBtn];
        [self.scrollerView addSubview:view];
    }
    
    //    pageControl的初始化
    self.pageControl.center = CGPointMake(DEVICE_WIDTH / 2, DEVICE_HEIGHT - 40 + 20);
    self.pageControl.numberOfPages = imgNameAry.count + 1;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self addSubview:self.pageControl];
}


/*
 动态获取广告页方法，即先请求网络来获取服务器广告页是否变更，是的话就会去获取新的广告页，否则会去本地获取缓存的广告图片
 参数说明：
 imageUrl:你获取到的图片地址
 countDownTime:广告显示多久后关闭
 */
- (void)setHg_Guidance_ADWithImageUrl:(NSString *)filePath countDownTime:(NSInteger)countDownTime{
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.frame];
            imageView.image = [UIImage imageWithContentsOfFile:filePath];
            [self addSubview:imageView];
            DrawCircleProgressButton *drawCircleView = [[DrawCircleProgressButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 55, 30, 40, 40)];
            drawCircleView.lineWidth = self.lineWidth?self.lineWidth:2.0;
            drawCircleView.trackColor = self.trackColor?self.trackColor:[UIColor redColor];
            drawCircleView.progressColor = self.progressColor?self.progressColor:[UIColor grayColor];
            
            [drawCircleView setTitle:self.circleProgressBtnTitle?self.circleProgressBtnTitle:@"跳过" forState:UIControlStateNormal];
            [drawCircleView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            drawCircleView.titleLabel.font = [UIFont systemFontOfSize:14];
            
            [drawCircleView addTarget:self action:@selector(removeProgress:) forControlEvents:UIControlEventTouchUpInside];
            
            /**
             *  progress 完成时候的回调
             */
            __block HG_Guidance_AD * weakSelf = self;
            [drawCircleView startAnimationDuration:countDownTime withBlock:^{
                [weakSelf removeProgress:nil];
            }];
            
            [imageView addSubview:drawCircleView];
    
}

#pragma mark - uiscrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat index = scrollView.contentOffset.x/DEVICE_WIDTH;
    self.pageControl.currentPage = (int)index;
    CGFloat offsetX = 0;
    int x = (int)index;
    offsetX = index - (CGFloat)x;
    NSLog(@"offsetX = %f",offsetX);
    HG_GuidanceFirstView * view = (HG_GuidanceFirstView *)[self.scrollerView viewWithTag:100 + x];
    if (view.guidanceType == hg_GuidanceTypeDefault) {
        [view hg_setGuidanceFirstViewAnimationWithOffsetX:offsetX guidanceType:hg_GuidanceTypeDefault];
    }else{
        [view hg_setGuidanceFirstViewAnimationWithOffsetX:offsetX guidanceType:hg_GuidanceTypeFirstType];
    }
    
    HG_GuidanceFirstView * nextView = (HG_GuidanceFirstView *)[self.scrollerView viewWithTag:100 + x + 1];
    if (nextView.guidanceType == hg_GuidanceTypeDefault) {
        [nextView hg_setGuidanceFirstViewAnimationWithOffsetX:-(1-offsetX) guidanceType:hg_GuidanceTypeDefault];
    }else{
        [nextView hg_setGuidanceFirstViewAnimationWithOffsetX:-(1-offsetX) guidanceType:hg_GuidanceTypeFirstType];
    }
    
    if (self.isGuidanceFirstType) {
        HG_GuidanceSecondView * view = (HG_GuidanceSecondView *)[self.scrollerView viewWithTag:200];
        [view hg_setGuidanceSecondViewWithOffsetX:-(1-offsetX)];
    }
    
}

#pragma mark - 跳过按钮或者点击进入按钮响应方法
- (void)hg_removeGuidance:(UIButton *)sender{
    if (self.countDownTimeClick) {
        self.countDownTimeClick(sender);
    }
}

-(void)removeProgress:(UIButton *)sender{
    if (self.countDownTimeClick) {
        self.countDownTimeClick(sender);
    }
}

@end
