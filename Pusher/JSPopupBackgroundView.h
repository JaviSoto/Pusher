#define ARROW_WIDTH 12
#define ARROW_HEIGHT 8

@interface JSPopupBackgroundView : NSView
{
    NSInteger _arrowX;
}

@property (nonatomic, assign) NSInteger arrowX;

@end
