//
//  PopoverView.h
//  souti
//
//  Created by 樊华 on 16/3/30.
//  Copyright © 2018年 fanhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopoverView : UIView

+ (void)addPellTableViewSelectWithWindowFrame:(CGRect)frame
                                   selectData:(NSArray *)selectData
                                       action:(void(^)(NSInteger index))action animated:(BOOL)animate;
/**
 *  手动隐藏
 */
+ (void)hiden;

@end
