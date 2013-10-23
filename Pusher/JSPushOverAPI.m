//
//  JSPushOverAPI.m
//  Pusher
//
//  Created by Javier Soto on 10/21/13.
//  Copyright (c) 2013 JavierSoto. All rights reserved.
//

#import "JSPushOverAPI.h"

static NSString *const JSPushOverURL = @"https://api.pushover.net/1/messages.json";
static NSString *const JSPushToken = @"Ujrb0G3SS3trCz9LDJbyLGs5PePsEZ";
static NSString *const JSPushUser = @"Sv1w2OdZDHBitgR9LKsYTVcJETuhj3";

@implementation JSPushOverAPI

+ (NSURLRequest *)requestWithHTTPMethod:(NSString *)method URL:(NSString *)url parameters:(NSDictionary *)parameters
{
    NSURLComponents *URLComponents = [NSURLComponents componentsWithString:url];

    NSMutableString *queryString = [NSMutableString string];

    __block NSInteger paramIndex = 0;
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
        [queryString appendFormat:@"%@%@=%@", ((paramIndex > 0) ? @"&" : @""), key, value];

        paramIndex++;
    }];

    URLComponents.query = queryString;

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URLComponents.URL];
    request.HTTPMethod = method;

    return request;
}

+ (void)sendPushMessageWithTitle:(NSString *)title
                         message:(NSString *)message
                             URL:(NSString *)URL
                 completionBlock:(void(^)(BOOL success))completionBlock
{
    NSParameterAssert(message);
    NSParameterAssert(completionBlock);

    NSMutableDictionary *parameters = [@{@"token" : JSPushToken, @"user" : JSPushUser, @"message" : message} mutableCopy];
    if (title.length > 0)
    {
        parameters[@"title"] = title;
    }
    if (URL.length > 0)
    {
        parameters[@"url"] = URL;
    }

    NSURLRequest *request = [self requestWithHTTPMethod:@"POST"
                                                    URL:JSPushOverURL
                                             parameters:parameters];

    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@", response);

        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(((NSHTTPURLResponse *)response).statusCode == 200);
        });
    }];

    [task resume];
}

@end
