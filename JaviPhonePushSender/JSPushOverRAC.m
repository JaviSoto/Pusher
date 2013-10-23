//
//  JSPushOverRAC.m
//  JaviPhonePushSender
//
//  Created by Javier Soto on 10/23/13.
//  Copyright (c) 2013 JavierSoto. All rights reserved.
//

#import "JSPushOverRAC.h"

#import "JSPushOverAPI.h"

static NSString *const JSPushOverRACErrorDomain = @"com.javisoto.pushover.error";

@implementation JSPushOverRAC

+ (RACSignal *)sendPushMessageWithTitle:(NSString *)title
                                message:(NSString *)message
                                    URL:(NSString *)URL
{
    RACReplaySubject *signal = [RACReplaySubject replaySubjectWithCapacity:RACReplaySubjectUnlimitedCapacity];

    [JSPushOverAPI sendPushMessageWithTitle:title
                                    message:message
                                        URL:URL
                            completionBlock:^(BOOL success) {
                                if (success)
                                {
                                    [signal sendCompleted];
                                }
                                else
                                {
                                    [signal sendError:[NSError errorWithDomain:JSPushOverRACErrorDomain
                                                                         code:400
                                                                      userInfo:nil]];
                                }
                            }];

    return signal;
}

@end
