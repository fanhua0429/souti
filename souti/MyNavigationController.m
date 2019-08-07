//
//  MyNavigationController.m
//  souti
//
//  Created by 樊华 on 16/3/28.
//  Copyright © 2018年 fanhua. All rights reserved.
//

#import "MyNavigationController.h"
#import "UIImage+MJ.h"

#define kCOLOR_R_G_B_A(r,g,b,a) [UIColor colorWithRed:r/255.0f  green:g/255.0f  blue:b/255.0f alpha:a]

@interface MyNavigationController ()

@end

@implementation MyNavigationController

+ (void)initialize{

    // 设置导航主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮主题
    //[self setupBarButtonItemTheme];

}
+ (void)setupNavBarTheme{
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [navBar setTitleTextAttributes:textAttrs];
    
    // 设置背景染色
    [navBar setBackgroundImage:[UIImage imageWithColor:kCOLOR_R_G_B_A(53, 141, 247, 1)] forBarMetrics:UIBarMetricsDefault];
    // 设置导航栏的电池成为白色
    [navBar setBarStyle:UIBarStyleBlack];
}
// 2.设置导航栏按钮主题
+ (void)setupBarButtonItemTheme{
    
    // 设置导航返回按钮文字的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // 设置返回尖头图片大小图样
    
    UIImage *backButtonImage = [UIImage imageNamed:@"back_bar_normal@2x"];
    backButtonImage = [backButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(17.5, 10, 40, 40) resizingMode:UIImageResizingModeTile];
    [[UIBarButtonItem appearance] setBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
}



@end
