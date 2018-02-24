//
//  AppDelegate.m
//  HG_ Guidance_AD
//
//  Created by 胡志辉 on 2017/6/5.
//  Copyright © 2017年 胡志辉. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HG_Guidance_AD.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIViewController * emptyVC = [[UIViewController alloc]init];
    
    _window.rootViewController = emptyVC;
    HG_Guidance_AD * view = [[HG_Guidance_AD alloc] init];
    
    
    if (![kUserDefaults valueForKey:@"firstOpenApp"] || [[kUserDefaults valueForKey:@"firstOpenApp"] isEqual:@"false"]) {//判断是不是首次进入,true为不是首次进入，false或不存在是表示首次进入
//    [view hg_setGuidanceWithTextImgNameAry:@[@"guide_0_1",@"guide_1_1",@"guide_2_1"] imgNameAry:@[@"1",@"2",@"3"] secondImgAry:@[@"guide_3_2",@"guide_3_1",@"guide_3_3",@"guide_3_5",@"guide_3_4",@"guide_3_6"]];
    [view hg_setGuidance_AdWithTitleAry:@[@"优质服务，老人好帮手",@"精彩活动，老人齐欢乐",@"实时资讯，老人先知道"] desAry:@[@"家政保洁、物业修理、生活助理、医疗、陪同待办、服务高效、专业、便捷",@"家政保洁、物业修理、生活助理、医疗、陪同待办、服务高效、专业、便捷",@"家政保洁、物业修理、生活助理、医疗、陪同待办、服务高效、专业、便捷"] imageAry:@[@"1",@"2",@"3"]];
        
    __block HG_Guidance_AD * weakView = view;
    view.countDownTimeClick = ^(UIButton *sender) {
        [weakView removeFromSuperview];
        ViewController * VC = [[ViewController alloc] init];
        _window.rootViewController = VC;
    };
        [kUserDefaults setValue:@"true" forKey:@"firstOpenApp"];
        [kUserDefaults synchronize];
    }else{
        [kUserDefaults setValue:@"false" forKey:@"firstOpenApp"];
        [kUserDefaults synchronize];
        // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
        NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
        
        BOOL isExist = [self isFileExistWithFilePath:filePath];
        if (isExist) {// 图片存在,直接显示，否则会去服务器获取最新的url；不管是否存在，都应该获取服务器上最新的广告路劲，不同则取代掉本地的广告
            [view setHg_Guidance_ADWithImageUrl:filePath countDownTime:5];
            __block HG_Guidance_AD * weakView = view;
            view.countDownTimeClick = ^(UIButton *sender) {
                [weakView removeFromSuperview];
                ViewController * VC = [[ViewController alloc] init];
                _window.rootViewController = VC;
            };
        }else{
            [view removeFromSuperview];
            ViewController * VC = [[ViewController alloc] init];
            _window.rootViewController = VC;
        }
    
    }
    [self hg_getADimageUrl:nil];
    [emptyVC.view addSubview:view];
    
    [_window makeKeyAndVisible];
    return YES;
}
//获取广告页的内容，判断本地的广告是否和服务器的一致，不一致，则替换本地的广告，否则直接获取本地的广告
- (void)hg_getADimageUrl:(NSString *)imageUrl{
        
        // TODO 请求广告接口
        
        // 这里原本采用美团的广告接口，现在了一些固定的图片url代替
        NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
        NSString *imgUrl = imageArray[arc4random() % imageArray.count];
        
        // 获取图片名:43-130P5122Z60-50.jpg
        NSArray *stringArr = [imgUrl componentsSeparatedByString:@"/"];
        NSString *imageName = stringArr.lastObject;
        
        // 拼接沙盒路径
        NSString *filePath = [self getFilePathWithImageName:imageName];
        BOOL isExist = [self isFileExistWithFilePath:filePath];
        if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
            
            [self downloadAdImageWithUrl:imgUrl imageName:imageName];
            
        }
        
       
}

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            NSLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
