//
//  TerminalSessionManager.h
//  iSH
//
//  Created by Terrance Wood on 3/12/24.
//

#ifndef TerminalSessionManager_h
#define TerminalSessionManager_h

#import <Foundation/Foundation.h>

@protocol TerminalSessionManagerDelegate;

@interface TerminalSessionManager : NSObject

@property (weak, nonatomic) id<TerminalSessionManagerDelegate> delegate;

- (void)startNewSession;
- (void)stopCurrentSession;
- (void)sendInputToCurrentSession:(NSString *)input;

@end

@protocol TerminalSessionManagerDelegate <NSObject>
@optional
- (void)sessionDidReceiveOutput:(NSString *)output;
- (void)sessionDidChangeStatus:(BOOL)isConnected;
@end

#endif /* TerminalSessionManager_h */
