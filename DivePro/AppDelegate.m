//
//  AppDelegate.m
//  DivePro
//
//  Created by Jon Kotowski on 12/5/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
UITabBarController *UITB;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"c4ET37KgIktLydWepkY4OVFk5pj1VGVHMojMtVAR"
                  clientKey:@"gh8N7HQviE5fZqQgertHZYuHayvXqDfQJnEGVu3K"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [GMSServices provideAPIKey:@"AIzaSyBHw_TyGKh9dqUsBOMnCsBOSuw2YGnWmXc"];
    
    UITB = [[UITabBarController alloc] init];NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowBlurRadius = 0.0;
    
    // Initialize Parse.
    shadow.shadowOffset = CGSizeMake(0.0, 0.0);
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName : [UIColor blackColor],
                                                            NSFontAttributeName : [UIFont fontWithName:@"EuphemiaUCAS" size:0.0f],
                                                            NSShadowAttributeName : shadow
                                                            }];
    return YES;
}

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
