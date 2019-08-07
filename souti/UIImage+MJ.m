//
//  UIImage+MJ.m
//  LogIn
//
//  Created by 信贷宝 on 15/10/8.
//  Copyright © 2015年 信贷宝. All rights reserved.
//

#import "UIImage+MJ.h"

@implementation UIImage (MJ)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
