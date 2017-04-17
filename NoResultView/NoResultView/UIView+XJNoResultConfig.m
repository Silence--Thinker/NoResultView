//
//  UIView+XJNoResultConfig.m
//  NoResultView
//
//  Created by Silence on 2017/4/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "UIView+XJNoResultConfig.h"
#import <objc/runtime.h>

@implementation UIView (XJNoResultConfig)

- (XJNoResultConfig *)noResultConfig {
    XJNoResultConfig *noResultConfig = objc_getAssociatedObject(self, _cmd);
    if (!noResultConfig) {
        noResultConfig = [[XJNoResultConfig alloc] initWithSuperView:self];
        objc_setAssociatedObject(self, _cmd, noResultConfig, OBJC_ASSOCIATION_RETAIN);
    }
    return noResultConfig;
}

@end
