//
//  JSPushOverRAC.h
//  Pusher
//
//  Created by Javier Soto on 10/23/13.
//  Copyright (c) 2013 JavierSoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface JSPushOverRAC : NSObject

+ (RACSignal *)sendPushMessageWithTitle:(NSString *)title
                                message:(NSString *)message
                                    URL:(NSString *)URL;

@end
