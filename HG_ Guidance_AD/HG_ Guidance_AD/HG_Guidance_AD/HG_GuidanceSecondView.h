//
//  HG_GuidanceSecondView.h
//  HG_ Guidance_AD
//
//  Created by 胡志辉 on 2017/6/12.
//  Copyright © 2017年 胡志辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HG_GuidanceSecondView : UIView
/*我是老人头像image*/
@property (nonatomic,strong) UIImageView *firstImageView;
/*我是老人image*/
@property (nonatomic,strong) UIImageView *sencodImageView;
/*我是老人描述image*/
@property (nonatomic,strong) UIImageView *thirdImageView;
/*我是家属头像image*/
@property (nonatomic,strong) UIImageView *forthImageView;
/*我是家属image*/
@property (nonatomic,strong) UIImageView *fifthImageView;
/*我是家属描述image*/
@property (nonatomic,strong) UIImageView *sixthImgaeView;

- (void)hg_setGuidanceSecondViewWithImageAry:(NSArray *)imageAry;
/*
 根据传入的imgAry里的图片对象名称来赋值
 imageAry：传入的图片名称数组
 */

- (void)hg_setGuidanceSecondViewWithOffsetX:(CGFloat)offsetX;
/*
 根据传入的offsetX来给View上的控件加入动画
 参数说明：
 offsetX:相对于当前处在的界面的偏移量，比如，处在的scrollerView的偏移量为屏幕宽度的时候，此时offset 为0.是相对的偏移量，不是绝对的
 */
@end
