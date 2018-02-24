//
//  HG_Guidance_AD.h
//  HG_ Guidance_AD
//
//  Created by 胡志辉 on 2017/6/5.
//  Copyright © 2017年 胡志辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HG_GuidanceFirstView.h"
#import "HG_GuidanceSecondView.h"

#define kUserDefaults [NSUserDefaults standardUserDefaults]
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";


typedef void(^hg_countDownTimeClick)(UIButton *sender);

typedef enum HG_Guidance_AD{//这个状态是判断是需要引导页还是广告页
  HG_Guidance_ADGuidance = 0,
  HG_Guidance_ADAd
}HG_Guidance_ADtype;



@interface HG_Guidance_AD : UIView
/*根据传入的类型来判断*/
@property (nonatomic,assign) HG_Guidance_ADtype typeName;
/*用来显示的引导页图片或者广告页的图片，如果广告页HG_Guidance_ADAd的话，只会取第一张*/
@property (nonatomic,strong) NSArray *imageAry;
/*倒计时时间，多久之后广告关闭或者引导页滑到最后时多少时间关闭*/
@property (nonatomic , assign) NSInteger countDownTime;
/*判断是不是在最后一张用到不同样式的引导页*/
@property (nonatomic , assign) BOOL isGuidanceFirstType;

/*
 下面的参数是对于倒计时跳过按钮的个性化设置
 */
//进度条走过的颜色，不设置的默认grayColor
@property (nonatomic,strong)UIColor    *trackColor;

//进度条的颜色，不设置的话，默认orangeColor
@property (nonatomic,strong)UIColor    *progressColor;

//按钮的内部填充色，默认黑色
@property (nonatomic,strong)UIColor    *fillColor;

//进度条的宽度，默认2
@property (nonatomic,assign)CGFloat    lineWidth;

//倒计时按钮显示的文字，默认‘跳过’
@property (nonatomic , strong)NSString *circleProgressBtnTitle;

/*注释*/
@property (nonatomic , copy) hg_countDownTimeClick countDownTimeClick;


- (void)hg_setGuidance_AdWithTitleAry:(NSArray *)titleAry desAry:(NSArray *)desAry imageAry:(NSArray *)imgAry;
/*
 设置引导页方法，常用的引导页方法
 参数说明：
 titleAry:标题数组
 desAry:描述数组
 imgAry:图片名称数组
 */


-(void)hg_setGuidanceWithTextImgNameAry:(NSArray *)textImgName imgNameAry:(NSArray *)imgNameAry secondImgAry:(NSArray *)secondImgAry;
/*
 根据文字图片名称和图片名称数据设置引导页的方法,这个方法属于自己项目中要和安卓统一，所以加的方法
 textImgAry:文字图片名称数组
 imgAry:图片名称数组
 */


- (void)setHg_Guidance_ADWithImageUrl:(NSString *)filePath countDownTime:(NSInteger)countDownTime;
/*
 动态获取广告页方法，即先请求网络来获取服务器广告页是否变更，是的话就会去获取新的广告页，否则会去本地获取缓存的广告图片
 参数说明：
 imageUrl:你获取到的图片地址
 */
@end
