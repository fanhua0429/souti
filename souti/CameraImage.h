//
//  CameraImage.h
//  souti
//
//  Created by 周红敏 on 16/3/25.
//  Copyright © 2016年 zhangyanjiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraImage : UIView

- (void)startCamera;
- (void)stopCamera;
- (void)takePhotoWithCommit:(void (^)(UIImage *image))commitBlock;
- (BOOL)isOpenFlash;

@end
