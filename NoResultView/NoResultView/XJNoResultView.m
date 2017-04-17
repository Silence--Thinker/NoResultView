//
//  XJNoResultView.m
//  NoResultView
//
//  Created by Silent on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "XJNoResultView.h"

@interface XJNoResultView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIButton *noResultBtn;

@property (nonatomic, copy) didPressedReLoadingBlock reLoadingBlock;
@end
@implementation XJNoResultView {
    __weak UIView *_superView;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self xj_buildingNoResultView];
    }
    return self;
}

- (void)xj_buildingNoResultView {
    self.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:236.0/255.0 blue:243.0/255.0 alpha:1];
    _imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"icon_no_result_collection"];
        [self addSubview:imageView];
        imageView;
    });
    
    _titleLabel = ({
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor colorWithRed:122/255.0 green:119/255.0 blue:109/255.0 alpha:1];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        titleLabel.text = @"没有收藏";
        [self addSubview:titleLabel];
        titleLabel;
    });
    
    _messageLabel = ({
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont boldSystemFontOfSize:16.0];
        messageLabel.textColor = [UIColor colorWithRed:122/255.0 green:119/255.0 blue:109/255.0 alpha:1];
        messageLabel.text = @"没有的事物值得收藏哦";
        [self addSubview:messageLabel];
        messageLabel;
    });
    
    _noResultBtn = ({
        UIButton *noResultBtn = [[UIButton alloc] init];
        noResultBtn.layer.cornerRadius = 6.0;
        noResultBtn.layer.borderWidth = 1.0;
        noResultBtn.layer.borderColor = [[UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1] CGColor];
        noResultBtn.layer.masksToBounds = YES;
        
        CGSize btnSize = CGSizeMake(200, 40);
        UIImage *defaultImage = [self imageWithColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1] andSize:btnSize];
        UIImage *highlightedImage = [self imageWithColor:[UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1] andSize:btnSize];
        [noResultBtn setBackgroundImage:defaultImage forState:UIControlStateNormal];
        [noResultBtn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
        
        [noResultBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        noResultBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [noResultBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
        [noResultBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateHighlighted];
        [noResultBtn addTarget:self action:@selector(didClickNoResultBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:noResultBtn];
        noResultBtn;
    });
}

// viewConfig

- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size {
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = _superView.bounds;
    
    CGFloat viewW = CGRectGetWidth(self.frame);
    CGFloat viewH = CGRectGetHeight(self.frame);
    CGFloat imageW = 100;
    CGFloat imageH = 100;
    CGFloat btnW = 200;
    CGFloat btnH = 40;
    _imageView.frame = CGRectMake((viewW - imageW) * 0.5, viewH * 0.23, imageW, imageH);
    _titleLabel.frame = CGRectMake(20, CGRectGetMaxY(_imageView.frame) + 15, viewW - 40, _titleLabel.font.pointSize + 2);
    _messageLabel.frame = CGRectMake(20, CGRectGetMaxY(_titleLabel.frame) + 10, viewW - 40, _messageLabel.font.pointSize + 2);
    _noResultBtn.frame = CGRectMake((viewW - btnW) * 0.5, CGRectGetMaxY(_messageLabel.frame) + 15, btnW, btnH);
}

// action

- (void)didClickNoResultBtn:(UIButton *)sender {
    [self removeFromSuperview];
    _superView.noResultView = nil;
    
    if (self.reLoadingBlock) {
        self.reLoadingBlock();
    }
}

// MARK - show

+ (void)showNoResultInView:(UIView *)view
                     error:(NSError *)error
            reLoadingBlock:(didPressedReLoadingBlock)reLoadingBlock {
    [self showNoResultInView:view
                   imageName:@"icon_no_result_network"
                       title:@"发生了错误"
                     message:error.debugDescription
                    btnTitle:@"再试一试"
              resultViewType:NoResultViewTypeNone
              reLoadingBlock:reLoadingBlock];
}

+ (void)showNoResultInView:(UIView *)view
            resultViewType:(NoResultViewType)type
            reLoadingBlock:(didPressedReLoadingBlock)reLoadingBlock {
    NSString *imageName = nil;
    NSString *title = nil;
    NSString *message = nil;
    NSString *btnTitle = nil;
    
    switch (type) {
        case NoResultViewTypeNone:{
            imageName = @"icon_no_result_network";
            title = @"网络未开启";
            message = @"请检查网络设置";
            btnTitle = @"重新加载";
        }break;
        case NoResultViewTypeSearch:{
            imageName = @"icon_no_result_information";
            title = @"没有结果";
            message = @"抱歉，没有查到相关数据";
            btnTitle = @"";
        }break;
        case NoResultViewTypeCollect:{
            imageName = @"icon_no_result_collection";
            title = @"没有收藏";
            message = @"美好的事物值得收藏哦";
            btnTitle = @"";
        }break;
        case NoResultViewTypeNetwork:{
            imageName = @"icon_no_result_network";
            title = @"网络未开启";
            message = @"请检查网络设置";
            btnTitle = @"重新加载";
        }break;
            
        default:
            break;
    }
    [self showNoResultInView:view
                   imageName:imageName
                       title:title
                     message:message
                    btnTitle:btnTitle
              resultViewType:type
              reLoadingBlock:reLoadingBlock];
}

+ (void)showNoResultInView:(UIView *)view
                 imageName:(NSString *)imageName
                     title:(NSString *)title
                   message:(NSString *)message
                  btnTitle:(NSString *)btnTitle
            resultViewType:(NoResultViewType)type
            reLoadingBlock:(didPressedReLoadingBlock)reLoadingBlock {
    XJNoResultView *noResultView = [XJNoResultView showInView:view];
    if (!imageName) {
        imageName = @"icon_no_result_collection";
    }
    if (!title) {
        title = @"没有收藏";
    }
    if (!message) {
        message = @"没有的事物值得收藏哦";
    }
    if (!btnTitle) {
        btnTitle = @"重新加载";
    }
    if (type != NoResultViewTypeSearch &&
        type != NoResultViewTypeCollect &&
        reLoadingBlock ) {
        noResultView.noResultBtn.hidden = NO;
        [noResultView.noResultBtn setTitle:btnTitle forState:UIControlStateNormal];
        noResultView.reLoadingBlock = reLoadingBlock;
    }else {
        noResultView.noResultBtn.hidden = YES;
    }
    noResultView.imageView.image = [UIImage imageNamed:imageName];
    noResultView.titleLabel.text = title;
    noResultView.messageLabel.text = message;
}

+ (instancetype)showInView:(UIView *)view {
    XJNoResultView *noResultView = [[XJNoResultView alloc] init];
    [view addSubview:noResultView];
    
    noResultView.frame = view.bounds;
    view.noResultView = noResultView;
    noResultView->_superView = view;
    return noResultView;
}

+ (void)showNoResultInView:(UIView *)superView {
    [self showInView:superView];
}

+ (void)closeNoResultInView:(UIView *)superView {
    [superView.noResultView removeFromSuperview];
    superView.noResultView = nil;
}

@end
