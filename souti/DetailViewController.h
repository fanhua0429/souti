//
//  DetailViewController.h
//  souti
//
//  Created by 周红敏 on 16/3/30.
//  Copyright © 2016年 zhangyanjiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController{
    BOOL _dismiss;
}
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) UIImageView *picture;

- (id)initWithBack:(BOOL)dismiss;

@end
