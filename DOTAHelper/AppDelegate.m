//
//  AppDelegate.m
//  DOTAHelper
//
//  Created by 千锋 on 16/1/9.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "AppDelegate.h"
#import "NewfeatureViewController.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Bmob registerWithAppKey:@"ede030aea79ce4fccbae29ea0549fe6d"];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSDictionary * infoDict = [NSBundle mainBundle].infoDictionary;
    NSString * currentVersion = infoDict[@"CFBundleShortVersionString"];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * lastVersion = [userDefaults objectForKey:@"LastVersion"];
    
    
    if ([currentVersion compare:lastVersion] == NSOrderedDescending) {
        [userDefaults setObject:currentVersion forKey:@"LastVersion"];
        
        [userDefaults synchronize];
        
        NewfeatureViewController * nfVC = [[NewfeatureViewController alloc]init];
       self.window.rootViewController = nfVC;
    }
    else
    {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MainViewController * VC = [sb instantiateViewControllerWithIdentifier:@"MainViewController"];
        self.window.rootViewController = VC;
    }
    

    [self.window makeKeyAndVisible];
//    [self setupShareSDK];
    return YES;
}

//-(void)setupShareSDK
//{
//    [ShareSDK registerApp:AppKey_ShareSDK activePlatforms:@[@(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
//        //导入分享平台
//        switch (platformType) {
//            case SSDKPlatformTypeSinaWeibo:
//                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                break;
//                
//            default:
//                break;
//        }
//    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//        //配置平台
//        switch (platformType) {
//            case SSDKPlatformTypeSinaWeibo:
//                [appInfo SSDKSetupSinaWeiboByAppKey:AppKey_Weibo appSecret:App_Secret_Weibo redirectUri:nil authType:SSDKAuthTypeBoth];
//                break;
//                
//            default:
//                break;
//        }
//    }];
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
