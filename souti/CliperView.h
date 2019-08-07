//
//  CliperView.h
//  gezi
//
//  Created by zhangyanjiang on 16/4/9.
//  Copyright © 2018年 fanhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CliperView : UIView{

    UIImageView *imageView;
    CGRect cliprect;
    CGPoint touchPoint;
}

- (id)initWithImageView:(UIImageView *)iv;

- (CGRect)ChangeclipEDGE:(float)x1 x2:(float)x2 y1:(float)y1 y2:(float)y2;
- (void)setclipEDGE:(CGRect)rect;

- (CGRect)getclipRect;

-(void)setClipRect:(CGRect)rect;

-(UIImage*)getClipImageRect:(CGRect)rect;



@end
