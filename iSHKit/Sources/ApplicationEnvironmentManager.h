//
//  ApplicationEnvironmentManager.h
//  iSH
//
//  Created by Terrance Wood on 3/13/24.
//

#ifndef ApplicationEnvironmentManager_h
#define ApplicationEnvironmentManager_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface ApplicationEnvironmentManager : NSObject

// From iSH App's AppDelegate
- (void)exitApp;

@property BOOL exiting;
@property SCNetworkReachabilityRef reachability;

+ (int)boot;
+ (int)bootError;

// iSHKit
+ (void)setupApplicationEnvironment;
static void NetworkReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info);
+ (void)configureDns;
+ (void)maybePresentStartupMessageOnViewController:(UIViewController *)vc;
+ (BOOL)handleWillFinishLaunchWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions;
+ (BOOL)handleDidFinishLaunchWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions;
+ (void)handleDiscardedSceneSessions:(NSSet<UISceneSession *> *)sceneSessions API_AVAILABLE(ios(13.0));
+ (void)configureNetworkReachability;

+ (void)cleanupSharedResources;

@end

#endif /* ApplicationEnvironmentManager_h */

/*
 // AppDelegate.m
 #import "AppDelegate.h"
 #import "ApplicationEnvironmentManager.h"

 @implementation AppDelegate

 - (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
     // Setup application environment through the new class
     [ApplicationEnvironmentManager setupApplicationEnvironment];
     return YES;
 }

 @end

 */
