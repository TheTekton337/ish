//
//  TerminalSessionManager.m
//  iSHKit
//
//  Created by Terrance Wood on 3/12/24.
//

#import <Foundation/Foundation.h>
#import "TerminalSessionManager.h"
// Include any necessary imports for managing terminal sessions

@implementation TerminalSessionManager

- (void)startNewSession {
    // Implementation for starting a new terminal session
    // Notify delegate about session changes and outputs
}

- (void)stopCurrentSession {
    // Implementation for stopping the current session
    // Notify delegate about session changes
}

- (void)sendInputToCurrentSession:(NSString *)input {
    // Implementation for sending input to the current terminal session
    // This might trigger an output which should be sent to the delegate
}

// Implement additional methods as necessary

@end
