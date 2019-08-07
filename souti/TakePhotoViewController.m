//
//  TakePhotoViewController.m
//  souti
//
//  Created by 周红敏 on 16/3/28.
//  Copyright © 2016年 zhangyanjiang. All rights reserved.
//

#import "TakePhotoViewController.h"
#import "CameraImage.h"
#import "CliperView.h"
#import "DetailViewController.h"
#import "MyNavigationController.h"

@interface TakePhotoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    CameraImage *view;
    CliperView *cliperView;
}

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImageView *cliperImage;

@end

@implementation TakePhotoViewController
// 隐藏上部状态栏
- (UIStatusBarStyle)preferredStatusBarStyle{

    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden{
    
    return YES;
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[view stopCamera];
}
- (void)buildUI{

    if (!view) {
        
        view = [[CameraImage alloc]initWithFrame:self.view.bounds];
        view.backgroundColor = [UIColor blackColor];
        [self.view addSubview:view];
        [self.view sendSubviewToBack:view];
    }
    [view startCamera];
    // 闪光灯
    UIButton *flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    flashButton.frame = CGRectMake(15*Scale_W, 15*Scale_H, 40*Scale_W, 40*Scale_H);
    [flashButton setBackgroundImage:[UIImage imageNamed:@"dengpao"] forState:UIControlStateNormal];
    [flashButton addTarget:self action:@selector(flashAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 相册
    UIButton *pictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pictureButton.frame = CGRectMake(15*Scale_W, kScreenH - 65*Scale_H, 40*Scale_W, 40*Scale_H);
    [pictureButton setBackgroundImage:[UIImage imageNamed:@"xiangce"] forState:UIControlStateNormal];
    [pictureButton addTarget:self action:@selector(pictureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 拍照
    UIButton *takePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    takePhotoButton.frame = CGRectMake(self.view.center.x - 30*Scale_H, kScreenH - 75*Scale_H, 60*Scale_W, 60*Scale_H);
    [takePhotoButton setBackgroundImage:[UIImage imageNamed:@"paizhao1"] forState:UIControlStateNormal];
    [takePhotoButton addTarget:self action:@selector(takePhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 返回
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(self.view.frame.size.width - 55*Scale_W, kScreenH - 65*Scale_H, 40*Scale_W, 40*Scale_H);
    [backButton setBackgroundImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 拍照之后的视图
    self.backgroundView = [[UIView alloc]initWithFrame:self.view.frame];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:26/255.0f green:27/255.0f blue:27/255.0f alpha:1];
    // 图片
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30*Scale_W, 15*Scale_H, self.view.frame.size.width - 60*Scale_W, self.view.frame.size.height - 110*Scale_H)];
    //self.imageView.contentMode = UIViewContentModeScaleToFill;
    cliperView = [[CliperView alloc]initWithImageView:self.imageView];
    // 描述性文字
    UILabel *scriptLabel = [[UILabel alloc]init];
    scriptLabel.text = @"一次只能提交一道题";
    scriptLabel.font = [UIFont systemFontOfSize:13*Scale_W];
    scriptLabel.backgroundColor = [UIColor clearColor];
    scriptLabel.textColor = [UIColor whiteColor];
    scriptLabel.frame = CGRectMake(0, 100*Scale_H, 100*Scale_W, 30*Scale_H);
    scriptLabel.textAlignment = NSTextAlignmentCenter;
    scriptLabel.transform=CGAffineTransformMakeRotation(M_PI/2);
    scriptLabel.frame = CGRectMake(0, 0, 30*Scale_W, 150*Scale_H);
    scriptLabel.center = CGPointMake(15*Scale_W, self.view.frame.size.height/2.0f - 30*Scale_H);
    
    // 确定按钮
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(self.view.center.x - 30*Scale_H, kScreenH - 75*Scale_H, 60*Scale_W, 60*Scale_H);
    [submitButton setBackgroundImage:[UIImage imageNamed:@"qungding"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    // 取消按钮
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(self.view.frame.size.width - 65*Scale_W, kScreenH - 70*Scale_H, 50*Scale_W, 50*Scale_H);
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.backgroundView addSubview:submitButton];
    [self.backgroundView addSubview:cancelButton];
    [self.backgroundView addSubview:scriptLabel];
    [self.backgroundView addSubview:self.imageView];
    self.backgroundView.hidden = YES;
    
    [self.view addSubview:flashButton];
    [self.view addSubview:pictureButton];
    [self.view addSubview:takePhotoButton];
    [self.view addSubview:backButton];
    [self.view addSubview:self.backgroundView];
}
#pragma mark - 照相界面功能
- (void)delayStart{

    [view startCamera];
}
// 闪光灯
- (void)flashAction:(UIButton *)sender{
    if ([view isOpenFlash]) {
        [sender setImage:[UIImage imageNamed:@"dengpao"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"dengpao"] forState:UIControlStateNormal];
    }

}
// 相册
- (void)pictureAction:(UIButton *)sender{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = NO;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker animated:YES completion:^{
        //[view stopCamera];
    }];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 设置导航返回按钮文字的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // 设置返回尖头的图片大小样式
    UIImage * backButtonImageNormal= [UIImage imageNamed:@"back_bar_normal"];
    backButtonImageNormal=[backButtonImageNormal resizableImageWithCapInsets:UIEdgeInsetsMake(17.5, 10, 40, 40) resizingMode:UIImageResizingModeStretch];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImageNormal forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:^{
         NSLog(@"取消了");
     }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.backgroundView.hidden = NO;
    self.imageView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"选取了");
    }];
}
// 拍照
- (void)takePhotoAction:(UIButton *)sender{

    [view takePhotoWithCommit:^(UIImage *image) {
        self.backgroundView.hidden = NO;
        self.imageView.image = image;
    }];
}
// 返回
- (void)backAction:(UIButton *)sender{

    [self dismissViewControllerAnimated:YES completion:^{
        [view stopCamera];
    }];
}
#pragma mark - 上传图片

- (void)submitAction:(id)sender{
    // 推出视图
    DetailViewController *detailVc = [[DetailViewController alloc] initWithBack:YES];
    detailVc.picture = [[UIImageView alloc]init];
    CGRect r = [cliperView getclipRect];
    detailVc.picture.image = [cliperView getClipImageRect:r];
   
    [self.navigationController pushViewController:detailVc animated:YES];
    
    NSLog(@"上传照片");
}
#pragma mark - 取消按钮
- (void)cancelAction:(id)sender{

    // 动画退出视图
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        self.imageView.image = nil;
        self.backgroundView.hidden = YES;
        self.backgroundView.frame = self.view.frame;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
