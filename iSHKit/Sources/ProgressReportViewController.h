//
//  ProgressReportViewController.h
//  iSH
//
//  Created by Theodore Dubois on 6/18/20.
//  Refactored for iSHKit framework
//

#ifndef ProgressReportViewController_h
#define ProgressReportViewController_h

#import <UIKit/UIKit.h>
#import <iSHKit/Roots.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressReportViewController : UIViewController <ProgressReporter>

- (void)updateProgress:(double)progressFraction message:(NSString *)progressMessage;

@end

NS_ASSUME_NONNULL_END

#endif /* ProgressReportViewController_h */
