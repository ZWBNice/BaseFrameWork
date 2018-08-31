//
//  WBVideoTool.h
//  breathPatientApp
//
//  Created by ifly on 2018/7/20.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionHandler)(NSString *savePath);
typedef void(^FailureHandler)(NSError *error);

@interface WBVideoTool : NSObject

/** 根据路径获取视频大小 */
+ (CGFloat)getFileSize:(NSString *)path;
/**
 *  截取指定时间的本地视频缩略图
 *
 *  @param timeBySecond 时间点
 *  @return 图片
 */
+ (UIImage *)thumbnailImageRequest:(CGFloat )timeBySecond withURLStr:(NSString *)URLStr;


/**
 截取指定时间的在线视频缩略图

 @param videoURL url
 @return image
 */
+ (UIImage*) getVideoPreViewImage:(NSString *)videoURL;

/**
 保存照片，返回是否保存成功,保证imagePath存在
 */
+ (BOOL)saveImage:(UIImage *)image toPath:(NSString *)imagePath;

+ (void)MOVFormatToMP4WithURL:(NSURL *)mediaURL saveToPath:(NSString *)savePath completion:(CompletionHandler)completion failuer:(FailureHandler)failuer;

@end
