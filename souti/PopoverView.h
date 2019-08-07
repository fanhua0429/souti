//
//  PopoverView.h
//  souti
//
//  Created by 周红敏 on 16/3/30.
//  Copyright © 2016年 zhangyanjiang. All rights reserved.
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
