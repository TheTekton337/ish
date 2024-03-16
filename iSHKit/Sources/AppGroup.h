//
//  AppGroup.h
//  iSH
//
//  Created by Theodore Dubois on 2/28/20.
//  Refactored for iSHKit framework
//

#ifndef AppGroup_h
#define AppGroup_h

#import <Foundation/Foundation.h>

@interface AppGroup : NSObject

// Provides the URL to the shared container for the first app group defined in the entitlements.
+ (NSURL *)sharedContainerURL;

@end

#endif /* AppGroup_h */
