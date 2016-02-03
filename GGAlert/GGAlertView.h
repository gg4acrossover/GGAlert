//
//  GGAlertView.h
//  GGAlert
//
//  Created by viethq on 2/24/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GGAlertViewCompleteBlock)(BOOL cancelled, NSInteger buttonIndex);

@interface GGAlertView : UIViewController

+ (instancetype)createAlertWithTitle: (NSString *)title
                             message: (NSString *)message
                         cancelTitle: (NSString *)cancelTitle
                          otherTitle: (NSString *)otherTitle
                         contentView: (UIView *)view
                          completion: (GGAlertViewCompleteBlock)completion;

-(void)show;

@end
