//
//  ED_CrashControl.m
//  CodeLib
//
//  Created by zw on 2019/4/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_CrashControl.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>


static NSUncaughtExceptionHandler *oldHandler ;


typedef void (*ED_SignalHandler)(int signo, siginfo_t *info, void *context);

static ED_SignalHandler previousSignalHandler = NULL;




void ED_CrashControl_uncaughtExceptionHandler(NSException *exception) {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:3];
    if (exception.name) {
         [dic setObject:exception.name forKey:@"name"];
    }
    if (exception.reason) {
        [dic setObject:exception.reason forKey:@"reason"];
    }
    if (exception.callStackSymbols) {
        [dic setObject:exception forKey:@"callStackSymbols"];
    }
    [ED_CrashControl saveExceptionInfo:dic];
    
    if (oldHandler) {
        oldHandler(exception);
    }
    
}


void  ED_CurrentSignalHandler(int signo, siginfo_t *info, void *context) {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableString *mstr = [[NSMutableString alloc] init];
    [mstr appendString:@"Stack:\n"];
    void* callstack[128];
    int i, frames = backtrace(callstack, 128);
    char** strs = backtrace_symbols(callstack, frames);
    for (i = 0; i <frames; i ++) {
        [mstr appendFormat:@"%s\n", strs[i]];
    }
    [dic setObject:mstr forKey:@"signal"];
    [ED_CrashControl saveSignalInfo:dic];
    
    free(strs);

    
    if (previousSignalHandler) {
        previousSignalHandler(signo, info, context);
    }
}




@implementation ED_CrashControl

+ (void)beginListenCrash {
    [self beginExceptionListener];
    

}

+ (void)beginExceptionListener {
    oldHandler = NSGetUncaughtExceptionHandler();
    NSSetUncaughtExceptionHandler(&ED_CrashControl_uncaughtExceptionHandler);
}



+ (void)beginSigalListener {
    struct sigaction old_action;
    sigaction(SIGABRT, NULL, &old_action);
    if (old_action.sa_flags & SA_SIGINFO) {
        previousSignalHandler = old_action.sa_sigaction;
    }
    [self registerSigalListener:SIGHUP];
    [self registerSigalListener:SIGINT];
    [self registerSigalListener:SIGQUIT];
    [self registerSigalListener:SIGABRT];
    [self registerSigalListener:SIGILL];
    [self registerSigalListener:SIGSEGV];
    [self registerSigalListener:SIGFPE];
    [self registerSigalListener:SIGBUS];
    [self registerSigalListener:SIGBUS];
    
}


+ (void)registerSigalListener:(int)signo {
    struct sigaction action;
    action.sa_sigaction = ED_CurrentSignalHandler;
    action.sa_flags = SA_NODEFER | SA_SIGINFO;
    sigemptyset(&action.sa_mask);
    sigaction(signo, &action, 0);
}


+ (void)saveExceptionInfo:(NSDictionary *)info {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths objectAtIndex:0];
    NSString *newPath = [path stringByAppendingPathComponent:@"exception"];
    [info writeToFile:newPath atomically:YES];
    
}

+ (void)saveSignalInfo:(NSDictionary *)info {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths objectAtIndex:0];
    NSString *newPath = [path stringByAppendingPathComponent:@"signal"];
    [info writeToFile:newPath atomically:YES];
    
}

@end
