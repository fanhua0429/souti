//
//  CameraImage.h
//  souti
//
//  Created by 樊华 on 16/3/25.
//  Copyright © 2018年 fanhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraImage : UIView

- (void)startCamera;
- (void)stopCamera;
- (void)takePhotoWithCommit:(void (^)(UIImage *image))commitBlock;
- (BOOL)isOpenFlash;

@end
