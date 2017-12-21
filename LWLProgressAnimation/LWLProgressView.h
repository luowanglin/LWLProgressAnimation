//
//  LWLProgressView.h
//  LampApp
//
//  Created by luowanglin on 2017/2/27.
//  Copyright © 2017年 luowanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWLProgressView : UIView
/**
 *@param tipText -->tips for network process description
 */
@property (strong,nonatomic) NSString *tipText;

/*
 *@param isNorma -->judge the process is nor not success
 */
@property BOOL isNorma;

/*
 *@param progessValue -->using to refresh animation status
 */
@property (strong,nonatomic) NSNumber *progessValue;

/*
 *Start time recoder
 */
- (void)start;

/*Animation stop*/
- (void)stop:(BOOL)isNormal callBack:(void(^)(void))finish;

/*
 *Excption teminal handle
 */
- (void)stopProgressHandlerWithStatu:(int)statu andCode:(int)code timeout:(void(^)(int flag))timeOut;

@end

