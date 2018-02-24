//
//  HG_GuidanceFirstView.m
//  HG_ Guidance_AD
//
//  Created by 胡志辉 on 2017/6/12.
//  Copyright © 2017年 胡志辉. All rights reserved.
//

#import "HG_GuidanceFirstView.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height



@implementation HG_GuidanceFirstView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
/**---------------------懒加载START--------------*/
/*标题label*/
- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 64,  WIDTH- 40, 20)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
/*描述label*/
- (UILabel *)desLabel
{
    if(!_desLabel){
        _desLabel =[[UILabel alloc] initWithFrame:CGRectMake(20, 114, WIDTH - 40, 20)];
        _desLabel.font = [UIFont systemFontOfSize:14.f];
        _desLabel.textColor = [UIColor colorWithRed:33/255 green:33/255 blue:33/255 alpha:1];
        _desLabel.textAlignment = NSTextAlignmentCenter;
        _desLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _desLabel.numberOfLines = 0;
    }
    return _desLabel;
}
/*图片imageView*/
- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
/*文字图片textImgView*/
- (UIImageView *)textImgView
{
    if(!_textImgView){
        _textImgView = [[UIImageView alloc] init];
    }
    return _textImgView;
}
/**---------------------懒加载END--------------*/
//传入的有文字标题和文字描述，和图片
- (void)hg_setGuidanceFirstViewWithTitle:(NSString *)title des:(NSString *)des imageName:(NSString *)imageName{
    [self addSubview:self.titleLabel];
    [self addSubview:self.desLabel];
    [self addSubview:self.imageView];
    
    self.titleLabel.text = title;
    self.desLabel.text = des;
    [self.desLabel sizeToFit];
    [self.desLabel setFrame:CGRectMake(20, 104, WIDTH - 40, self.desLabel.bounds.size.height)];
    CGFloat height = 104 + self.desLabel.bounds.size.height + 30;
    self.imageView.image = [UIImage imageNamed:imageName];
    self.imageView.frame = CGRectMake(60, height, WIDTH - 120, HEIGHT - height - 30);
}

//传入的是文字图片名称和图片名称
- (void)hg_setGuidanceFirstViewWithTextImageName:(NSString *)textImgName imageName:(NSString *)imageName{
    [self addSubview:self.textImgView];
    [self addSubview:self.imageView];
    
    [self.textImgView setFrame:CGRectMake(10, 64, WIDTH - 20, 100)];
    self.textImgView.image = [UIImage imageNamed:textImgName];
    
//    获取图片的宽高
    UIImage * img = [UIImage imageNamed:imageName];
    CGFloat imgW = img.size.width;
    CGFloat imgH = img.size.height;
//    根据图片空间的高度给图片设置宽度
    CGFloat imgViewH = HEIGHT - 184 - 30;
    CGFloat imgViewW = imgW * imgViewH / imgH;
    
    self.imageView.frame = CGRectMake((WIDTH - imgViewW)/2, 184, imgViewW, imgViewH);
    self.imageView.image = img;
}
//根据偏移量来设置动画
- (void)hg_setGuidanceFirstViewAnimationWithOffsetX:(CGFloat)offSetX guidanceType:(HG_GuidanceType)guidanceType{
    if (guidanceType == hg_GuidanceTypeFirstType) {
        self.textImgView.center = CGPointMake(WIDTH/2 * (1-offSetX * 3), self.textImgView.center.y);
        CGFloat scale = 1;
        if (offSetX > 0) {
            scale = 1-offSetX;
            self.textImgView.alpha =1-offSetX * 3.0;
            self.imageView.alpha = 1-offSetX;
        }else{
            scale = 1+ offSetX;
            self.textImgView.alpha = 1+offSetX * 3.0;
            self.imageView.alpha = 1+offSetX;
        }
        self.imageView.center = CGPointMake(WIDTH/2 * (1-offSetX), self.imageView.center.y);
    }else{
//    self.imageView.transform = CGAffineTransformMakeScale(scale, -scale);
    
        self.titleLabel.center = CGPointMake(WIDTH/2 * (1-offSetX * 1.5), self.titleLabel.center.y);
        self.desLabel.center = CGPointMake(WIDTH/2 * (1-offSetX * 3.0), self.desLabel.center.y);
        if (offSetX > 0) {
            self.titleLabel.alpha =1-offSetX * 1.5;
            self.desLabel.alpha = 1 - offSetX * 3.0;
            self.imageView.alpha = 1-offSetX;
        }else{
            self.titleLabel.alpha = 1+offSetX * 1.5;
            self.desLabel.alpha = 1 + offSetX * 3.0;
            self.imageView.alpha = 1+offSetX;
        }
        self.imageView.center = CGPointMake(WIDTH/2 * (1-offSetX), self.imageView.center.y);
    }
}

@end























