//
//  MyTabbar.h
//  MyTabbarDemo
//
//  Created by Visitor on 15/3/15.
//  Copyright (c) 2015年 Visitor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabbar : UIView
@property(nonatomic,strong)UITabBarController *tabbarController;
+ (MyTabbar *)sharedMyTabbar;
@end











