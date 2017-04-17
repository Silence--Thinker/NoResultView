//
//  XJNoResultView.h
//  NoResultView
//
//  Created by Silent on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NoResultViewType) {
    NoResultViewTypeNone,
    NoResultViewTypeService,
    NoResultViewTypeException,
    NoResultViewTypeNetwork,
    
    // 无按钮
    NoResultViewTypeSearch,
    NoResultViewTypeCollect,
};

typedef void(^didPressedReLoadingBlock)();

@interface XJNoResultView : UIView

+ (void)showNoResultInView:(UIView *)view
                     error:(NSError *)error
            reLoadingBlock:(didPressedReLoadingBlock)reLoadingBlock;

+ (void)showNoResultInView:(UIView *)view
            resultViewType:(NoResultViewType)type
            reLoadingBlock:(didPressedReLoadingBlock)reLoadingBlock;

+ (void)showNoResultInView:(UIView *)view
                 imageName:(NSString *)imageName
                     title:(NSString *)title
                   message:(NSString *)message
                  btnTitle:(NSString *)btnTitle
            resultViewType:(NoResultViewType)type
            reLoadingBlock:(didPressedReLoadingBlock)reLoadingBlock;

+ (void)showNoResultInView:(UIView *)superView;

+ (void)closeNoResultInView:(UIView *)superView;

@end
