//
//  WBPushImagePickHelp.h
//  imagePick
//
//  Created by ifly on 2018/5/22.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol WBPushImagePickHelpDelegate <NSObject>

@optional

- (void)seletedImages:(NSMutableArray *)seletedImages withselectedAssets:(NSMutableArray *)selectedAssets;

- (void)seletedVideoUrl:(NSURL *)videoUrl;

@end

@interface WBPushImagePickHelp : NSObject

@property(nonatomic, weak) id<WBPushImagePickHelpDelegate> delegate;
@property(nonatomic, assign) NSInteger maxImageCount;
@property(nonatomic, assign) NSInteger maxColumn;

- (instancetype)initWithTagert:(UIViewController *)target;

/**
 弹出选择框照相和相册

 @param target 负责弹出的vc
 */
- (void)prensentAlertSheetWithTarget:(UIViewController *)target;


/**
 弹出选择框拍摄视频和相册
 
 @param target 负责弹出的vc
 */
- (void)prensentvideoAlertSheetWithTarget:(UIViewController *)target;



/**
 预览照片

 @param index 第几个
 @param seletedPhotos 选中的图片
 @param selectedAssets 选中的assets
 */
- (void)previewPhotosWithIndex:(NSInteger)index WithSelectedPhotos:(NSMutableArray *)seletedPhotos WithSelectedAssets:(NSMutableArray *)selectedAssets;

/**
 删除图片

 @param index 第几个
 */
- (void)removeSeletedimageAndSeletedAssetWithIndex:(NSInteger)index;

/**
 拍视频
 */
- (void)takeVideo;



@end


