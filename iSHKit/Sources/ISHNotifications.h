//
//  ISHNotifications.h
//  iSH
//
//  Created by Terrance Wood on 3/12/24.
//

#ifndef ISHNotifications_h
#define ISHNotifications_h

#if !ISH_LINUX
extern NSString *const ProcessExitedNotification;
#else
extern NSString *const KernelPanicNotification;
#endif

#endif /* ISHNotifications_h */
