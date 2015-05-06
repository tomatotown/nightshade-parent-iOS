//
//  ViewController.m
//  fanqie
//
//  Created by 李俊 on 15/5/6.
//  Copyright (c) 2015年 lijun. All rights reserved.
//

#import "ViewController.h"
#import "MessageViewController.h"
@interface ViewController ()

@end

@implementation ViewController
{
    UISegmentedControl *_mySegmentedControl;
}
-(void)viewWillAppear:(BOOL)animated
{
    _mySegmentedControl.selectedSegmentIndex=0;
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:view];
    //分段条
    _mySegmentedControl = [[UISegmentedControl alloc] init];
    
    // 设置frame
    _mySegmentedControl.frame = CGRectMake(110, 35, 100, 20);
    _mySegmentedControl.tintColor = [UIColor whiteColor];
    // 设置分段条的每个按钮标题
    [_mySegmentedControl insertSegmentWithTitle:@"消息" atIndex:0 animated:NO];
    [_mySegmentedControl insertSegmentWithTitle:@"好友" atIndex:1 animated:NO];
    
    // 设置默认选中的按钮
    _mySegmentedControl.selectedSegmentIndex = 0;
    // 添加点击事件
    [_mySegmentedControl addTarget:self action:@selector(dealSegmentedContolClick:) forControlEvents:UIControlEventValueChanged];
    
    
    
    
    [view addSubview:_mySegmentedControl];
    
}
-(void)dealSegmentedContolClick:(UISegmentedControl *)segmentControl
{
    if (segmentControl.selectedSegmentIndex==0)
    {
        
    }
    if (segmentControl.selectedSegmentIndex==1)
    {
        MessageViewController * view = [[MessageViewController alloc]init];
        [self presentViewController:view animated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
