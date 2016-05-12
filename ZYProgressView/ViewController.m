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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIProgressView *proView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
    [self.view addSubview:proView];
    proView.progress = 0.55;

    proView.trackTintColor = [UIColor cyanColor];
    proView.tintColor = [UIColor orangeColor];
    
    ZYProgressView *pro = [[ZYProgressView alloc] initWithFrame:CGRectMake(10, 200, 300, 50)];
    [self.view addSubview:pro];
    pro.backgroundColor = [UIColor colorWithRed:241/255.00 green:241/255.00 blue:241/255.00 alpha:1];
    pro.progress = 0.67;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
