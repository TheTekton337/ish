//
//  AppGroup.m
//  iSHKit
//
//  Created by Theodore Dubois on 2/28/20.
//  Refactored for iSHKit framework
//

#import <iSHKit/AppGroup.h>

@implementation AppGroup

+ (NSURL *)sharedContainerURL {
    NSArray<NSString *> *appGroups = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"com.apple.security.application-groups"];
    if (appGroups.count > 0) {
        return [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:appGroups[0]];
    } else {
        // Log an error or handle the case where no app groups are defined.
        NSLog(@"No app groups defined.");
        return nil;
    }
}

@end
