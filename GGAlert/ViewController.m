//
//  ViewController.m
//  GGAlert
//
//  Created by viethq on 2/24/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#import "ViewController.h"
#import "GGAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* create img */
    UIImage *pIMG = [UIImage imageNamed:@"avatar"];
    CGSize imgSize = CGSizeMake(pIMG.size.width, pIMG.size.height);
    
    UIGraphicsBeginImageContext( imgSize );
    [pIMG drawInRect:CGRectMake( 0, 0, imgSize.width, imgSize.height)];
    UIImage *pImgScale = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    /* size of file image before and after resize */
    NSData *pOriginData = UIImagePNGRepresentation(pIMG);
    NSData *pScaleData = UIImagePNGRepresentation(pImgScale);
    NSLog(@"size: origin %li || scale %li", (long)pOriginData.length, (long)pScaleData.length);
    
    
    /* create img view */
    UIImageView *pIMGView = [[UIImageView alloc] init];
    pIMGView.image = pImgScale;
    pIMGView.backgroundColor = [UIColor clearColor];
    [pIMGView sizeToFit];
    pIMGView.center = self.view.center;
    
    [self.view addSubview: pIMGView];
    
    
    /* add ges */
    UITapGestureRecognizer *pTap = [[UITapGestureRecognizer alloc] init];
    [pTap addTarget:self action:@selector(_tapCallback:)];
    [self.view addGestureRecognizer:pTap];
    
    
    /* add alert */
    GGAlertView *pAlert = [GGAlertView createAlertWithTitle: @"Alert Title"
                                                    message: @"Test Alert"
                                                cancelTitle: @"Cancel"
                                                 otherTitle: nil
                                                contentView: nil
                                                 completion: nil];
    [pAlert show];
}

-(void)_tapCallback:(UITapGestureRecognizer*)tap
{
    NSLog(@"Touch me");
}

@end
