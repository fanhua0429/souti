

//
//  CameraImage.m
//  souti
//
//  Created by 周红敏 on 16/3/25.
//  Copyright © 2016年 zhangyanjiang. All rights reserved.
//

#import "CameraImage.h"
#import <AVFoundation/AVFoundation.h>

#define MAINSCREEN_BOUNDS  [UIScreen mainScreen].bounds
#define ScreenScaleRatio [UIScreen mainScreen].bounds.size.width/414.0

@interface CameraImage()

// AVFoundation 的属性
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureDeviceInput *deviceInput;
@property (strong, nonatomic) AVCaptureStillImageOutput *imageOutput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *VPlayer;
@property (strong, nonatomic) AVCaptureDevice *captureDevice;

// 照片视图
@property (strong, nonatomic) UIImageView *imageView;

@end
@implementation CameraImage

- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setUpCameraPreviewLayer];
        // 花线
        [self setLineView];
    }
    return self;
}

- (void)setUpCameraPreviewLayer{

    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        return;
    }
    if (!_VPlayer) {
        [self initSession];
        self.VPlayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
        self.VPlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.VPlayer.position = self.center;
        self.VPlayer.bounds = self.bounds;
        [self.layer insertSublayer:self.VPlayer atIndex:0];
    }
}

- (void)initSession{

    self.captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.captureSession = [[AVCaptureSession alloc]init];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    self.deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self cameraWithDirection:AVCaptureDevicePositionBack] error:nil];
    self.imageOutput = [[AVCaptureStillImageOutput alloc]init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.imageOutput setOutputSettings:outputSettings];
    if ([self.captureSession canAddInput:self.deviceInput]) {
        [self.captureSession addInput:self.deviceInput];
    }
    if ([self.captureSession canAddOutput:self.imageOutput]) {
        [self.captureSession addOutput:self.imageOutput];
    }
}

- (AVCaptureDevice *)cameraWithDirection:(AVCaptureDevicePosition)position{

    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}
// 线条
- (void)setLineView{
    
    for (int i=1; i<3; i++) {
        UIView *lineView1 = [[UIView alloc]init];
        lineView1.frame = CGRectMake(MAINSCREEN_BOUNDS.size.width/3 * i, 0, 0.8, MAINSCREEN_BOUNDS.size.height);
        lineView1.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc]init];
        lineView2.frame = CGRectMake(0, MAINSCREEN_BOUNDS.size.height/3 * i, MAINSCREEN_BOUNDS.size.width, 0.8);
        lineView2.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineView2];
    }
}
/*
 拍照事件
 */
- (void)takePhotoWithCommit:(void (^)(UIImage *))commitBlock{

    AVCaptureConnection *vConnection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    //vConnection.videoOrientation = AVCaptureVideoOrientationPortrait;//控制输出照片方向
    __block UIImage *image;
    if (!vConnection) {
        NSLog(@"失败了");
        return;
    }
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:vConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == nil) {
            return ;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        image = [UIImage imageWithData:imageData scale:1];
        commitBlock(image);
    }];
}
- (void)startCamera{

    if (self.captureSession) {
        [self.captureSession startRunning];
    }
}
- (void)stopCamera{

    if (self.captureSession) {
        [self.captureSession stopRunning];
    }
}

/*
 闪光灯
 */
- (BOOL)isOpenFlash{

    if ([self.captureDevice hasFlash] && [self.captureDevice hasTorch]) {
        if (self.captureDevice.torchMode == AVCaptureTorchModeOff) {
            [self.captureSession beginConfiguration];
            [self.captureDevice lockForConfiguration:nil];
            [self.captureDevice setTorchMode:AVCaptureTorchModeOn];
            [self.captureDevice setFlashMode:AVCaptureFlashModeOn];
            [self.captureDevice unlockForConfiguration];
            return YES;
        }else if(self.captureDevice.torchMode == AVCaptureTorchModeOn){
            [self.captureSession beginConfiguration];
            [self.captureDevice lockForConfiguration:nil];
            [self.captureDevice setTorchMode:AVCaptureTorchModeOff];
            [self.captureDevice setFlashMode:AVCaptureFlashModeOff];
            [self.captureDevice unlockForConfiguration];
            return NO;
        }
        [self.captureSession commitConfiguration];
    }
    return YES;
}












@end
