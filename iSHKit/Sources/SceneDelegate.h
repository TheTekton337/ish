//
//  SceneDelegate.h
//  iSH
//
//  Created by Theodore Dubois on 10/26/19.
//  Refactored for iSHKit framework
//

#ifndef SceneDelegate_h
#define SceneDelegate_h

#import <UIKit/UIKit.h>
#import <iSHKit/TerminalViewController.h>

NS_ASSUME_NONNULL_BEGIN

extern TerminalViewController *currentTerminalViewController;

API_AVAILABLE(ios(13))
@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property (nonatomic) UIWindow *window;

@end

NS_ASSUME_NONNULL_END

#endif /* SceneDelegate_h */
