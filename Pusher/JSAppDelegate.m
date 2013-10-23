//
//  JSAppDelegate.m
//  Pusher
//
//  Created by Javier Soto on 10/21/13.
//  Copyright (c) 2013 JavierSoto. All rights reserved.
//

#import "JSAppDelegate.h"

#import "JSMenubarController.h"
#import "PanelController.h"

@interface JSAppDelegate () <PanelControllerDelegate>

@property (nonatomic, strong) JSMenubarController *menubarController;
@property (nonatomic, strong) PanelController *panelController;

- (IBAction)togglePanel:(id)sender;

@end

@implementation JSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.menubarController = [[JSMenubarController alloc] init];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Explicitly remove the icon from the menu bar
    self.menubarController = nil;
    return NSTerminateNow;
}

#pragma mark - Actions

- (IBAction)togglePanel:(id)sender
{
    self.menubarController.hasActiveIcon = !self.menubarController.hasActiveIcon;
    self.panelController.hasActivePanel = self.menubarController.hasActiveIcon;
}

#pragma mark - Public accessors

- (PanelController *)panelController
{
    if (_panelController == nil) {
        _panelController = [[PanelController alloc] initWithDelegate:self];
    }
    return _panelController;
}

#pragma mark - PanelControllerDelegate

- (StatusItemView *)statusItemViewForPanelController:(PanelController *)controller
{
    return self.menubarController.statusItemView;
}

@end
