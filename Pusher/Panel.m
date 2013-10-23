#import "Panel.h"

#import "JSPopupBackgroundView.h"

@interface Panel ()

@property (weak) IBOutlet JSPopupBackgroundView *popupBackgroundView;

@end

@implementation Panel

- (BOOL)canBecomeKeyWindow;
{
    return YES; // Allow Search field to become the first responder
}

@end
