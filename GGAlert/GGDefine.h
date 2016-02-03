//
//  GGDefine.h
//  GGChatSimple
//
//  Created by viethq on 2/18/15.
//  Copyright (c) 2015 viethq. All rights reserved.
//

#ifndef GGChatSimple_GGDefine_h
#define GGChatSimple_GGDefine_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define ChatMargin 10
#define ChatIconWH 44
#define ChatPicWH 200
#define ChatContentW 180

#define ChatTimeMarginW 15
#define ChatTimeMarginH 10

#define ChatContentTop 15
#define ChatContentLeft 25
#define ChatContentBottom 15
#define ChatContentRight 15 

//! rec method
CGFloat ORIGIN_X( CGRect rec);
CGFloat ORIGIN_Y( CGRect rec);
CGRect CHANGE_ORIGIN_X( CGRect rec, CGFloat originX);
CGRect CHANGE_ORIGIN_Y( CGRect rec, CGFloat originY);
CGRect CHANGE_ORIGIN( CGRect rec, CGFloat originX, CGFloat originY);
CGRect CHANGE_W( CGRect rec, CGFloat w);
CGRect CHANGE_H( CGRect rec, CGFloat h);
CGRect CHANGE_SIZE( CGRect rec, CGFloat w, CGFloat h);

//! screen w,h
CGSize SCREEN_SIZE();

//! font
UIFont *FONT_SYS(CGFloat size);
CGRect ADJUST_LABEL_FRAME_HEIGHT(UILabel*label, CGFloat widthText);

//! project config
UIFont *FONT_CHAT();
UIFont *FONT_CONTENT();

#endif
