//
//  BJLViewImports.h
//  BJLiveUI
//
//  Created by MingLQ on 2017-02-15.
//  Copyright © 2017 BaijiaYun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry/Masonry.h>

// fix error: definition of * must be imported from module BJLiveCore.BJLiveCore before it is required
#import <BJLiveCore/BJLiveCore.h>

#import <BJLiveBase/BJL_EXTScope.h>
#import <BJLiveBase/BJLHitTestView.h>
#import <BJLiveBase/BJLWebImage.h>
#import <BJLiveBase/Masonry+BJLAdditions.h>
#import <BJLiveBase/NSObject+BJL_M9Dev.h>
#import <BJLiveBase/NSObject+BJLObserving.h>
#import <BJLiveBase/UIControl+BJLManagedState.h>
#import <BJLiveBase/UIKit+BJL_M9Dev.h>
#import <BJLiveBase/UIKit+BJLHandler.h>

#import "BJLAppearance.h"
#import "BJLButton.h"
#import "BJLTextField.h"

NS_ASSUME_NONNULL_BEGIN

static inline BOOL iPhoneXSeries() {
    static BOOL iPhoneXSeries = NO;
    if (@available(iOS 11.0, *)) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
                CGSize size = [UIScreen mainScreen].nativeBounds.size;
                iPhoneXSeries = (MAX(size.width, size.height) / MIN(size.width, size.height) > 2.0);
            }
        });
    }
    return iPhoneXSeries;
}

NS_ASSUME_NONNULL_END
