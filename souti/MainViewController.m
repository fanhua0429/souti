
//
//  MainViewController.m
//  souti
//
//  Created by 周红敏 on 16/3/24.
//  Copyright © 2016年 zhangyanjiang. All rights reserved.
//

#import "MainViewController.h"
#import "TakePhotoViewController.h"
#import "ExaminationViewController.h"
#import "MyNavigationController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"beijing"];
    [self.view addSubview:imageview];
    
    UIButton *takePhotoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    takePhotoBtn.frame = CGRectMake(40*Scale_W, 100*Scale_H, self.view.frame.size.width-80*Scale_W, self.view.frame.size.width-60*Scale_H);
    [takePhotoBtn setBackgroundImage:[UIImage imageNamed:@"paizhao"] forState:UIControlStateNormal];
    [takePhotoBtn addTarget:self action:@selector(clickTake) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:takePhotoBtn];
    
    UIButton *examinationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    examinationBtn.frame = CGRectMake(0, 0, 100*Scale_W, 40*Scale_H);
    examinationBtn.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height - 100*Scale_H);
    //[examinationBtn setBackgroundColor:[UIColor orangeColor]];
    [examinationBtn setTitle:@"我的题库" forState:UIControlStateNormal];
    examinationBtn.titleLabel.font = [UIFont systemFontOfSize:19*Scale_W];
    [examinationBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [examinationBtn addTarget:self action:@selector(clickExamination) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:examinationBtn];
}
- (void)clickTake{

    NSLog(@"开始拍照");
    TakePhotoViewController *takePhotoVc = [[TakePhotoViewController alloc]init];
    MyNavigationController *myNav = [[MyNavigationController alloc]initWithRootViewController:takePhotoVc];
    [self presentViewController:myNav animated:YES completion:nil];
}
- (void)clickExamination{

    ExaminationViewController *examinationVC = [[ExaminationViewController alloc]init];
    [self.navigationController pushViewController:examinationVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
