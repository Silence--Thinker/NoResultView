//
//  UIView+NoResult.m
//  NoResultView
//
//  Created by Silent on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "UIView+NoResult.h"
#import <objc/runtime.h>

static NSString * const kNoResultViewKey = @"XJNoResultView";

@implementation UIView (NoResult)
@dynamic noResultView;

- (XJNoResultView *)noResultView {
    return objc_getAssociatedObject(self, &kNoResultViewKey);
}

- (void)setNoResultView:(XJNoResultView *)noResultView {
    objc_setAssociatedObject(self, &kNoResultViewKey, noResultView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
