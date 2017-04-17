//
//  ViewController.m
//  NoResultView
//
//  Created by Silent on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
@implementation ViewController {
    BOOL _show;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo";
    self.view.backgroundColor = [UIColor lightGrayColor];
//    [XJNoResultView showNoResultInView:self.view];
    
    self.view.noResultConfig.block(^(){
        [self showAlertView];
    }).show();
    
    _show = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_show) {
        
        self.view.noResultConfig.close();
        
    }else {
        
        self.view.noResultConfig.block(^(){
            [self showAlertView];
        }).show();
        
    }
    _show = !_show;
    
    
//    [XJNoResultView closeNoResultInView:self.view];
}

- (void)showAlertView {
    UIAlertController *alertVC =[UIAlertController alertControllerWithTitle:@"点击了重新加载" message:@"点击了怎么了。。。。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
