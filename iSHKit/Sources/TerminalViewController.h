//
//  TerminalViewController.h
//  iSH
//
//  Created by Theodore Dubois on 10/17/17.
//  Refactored for iSHKit framework
//

#ifndef TerminalViewController_h
#define TerminalViewController_h

#import <UIKit/UIKit.h>
#import <iSHKit/Terminal.h>

@interface TerminalViewController : UIViewController

@property (nonatomic) Terminal *terminal;

- (void)startNewSession;
- (void)reconnectSessionFromTerminalUUID:(NSUUID *)uuid;
@property (readonly) NSUUID *sessionTerminalUUID; // 0 means invalid
@property UISceneSession *sceneSession API_AVAILABLE(ios(13.0));

@end

extern struct tty_driver ios_tty_driver;

#endif /* TerminalViewController_h */
