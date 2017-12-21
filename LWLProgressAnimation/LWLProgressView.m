//
//  LWLProgressView.m
//  LampApp
//
//  Created by luowanglin on 2017/2/27.
//  Copyright © 2017年 luowanglin. All rights reserved.
//

#import "LWLProgressView.h"

#define PI 3.14159265358979323846
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation LWLProgressView
{
    int progress_count;
    CADisplayLink *play_link;
}

-(void)setTipText:(NSString *)tipText{
    _tipText = tipText;
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        self.isNorma = YES;
    }
    
    return self;
}

// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (_isNorma) {
        CGContextSetRGBStrokeColor(context, 0.22,0.36,0.81,1.0);//0.35,0.69,0.96(默认颜色)
    }else{
        CGContextSetRGBStrokeColor(context, 0.96,0.77,0.44,1.0);
    }
    
    CGContextSetLineWidth(context, 2.0);
    CGContextAddArc(context, WIDTH/2, HEIGHT/2, 70, 0, 2*PI, 0);
    CGContextStrokePath(context);
    CGContextSetLineWidth(context, 4.0);
    CGContextAddArc(context, WIDTH/2, HEIGHT/2, 68, -PI/2,[_progessValue floatValue]/360*2*PI-PI/2, 0);
    CGContextStrokePath(context);
    
    NSString *conStr = _tipText;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    CGSize size = [conStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    UIFont *font = [UIFont systemFontOfSize:14];
    [conStr drawInRect:CGRectMake((WIDTH-size.width)/2, HEIGHT/2, size.width, 120) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    float valuePro = [_progessValue floatValue]/360;
    NSString *progessValue = [NSString stringWithFormat:@"%.0f%%",valuePro*100];
    NSMutableDictionary *dicProgress = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:24] forKey:NSFontAttributeName];
    CGSize sizeProgress = [progessValue boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicProgress context:nil].size;
    UIFont *fontProgress = [UIFont systemFontOfSize:24];
    [progessValue drawInRect:CGRectMake((WIDTH-sizeProgress.width)/2, HEIGHT/2-40, sizeProgress.width, 120) withAttributes:@{NSFontAttributeName:fontProgress,NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    CGContextDrawPath(context, kCGPathStroke);
    
}

//执行处理
- (void)stopProgressHandlerWithStatu:(int)statu andCode:(int)code timeout:(void(^)(int flag))timeOut{
    
    if (code <= 0 || statu < 0) {
        [play_link invalidate];
        play_link = nil;
        self.isNorma = NO;
        self.progessValue = @0;
        self.tipText = @"执行超时";
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setNeedsDisplay];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3ull *NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            self.hidden = YES;
        });
        //        progressCount = 0;
        timeOut(0);
        return;
    }
    
}

//MARK:Animation Display Action
- (void)start{
    self.hidden = NO;
    progress_count = 1;
    self.isNorma = YES;
    self.tipText = @"开始执行";
    play_link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAnimation)];
    [play_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

//MARK:Animation stop
- (void)stop:(BOOL)isNormal callBack:(void(^)(void))finish{
    [play_link invalidate];
    play_link = nil;
    self.isNorma = isNormal;
    if (isNormal) {
        self.progessValue = @360;
        self.tipText = @"完成执行";
    }else{
        self.progessValue = @0;
        self.tipText = @"执行中断";
    }
    finish();//progressCount = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2ull *NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}

//MARK:动画NSLinkLayer动画计时器(10秒)
- (void)displayLinkAnimation{
    if (progress_count > 180.f && progress_count < 220.f) {
        progress_count += 0.8;
    }else if(progress_count > 220.f && progress_count < 270.f){
        progress_count += 0.6;
    }else if(progress_count > 270.f && progress_count < 320.f){
        progress_count += 0.3;
    }else if(progress_count > 320.f && progress_count < 345.f){
        progress_count += 0.1;
    }else if(progress_count > 345.f){
        [play_link invalidate];
        play_link = nil;
        progress_count = 1;
        return;
    }else{
        progress_count += 1;
    }
    self.progessValue = [NSNumber numberWithFloat:progress_count];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf setNeedsDisplay];
    });
    
}

@end
















