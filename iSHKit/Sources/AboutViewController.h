//
//  AboutViewController.h
//  iSH
//
//  Created by Theodore Dubois on 9/23/18.
//  Refactored for iSHKit framework
//

#ifndef AboutViewController_h
#define AboutViewController_h

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AboutViewController : UITableViewController

@property BOOL includeDebugPanel;
@property BOOL recoveryMode;

@end

NS_ASSUME_NONNULL_END

#endif /* AboutViewController_h */
