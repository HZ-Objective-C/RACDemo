//
//  AppDelegate.m
//  RACDemo
//
//  Created by Harious on 2018/1/9.
//  Copyright © 2018年 zzh. All rights reserved.
//

#import "AppDelegate.h"
#import "RACTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[RACTableViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    return YES;
}




@end
