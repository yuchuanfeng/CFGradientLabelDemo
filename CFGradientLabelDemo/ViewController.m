//
//  ViewController.m
//  CFGradientLabelDemo
//
//  Created by 于 传峰 on 15/7/27.
//  Copyright (c) 2015年 于 传峰. All rights reserved.
//

#import "ViewController.h"
#import "CFGradientLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *gradientColors = @[(id)[UIColor redColor].CGColor, (id)[UIColor greenColor].CGColor];
    // label
    [self addGradientLabelWithColors:gradientColors];
    
    // layer
    [self addGradientLayerWithColors:gradientColors];
}

- (void)addGradientLabelWithColors:(NSArray *)colors
{
    CFGradientLabel* testLabel = [[CFGradientLabel alloc] init];
    testLabel.text = @"我是渐变色的呀呀呀呀--label";
    testLabel.font = [UIFont systemFontOfSize:23];
    [testLabel sizeToFit];
    testLabel.colors = colors;
    
    [self.view addSubview:testLabel];
    testLabel.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
}

- (void)addGradientLayerWithColors:(NSArray *)colors
{
    UILabel* testLabel = [[UILabel alloc] init];
    testLabel.text = @"我是渐变色的呀呀呀呀--layer";
    testLabel.font = [UIFont systemFontOfSize:23];
    [testLabel sizeToFit];
    
    [self.view addSubview:testLabel];
    testLabel.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.7);
    
    // 创建渐变层
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = testLabel.frame;
    gradientLayer.colors = colors;
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    [self.view.layer addSublayer:gradientLayer];
    
    gradientLayer.mask = testLabel.layer;
    testLabel.frame = gradientLayer.bounds;
}

@end
