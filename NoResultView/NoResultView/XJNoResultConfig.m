//
//  XJNoResultConfig.m
//  NoResultView
//
//  Created by Silence on 2017/4/12.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "XJNoResultConfig.h"

@interface XJNoResultConfig ()
@property (nonatomic, copy) didPressedReLoadingBlock reLoadingBlock;

@end
@implementation XJNoResultConfig {
    __weak UIView *_superView;
    NoResultViewType _configType;
    NSError *_error;
    NSString *_imageName;
    NSString *_title;
    NSString *_message;
    NSString *_btnTitle;
}

- (instancetype)init {
    return [self initWithSuperView:nil];
}

- (instancetype)initWithSuperView:(UIView *)superView {
    if (self = [super init]) {
        _superView = superView;
        if (superView == nil) {
            return nil;
        }
    }
    return self;
}

- (XJNoResultConfig *(^)(NoResultViewType configType))type {
    return ^XJNoResultConfig *(NoResultViewType configType) {
        _configType = configType;
        return self;
    };
}

- (XJNoResultConfig *(^)(NSError *error))error {
    return ^XJNoResultConfig *(NSError *error){
        _error = error;
        return self;
    };
}
- (XJNoResultConfig *(^)(NSString *title))title {
    return ^XJNoResultConfig *(NSString *title){
        _title = title;
        return self;
    };
}
- (XJNoResultConfig *(^)(NSString *message))message {
    return ^XJNoResultConfig *(NSString *message){
        _message = message;
        return self;
    };
}
- (XJNoResultConfig *(^)(NSString *imageName))imageName {
    return ^XJNoResultConfig *(NSString *imageName){
        _imageName = imageName;
        return self;
    };
}
- (XJNoResultConfig *(^)(NSString *btnTitle))btnTitle {
    return ^XJNoResultConfig *(NSString *btnTitle){
        _btnTitle = btnTitle;
        return self;
    };
}

- (XJNoResultConfig *(^)(didPressedReLoadingBlock block))block {
    return ^XJNoResultConfig *(didPressedReLoadingBlock block){
        self.reLoadingBlock = block;
        return self;
    };
}

- (void)showResultView {
    [XJNoResultView showNoResultInView:_superView
                             imageName:_imageName
                                 title:_title
                               message:_message
                              btnTitle:nil
                        resultViewType:NoResultViewTypeNone
                        reLoadingBlock:self.reLoadingBlock];
}

- (void(^)())show {
    return ^(){
        [XJNoResultView showNoResultInView:_superView
                                 imageName:_imageName
                                     title:_title
                                   message:_message
                                  btnTitle:nil
                            resultViewType:NoResultViewTypeNone
                            reLoadingBlock:self.reLoadingBlock];
    };
}

- (void(^)(NoResultViewType configType))showType {
    return ^(NoResultViewType configType) {
        [XJNoResultView showNoResultInView:_superView
                            resultViewType:configType
                            reLoadingBlock:self.reLoadingBlock];
    };
}

- (void(^)(NSError *error))showError {
    return ^(NSError *error) {
        [XJNoResultView showNoResultInView:_superView
                                     error:error
                            reLoadingBlock:self.reLoadingBlock];
    };
}

- (void(^)())close {
    return ^(){
        [XJNoResultView closeNoResultInView:_superView];
    };
}

@end
