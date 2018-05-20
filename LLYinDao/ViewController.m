//
//  ViewController.m
//  LLYinDao
//
//  Created by 嘚嘚以嘚嘚 on 2018/5/21.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "ViewController.h"
#import "LLGuideViewController.h"
@interface ViewController ()

@end

@implementation ViewController
-(void)viewDidAppear:(BOOL)animated{
    [self makeGuideView];
}
- (void)makeGuideView{
    LLGuideViewController *vc = [[LLGuideViewController alloc]init];
    vc.titles = @[@"新增: 功能1，",@"新增: 功能2，",@"新增: 功能3，",@"新增: 功能4，",@"新增: 功能5，",];
    vc.frames = @[@"{{0,  60},{100,80}}",
                  @"{{200,60},{100,80}}",
                  @"{{0,  360},{100,80}}",
                  @"{{200,360},{100,80}}",
                  @"{{100,210},{100,80}}",
                  ];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
