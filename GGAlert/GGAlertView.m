//
//  GGAlertView.m
//  GGAlert
//
//  Created by viethq on 2/24/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import "GGAlertView.h"
#import "GGDefine.h"

static const CGFloat AlertViewWidth = 270.0;
static const CGFloat AlertViewContentMargin = 9;
static const CGFloat AlertViewVerticalElementSpace = 10;
static const CGFloat AlertViewButtonHeight = 44;
static const CGFloat AlertViewLineLayerWidth = 0.5;
static const CGFloat AlertViewVerticalEdgeMinMargin = 25;
static const CGFloat AlertViewStartHeight = 150.0f;

@interface GGAlertView()

@property (nonatomic) BOOL buttonsShouldStack;
@property (nonatomic) UIWindow *mainWindow;
@property (nonatomic) UIWindow *alertWindow;
@property (nonatomic) UIView *backgroundView;
@property (nonatomic) UIView *alertView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIView *contentView;
@property (nonatomic) UIScrollView *messageScrollView;
@property (nonatomic) UILabel *messageLabel;
@property (nonatomic) UIButton *cancelButton;
@property (nonatomic) UIButton *otherButton;
@property (nonatomic) NSArray *buttons;
@property (nonatomic) CGFloat buttonsY;
@property (nonatomic) CALayer *verticalLine;
@property (nonatomic) UITapGestureRecognizer *tap;
@property (nonatomic, copy) void (^completion)(BOOL cancelled, NSInteger buttonIndex);

@end

@implementation GGAlertView

#pragma mark - init
+ (instancetype)createAlertWithTitle: (NSString *)title
                             message: (NSString *)message
                         cancelTitle: (NSString *)cancelTitle
                          otherTitle: (NSArray *)otherTitles
                         contentView: (UIView *)view
                          completion: (GGAlertViewCompleteBlock)completion
{
    GGAlertView *alertView = [[GGAlertView alloc] initWithTitle: title
                                                        message: message
                                                    cancelTitle: cancelTitle
                                                    otherTitles: otherTitles
                                                    contentView: view
                                                     completion: (GGAlertViewCompleteBlock)completion];
    return alertView;
}

- (instancetype)initWithTitle:(NSString *)title
            message:(NSString *)message
        cancelTitle:(NSString *)cancelTitle
        otherTitles:(NSArray *)otherTitles
        contentView:(UIView *)contentView
         completion:(GGAlertViewCompleteBlock)completion
{
    self = [super init];
    
    if (self)
    {
        //1, create window
        self.mainWindow = [self _windowWithLevel:UIWindowLevelNormal];
        self.alertWindow = [[UIWindow alloc] initWithFrame: self.mainWindow.bounds];
        self.alertWindow.windowLevel = UIWindowLevelAlert;
        self.alertWindow.backgroundColor = [UIColor clearColor];
        self.alertWindow.rootViewController = self;
        
        //2, bg
        self.view.frame = [UIScreen mainScreen].bounds;
        self.backgroundView = [[UIView alloc] initWithFrame:self.view.frame];
        self.backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        self.backgroundView.alpha = 0.0f;
        [self.view addSubview: self.backgroundView];
        
        //3, alert view
        self.alertView = [[UIView alloc] initWithFrame:CGRectMake( 0.0f, 0.0f, AlertViewWidth, AlertViewStartHeight)];
        self.alertView.backgroundColor = [UIColor colorWithWhite: 0.95f alpha:1];
        self.alertView.layer.cornerRadius = 8.0f;
        self.alertView.alpha = 0.95f;
        self.alertView.clipsToBounds = TRUE;
        [self.view addSubview: self.alertView];
        
        //4, title
        self.titleLabel =
        [[UILabel alloc] initWithFrame:CGRectMake( AlertViewContentMargin,
                                                   AlertViewVerticalElementSpace,
                                                   AlertViewWidth - AlertViewContentMargin*2,
                                                   44.0f )];
        self.titleLabel.text = title;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self _adjustLabelFrameHeight:self.titleLabel];
        [self.alertView addSubview:self.titleLabel];
        
        //5, add btn
        
        
        //6, resize alertView
        [self _resizeAlertView];
        
        //7, addGes
        UITapGestureRecognizer *pTap = [[UITapGestureRecognizer alloc] init];
        [pTap addTarget:self action:@selector(_tapCallback:)];
        [self.view addGestureRecognizer:pTap];
    }
    
    return self;
}

#pragma mark - behavior
- (UIWindow *)_windowWithLevel:(UIWindowLevel)windowLevel
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (window.windowLevel == windowLevel) {
            return window;
        }
    }
    
    return nil;
}

- (CGRect)_adjustLabelFrameHeight:(UILabel*)label
{
    CGRect recLabel = label.frame;
    CGSize sizeTxt = CGSizeMake( AlertViewWidth - AlertViewContentMargin*2, FLT_MAX);
    CGRect rec = [label.text boundingRectWithSize: sizeTxt
                                          options: NSStringDrawingUsesLineFragmentOrigin
                                       attributes: @{ NSFontAttributeName: label.font}
                                          context: nil];
    recLabel.size.height = rec.size.height;
    
    return recLabel;
}

-(void)_resizeAlertView
{
    CGFloat totalHeight = 0.0f;
    
    for ( UIView *view in self.alertView.subviews)
    {
        if ( ![view isKindOfClass:[UIButton class]])
        {
            totalHeight += self.alertView.frame.size.height + AlertViewVerticalElementSpace;
        }
        else
        {
            
        }
    }
    totalHeight += AlertViewVerticalElementSpace;
    self.alertView.frame = CHANGE_ORIGIN_Y( self.alertView.frame,
                                            MIN( totalHeight, self.alertWindow.frame.size.height));
    self.alertView.center = self.alertWindow.center;
}

-(void)_tapCallback:(UITapGestureRecognizer*)tap
{
    [self hide];
}

/*
 * show alert behavior
 */
-(void)_showBackgroundView
{
    [UIView animateWithDuration:0.3f animations:^(){
        self.backgroundView.alpha = 1.0f;
    }];
}

-(void)_showAlertAnim
{
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    keyFrame.values = @[ [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    keyFrame.keyTimes = @[ @0, @0.5, @1 ];
    keyFrame.fillMode = kCAFillModeForwards;
    keyFrame.removedOnCompletion = NO;
    keyFrame.duration = .3;
    
    [self.alertView.layer addAnimation:keyFrame forKey:@"showAlert"];
}

#pragma mark - show
- (void)show
{
    [self.alertWindow makeKeyAndVisible];
    [self _showBackgroundView];
    [self _showAlertAnim];
}

-(void)hide
{
    [self.view removeFromSuperview];
}

@end
