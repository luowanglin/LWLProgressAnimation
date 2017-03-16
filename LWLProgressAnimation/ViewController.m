//
//  ViewController.m
//  LWLProgressAnimation
//
//  Created by luowanglin on 2017/3/9.
//  Copyright © 2017年 luowanglin. All rights reserved.
//

#import "ViewController.h"
#import "LWLProgressView.h"

@interface ViewController ()
{
    LWLProgressView *_pro_view;
    CADisplayLink *_dis_link;
    float count;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pro_view = [[LWLProgressView alloc]initWithFrame:self.view.bounds];
    _pro_view.progessValue = @1;
    _pro_view.tipText = @"waiting for test...";
    [self.view addSubview:_pro_view];
    dispatch_async(dispatch_get_main_queue(), ^{
    [_pro_view setNeedsDisplay];
    });
    count = 0;
    
    UIButton *star_btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    star_btn.frame = CGRectMake(0, 0, 120, 50);
    star_btn.center = CGPointMake(self.view.center.x, self.view.bounds.size.height - 80);
    [star_btn setTitle:@"Reset" forState:(UIControlStateNormal)];
    [star_btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [star_btn addTarget:self action:@selector(resetAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:star_btn];
   
    //set up for animation begin...
    [self resetAction];
}


- (void)resetAction{
    count = 1;
    _dis_link = [CADisplayLink displayLinkWithTarget:self selector:@selector(redraw)];
    [_dis_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)redraw{
    count += 1;
    if (count > 360.f) {
        [_dis_link invalidate];
        _dis_link = nil;
        return;
    }
    _pro_view.progessValue = [NSNumber numberWithFloat:count];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_pro_view setNeedsDisplay];
    });
}



@end
