//
//  ISHNotifications.m
//  iSHKit
//
//  Created by Terrance Wood on 3/12/24.
//

#import <Foundation/Foundation.h>
#import "ISHNotifications.h"

#if !ISH_LINUX
NSString *const ProcessExitedNotification = @"ProcessExitedNotification";
#else
NSString *const KernelPanicNotification = @"KernelPanicNotification";
#endif
