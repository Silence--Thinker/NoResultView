//
//  XJNoResultConfig.h
//  NoResultView
//
//  Created by Silence on 2017/4/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+NoResult.h"

@class XJNoResultConfig;
@interface XJNoResultConfig : NSObject

- (instancetype)initWithSuperView:(UIView *)superView
__attribute__((objc_designated_initializer));

- (XJNoResultConfig *(^)(NoResultViewType configType))type;

- (XJNoResultConfig *(^)(NSError *error))error;
- (XJNoResultConfig *(^)(NSString *title))title;
- (XJNoResultConfig *(^)(NSString *message))message;
- (XJNoResultConfig *(^)(NSString *imageName))imageName;
- (XJNoResultConfig *(^)(NSString *btnTitle))btnTitle;
- (XJNoResultConfig *(^)(didPressedReLoadingBlock block))block;


- (void(^)())show;
- (void(^)(NoResultViewType configType))showType;
- (void(^)(NSError *error))showError;
- (void(^)())close;
@end
