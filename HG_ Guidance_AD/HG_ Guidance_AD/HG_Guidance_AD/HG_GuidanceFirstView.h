//
//  HG_GuidanceFirstView.h
//  HG_ Guidance_AD
//
//  Created by 胡志辉 on 2017/6/12.
//  Copyright © 2017年 胡志辉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum hg_Guidance{//这个状态是说明是否会用到第二类型形式的引导页，这个状态一般用不到
    hg_GuidanceTypeDefault = 0,//默认的样式
    hg_GuidanceTypeFirstType//其他格式
}HG_GuidanceType;


@interface HG_GuidanceFirstView : UIView
/*标题label*/
@property (nonatomic,strong) UILabel *titleLabel;
/*描述label*/
@property (nonatomic,strong) UILabel *desLabel;
/*图片imageView*/
@property (nonatomic,strong) UIImageView *imageView;
/*文字图片视图*/
@property (nonatomic,strong) UIImageView *textImgView;
/*注释*/
@property (nonatomic , assign) HG_GuidanceType guidanceType;

- (void)hg_setGuidanceFirstViewWithTitle:(NSString *)title des:(NSString *)des imageName:(NSString *)imageName;
/*
 **根据传入的数组类型来判断是数字还是图片，数组对象如果是类似于'first.png/first.jpg'的字符串则表示图片，否则表示的是文字
 title:传入的标题
 des:描述
 imageName:图片名称
 */

-(void)hg_setGuidanceFirstViewWithTextImageName:(NSString *)textImgName imageName:(NSString *)imageName;
/*
 这个方法是将文字截图后，制作成图片，然后以图片的格式显示文字
 textImgName:文字图片的名称
 iamgeName:图片的名称
 */

- (void)hg_setGuidanceFirstViewAnimationWithOffsetX:(CGFloat)offSetX guidanceType:(HG_GuidanceType)guidanceType;
/*
 根据滑动的相对偏移量来设置动画
 offsetX:相对偏移量，如：当前的HG_GuidanceFirstView在scrollView的第二页，此时不滑动状态下，offsetX = 0;此处的偏移量计算为 scrollerView.contentOffset.x / 屏幕宽度 - 1;计算的是一个小于1的小数
 guidanceType：广告页类型，（0：表示常用的，1表示文字显示是以图片显示）
 */

@end
