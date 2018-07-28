//
//  AwesomeView.m
//  douyin
//
//  Created by 李永杰 on 2018/7/27.
//  Copyright © 2018年 world. All rights reserved.
//

#import "AwesomeView.h"
//角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface AwesomeView ()<CAAnimationDelegate>

@property (nonatomic,strong)UIImageView *heartImageView;

@end

@implementation AwesomeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    [self addSubview:self.heartImageView];

    int isRight = arc4random()%2 ? 1 : -1;
    
    self.heartImageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(arc4random()%30)*isRight);
    [self.heartImageView.layer addAnimation:[self makeSpringAnimation] forKey:@"spring"];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[[self makeScaleAnimatin],[self makeOpacityAnimation],[self makeMoveAnimation]];
    groupAnimation.beginTime = CACurrentMediaTime() + 0.3;
    groupAnimation.duration = .4;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.delegate = self;
    [self.heartImageView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];

}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.heartImageView.layer removeAllAnimations];
    [self.heartImageView removeFromSuperview];
    [self removeFromSuperview];
}
//弹簧
-(CASpringAnimation *)makeSpringAnimation{
    CASpringAnimation *springAni = [CASpringAnimation animationWithKeyPath:@"bounds"];
    springAni.damping = 2;//阻尼系数（此值越大，弹簧效果越不明显）
    springAni.stiffness = 400;//刚度系数（此值越大，弹簧效果越明显）
    springAni.mass = 50;//质量大小（越大惯性越大）
    springAni.initialVelocity = 20;//初始速度
    springAni.duration = .13;
    springAni.removedOnCompletion = NO;
    springAni.fillMode = kCAFillModeForwards;
    springAni.fromValue = [NSValue valueWithCGRect:self.heartImageView.frame];
    springAni.toValue = [NSValue valueWithCGRect:CGRectMake(self.heartImageView.frame.origin.x+5, self.heartImageView.frame.origin.y+5, self.heartImageView.frame.size.width-10, self.heartImageView.frame.size.height-10)];

    return springAni;
}
//放大
-(CABasicAnimation *)makeScaleAnimatin{
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnim.fromValue = [NSNumber numberWithFloat:1];
    scaleAnim.toValue = [NSNumber numberWithFloat:2.6];
    scaleAnim.removedOnCompletion = NO;
    scaleAnim.fillMode = kCAFillModeForwards;
    return scaleAnim;
}
//透明度
-(CABasicAnimation *)makeOpacityAnimation{
    
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = @1;
    showViewAnn.toValue = @0;
    showViewAnn.fillMode = kCAFillModeForwards;
    showViewAnn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showViewAnn.removedOnCompletion = NO;
    
    return showViewAnn;
}
//移动
-(CABasicAnimation *)makeMoveAnimation{
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:_heartImageView.layer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_heartImageView.layer.position.x, _heartImageView.layer.position.y - 30)];
    return moveAnimation;
}
-(UIImageView *)heartImageView{
    if (!_heartImageView) {
        _heartImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _heartImageView.image = [UIImage imageNamed:@"img_like.png"];
        _heartImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _heartImageView;
}
@end
