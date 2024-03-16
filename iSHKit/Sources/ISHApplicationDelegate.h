//
//  ISHApplicationDelegate.h
//  iSH
//
//  Created by Terrance Wood on 3/12/24.
//

#ifndef ISHApplicationDelegate_h
#define ISHApplicationDelegate_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ISHApplicationDelegate <NSObject>

//@property (strong, nonatomic) UIWindow *window;
- (void)exitApp;

+ (void)maybePresentStartupMessageOnViewController:(UIViewController *)vc;

//- (void)setupApplicationEnvironment;

@end

#endif /* ISHApplicationDelegate_h */
