//
//  JSMenubarController.h
//  Pusher
//
//  Created by Javier Soto on 10/23/13.
//  Copyright (c) 2013 JavierSoto. All rights reserved.
//

#import <Foundation/Foundation.h>

#define STATUS_ITEM_VIEW_WIDTH 24.0

@class StatusItemView;

@interface JSMenubarController : NSObject

@property BOOL hasActiveIcon;
@property (strong, readonly) NSStatusItem *statusItem;
@property (strong, readonly) StatusItemView *statusItemView;

@end
