//
//  AppDelegate.h
//  iSH
//
//  Created by Theodore Dubois on 10/17/17.
//

#ifndef ISH_LIBISHSHARED

#import <UIKit/UIKit.h>
#import <iSHKit/ISHApplicationDelegate.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, ISHApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)exitApp;

#if !ISH_LINUX
+ (int)bootError;
#endif

+ (void)maybePresentStartupMessageOnViewController:(UIViewController *)vc;

@end

#if !ISH_LINUX
extern NSString *const ProcessExitedNotification;
#else
extern NSString *const KernelPanicNotification;
#endif

#endif
