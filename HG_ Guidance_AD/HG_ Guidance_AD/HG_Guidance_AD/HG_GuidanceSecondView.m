//
//  HG_GuidanceSecondView.m
//  HG_ Guidance_AD
//
//  Created by 胡志辉 on 2017/6/12.
//  Copyright © 2017年 胡志辉. All rights reserved.
//

#import "HG_GuidanceSecondView.h"
#define WIDTH self.frame.size.width

@interface HG_GuidanceSecondView ()
{
    CGFloat scaleWidth;//宽度比例
    CGFloat scaleHeight;//高度比例
}
@end


@implementation HG_GuidanceSecondView


- (instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    if (self) {
        scaleWidth = 1;
        scaleHeight = 1;
        [self addSubview:self.firstImageView];
        [self addSubview:self.sencodImageView];
        [self addSubview:self.thirdImageView];
        [self addSubview:self.forthImageView];
        [self addSubview:self.fifthImageView];
        [self addSubview:self.sixthImgaeView];
    }
    return  self;
}
/*---------------懒加载START---------------*/
/*我是老人头像iamge*/
- (UIImageView *)firstImageView
{
    if(!_firstImageView){
        _firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH - 108 * scaleWidth)/2, 102 * scaleHeight, 108 * scaleWidth, 108 * scaleHeight)];
        
    }
    return _firstImageView;
}
/*我是老人image*/
- (UIImageView *)sencodImageView
{
    if(!_sencodImageView){
        _sencodImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH - 270 * scaleWidth)/2,64 * scaleHeight, 270 * scaleWidth, 30 * scaleHeight)];
    }
    return _sencodImageView;
}
/*我是老人描述image*/
- (UIImageView *)thirdImageView
{
    if(!_thirdImageView){
        _thirdImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH - 225 * scaleWidth)/2, 220 * scaleHeight, 225 * scaleWidth, 20 * scaleHeight)];
    }
    return _thirdImageView;
}
/*我是家属头像image*/
- (UIImageView *)forthImageView
{
    if(!_forthImageView){
        _forthImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH - 108 * scaleWidth)/2, 308 * scaleHeight, 108 * scaleWidth, 108 * scaleWidth)];
    }
    return _forthImageView;
}
/*我是家属image*/
- (UIImageView *)fifthImageView
{
    if(!_fifthImageView){
        _fifthImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH - 270 * scaleWidth)/2, 280 * scaleHeight, 270 * scaleWidth, 30 * scaleHeight)];
    }
    return _fifthImageView;
}

/*我是家属描述image*/
- (UIImageView *)sixthImgaeView
{
    if(!_sixthImgaeView){
        _sixthImgaeView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH - 225 * scaleWidth)/2, 416 * scaleHeight, 225 * scaleWidth, 40 * scaleHeight)];
    }
    return _sixthImgaeView;
}
/*---------------懒加载END---------------*/

- (void)hg_setGuidanceSecondViewWithImageAry:(NSArray *)imageAry{
    for (int i = 0; i < imageAry.count; i ++) {
        if (i == 0) {
            _firstImageView.image = [UIImage imageNamed:[imageAry objectAtIndex:i]];
        }
        if (i == 1) {
            _sencodImageView.image = [UIImage imageNamed:[imageAry objectAtIndex:i]];
        }
        if (i == 2) {
            _thirdImageView.image = [UIImage imageNamed:[imageAry objectAtIndex:i]];
        }
        if (i == 3) {
            _forthImageView.image = [UIImage imageNamed:[imageAry objectAtIndex:i]];
        }
        if (i == 4) {
            _fifthImageView.image = [UIImage imageNamed:[imageAry objectAtIndex:i]];
        }
        if (i == 5) {
            _sixthImgaeView.image = [UIImage imageNamed:[imageAry objectAtIndex:i]];
        }
    }
}

//根据传入的offsetX来给View加动画
- (void)hg_setGuidanceSecondViewWithOffsetX:(CGFloat)offsetX{
    if (offsetX == -1) {
        offsetX = 0;
    }
    _firstImageView.center = CGPointMake(WIDTH/2 * (1-offsetX ), _firstImageView.center.y);
    _sencodImageView.center = CGPointMake(WIDTH/2 * (1-offsetX * 1.5), _sencodImageView.center.y);
    _thirdImageView.center = CGPointMake(WIDTH/2 * (1-offsetX * 3.0), _thirdImageView.center.y);
    _forthImageView.center = CGPointMake(WIDTH/2 * (1-offsetX), _forthImageView.center.y);
    _fifthImageView.center = CGPointMake(WIDTH/2 * (1-offsetX * 1.5), _fifthImageView.center.y);
    _sixthImgaeView.center = CGPointMake(WIDTH/2 * (1-offsetX * 3.0), _sixthImgaeView.center.y);
    
    _firstImageView.alpha = 1+offsetX;
    _sencodImageView.alpha = 1+offsetX * 1.5;
    _thirdImageView.alpha = 1+offsetX * 3.0;
    _forthImageView.alpha = 1+offsetX;
    _fifthImageView.alpha = 1+offsetX * 1.5;
    _sixthImgaeView.alpha = 1+offsetX * 3.0;
}

@end
