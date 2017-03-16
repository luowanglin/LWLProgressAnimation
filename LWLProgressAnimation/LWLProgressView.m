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

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        self.isNorma = YES;
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (_isNorma) {
      CGContextSetRGBStrokeColor(context, 0.35,0.69,0.96,1.0);
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


@end















