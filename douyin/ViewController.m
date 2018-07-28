//
//  ViewController.m
//  douyin
//
//  Created by liyongjie on 2018/2/6.
//  Copyright © 2018年 world. All rights reserved.
//

#import "ViewController.h"
#import "AwesomeView.h"



@interface ViewController ()

@end

static NSInteger count = 0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tap];

}


-(void)handleTap:(UITapGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:[tap view]];
    AwesomeView *awe = [[AwesomeView alloc]initWithFrame:CGRectMake(point.x-40, point.y-40, 80, 80)];
    [self.view addSubview:awe];
}


@end
