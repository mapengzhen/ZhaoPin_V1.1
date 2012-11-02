#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol RNExpandingButtonBarDelegate;

@interface RNExpandingButtonBar : UIView
{
    NSObject <RNExpandingButtonBarDelegate> *_delegate;
    
    NSArray *_buttons;
    
    UIButton *_button;

    UIButton *_toggledButton;
    float _animationTime;
    float _fadeTime;
    float _padding;
    float _far;
    float _near;
    float _delay;
    BOOL _spin;
    BOOL _explode;
    BOOL _horizontal;
    BOOL _animated;
    BOOL _toggled;
}

@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *toggledButton;
@property (nonatomic, strong) NSObject <RNExpandingButtonBarDelegate> *delegate;

- (id) initWithImage:(UIImage*)image 
       selectedImage:(UIImage*)selectedImage 
        toggledImage:(UIImage*)toggledImage 
toggledSelectedImage:(UIImage*)toggledSelectedImage 
             buttons:(NSArray*)buttons 
              center:(CGPoint)center;

- (void) setDefaults;

- (void) showButtons;
- (void) hideButtons;
- (void) showButtonsAnimated:(BOOL)animated;
- (void) hideButtonsAnimated:(BOOL)animated;

- (void) toggleMainButton;
- (void) onButton:(id)sender;
- (void) onToggledButton:(id)sender;

- (int) getXoffset:(UIView*)view;
- (int) getYoffset:(UIView*)view;

- (void) explode:(id)sender;

- (void) setAnimationTime:(float)time;
- (void) setFadeTime:(float)time;
- (void) setPadding:(float)padding;
- (void) setSpin:(BOOL)b;
- (void) setHorizontal:(BOOL)b;
- (void) setFar:(float)num;
- (void) setNear:(float)num;
- (void) setDelay:(float)num;
- (void) setExplode:(BOOL)b;

@end

@protocol RNExpandingButtonBarDelegate <NSObject>
@optional

- (void) expandingBarWillAppear:(RNExpandingButtonBar*)bar;
- (void) expandingBarDidAppear:(RNExpandingButtonBar *)bar;
- (void) expandingBarWillDisappear:(RNExpandingButtonBar *)bar;
- (void) expandingBarDidDisappear:(RNExpandingButtonBar *)bar;

@end