//
//  JSPushOverAPI.h
//  JaviPhonePushSender
//
//  Created by Javier Soto on 10/21/13.
//  Copyright (c) 2013 JavierSoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSPushOverAPI : NSObject

+ (void)sendPushMessageWithTitle:(NSString *)title
                         message:(NSString *)message
                             URL:(NSString *)URL
                 completionBlock:(void(^)(BOOL success))completionBlock;

@end
