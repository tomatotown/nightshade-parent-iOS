//
//  MyTabbar.m
//  MyTabbarDemo
//
//  Created by Visitor on 15/3/15.
//  Copyright (c) 2015年 Visitor. All rights reserved.
//

#import "MyTabbar.h"
#import "AppDelegate.h"
#define BUTTON_HEIGHT 0.8
#define LABEL_HEIGHT 0.2

@implementation MyTabbar
{
    UIButton *_selectedBtn;
    UILabel *_selectedLabel;
}
static MyTabbar *_sharedMyTabbar;
+ (MyTabbar *)sharedMyTabbar
{
    if(!_sharedMyTabbar)
    {
        _sharedMyTabbar = [[MyTabbar alloc] init];
    }
    return _sharedMyTabbar;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - mainFunc

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createTabbarController];
    }
    return self;
}

// 创建系统tabbar
- (void)createTabbarController
{
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    NSArray * vcNameArray = @[@"ViewController",@"AroundViewController",@"DiscoverViewController",@"SelfViewController"];
    
    for (int i = 0; i<vcNameArray.count; i++)
    {
        Class cl = NSClassFromString([vcNameArray objectAtIndex:i]);
        UIViewController * vc = [[cl alloc]init];
        UINavigationController * na = [[UINavigationController alloc]initWithRootViewController:vc];
        
        [vcs addObject:na];;
    }

    
    _tabbarController = [[UITabBarController alloc] init];
    _tabbarController.viewControllers = vcs;
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController = _tabbarController;
    
    [self createMyTabbar];
    
}

// 创建自定义tabbar
- (void)createMyTabbar
{
    // plist文件读取成字典
    NSDictionary *plistDict = [self loadTabbarPlist];
    // 创建背景图
    [self createBgImageWithImageName:[plistDict objectForKey:@"bgImageName"]];
    // 创建item
    for(int i=0;i<((NSArray *)[plistDict objectForKey:@"Items"]).count;i++)
    {
        [self createItemWithItemDict:[((NSArray *)[plistDict objectForKey:@"Items"]) objectAtIndex:i] andItemIndex:i andItemCount:((NSArray *)[plistDict objectForKey:@"Items"]).count];
    }
}

#pragma mark - subFunc
- (NSDictionary *)loadTabbarPlist
{
    NSString *path = [NSString stringWithFormat:@"%@/Tabbar.plist",[[NSBundle mainBundle] resourcePath]];
    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    return plistDict;
}

- (void)createBgImageWithImageName:(NSString *)bgImageName;
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:bgImageName]];
    imageView.frame = _tabbarController.tabBar.bounds;
    [_tabbarController.tabBar addSubview:imageView];
}

- (void)createItemWithItemDict:(NSDictionary *)itemDict andItemIndex:(int)itemIndex andItemCount:(int)itemCount;
{
    CGRect rect = _tabbarController.tabBar.bounds;
    UIView *itemView = [[UIView alloc] init];
    itemView.frame = CGRectMake(itemIndex*rect.size.width/itemCount, 0, rect.size.width/itemCount, rect.size.height);
    [_tabbarController.tabBar addSubview:itemView];
    
    // 按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, itemView.frame.size.width, itemView.frame.size.height*BUTTON_HEIGHT);
    [btn setImage:[UIImage imageNamed:[itemDict objectForKey:@"imageName"]]  forState:UIControlStateNormal];
    [btn setImage: [UIImage imageNamed:[itemDict objectForKey:@"selectImageName"]] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = itemIndex;
    [itemView addSubview:btn];
    
    // 标签
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, btn.frame.size.height-5, btn.frame.size.width, itemView.frame.size.height*LABEL_HEIGHT);
    label.text = [itemDict objectForKey:@"title"];
    label.textColor = [UIColor colorWithRed:0.37f green:0.37f blue:0.37f alpha:1.00f];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:9];
    [itemView addSubview:label];
    
    // 设置index为0的默认选中
    if(itemIndex == 0)
    {
        btn.selected = YES;
        _selectedBtn = btn;
        label.textColor = [UIColor colorWithRed:0.16f green:0.72f blue:1.00f alpha:1.00f];
        _selectedLabel = label;
    }

}

- (void)btnClick:(UIButton *)btn
{
    // 按钮变色
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    // label变色
    _selectedLabel.textColor = [UIColor colorWithRed:0.37f green:0.37f blue:0.37f alpha:1.00f];
    ((UILabel *)[btn.superview.subviews objectAtIndex:1]).textColor = [UIColor colorWithRed:0.16f green:0.72f blue:1.00f alpha:1.00f];
    _selectedLabel = ((UILabel *)[btn.superview.subviews objectAtIndex:1]);
    
    _tabbarController.selectedIndex = btn.tag;
    
}


















@end
