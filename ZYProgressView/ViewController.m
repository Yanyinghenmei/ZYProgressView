//
//  ViewController.m
//  ZYProgressView
//
//  Created by Daniel on 16/5/12.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "ViewController.h"
#import "ZYProgressView.h"

@interface ViewController ()

@end

@implementation ViewController {
    ZYProgressView *pro;
    ZYProgressView *pro1;
    ZYProgressView *pro2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIProgressView *proView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
    [self.view addSubview:proView];
    proView.progress = 0.55;

    proView.trackTintColor = [UIColor cyanColor];
    proView.tintColor = [UIColor orangeColor];
    
    
    
    pro = [[ZYProgressView alloc] initWithFrame:CGRectMake(10, 200, 300, 30)];
    [self.view addSubview:pro];
    pro.isSlider = YES;
    pro.panGesBlock = ^(CGFloat progress) {
        NSLog(@"%f", progress);
    };
    
    //    pro.progressType = 1;
    //    pro.backColor = [UIColor lightGrayColor];
    //    pro.progressColors = @[(id)[UIColor yellowColor].CGColor, (id)[UIColor blueColor].CGColor];
    
    
    
    pro1 = [[ZYProgressView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(pro.frame)+ 30, 300, 30)];
    [self.view addSubview:pro1];
    pro1.progress = 0.76;
    
    
    pro2 = [[ZYProgressView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(pro1.frame)+ 30, 300, 30)];
    [self.view addSubview:pro2];
    pro2.progressType = ProgressTypeMaskImage;
    pro2.progress = 0.52;
    
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(150, CGRectGetMaxY(pro2.frame)+100, 80, 50)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"click" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)btn {
    pro.progress = arc4random()%100/100.00;
    pro1.progress = arc4random()%100/100.00;
    pro2.progress = arc4random()%100/100.00;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
