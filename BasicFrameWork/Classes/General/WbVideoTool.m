//
//  WBVideoTool.m
//  breathPatientApp
//
//  Created by ifly on 2018/7/20.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "WBVideoTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation WBVideoTool
/**获取视频文件大小*/
+ (CGFloat)getFileSize:(NSString *)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }
    return filesize;
}

/**
 *  截取指定时间的视频缩略图
 *
 *  @param timeBySecond 时间点
 *  @return 图片
 */
+ (UIImage *)thumbnailImageRequest:(CGFloat )timeBySecond withURLStr:(NSString *)URLStr{
    //创建URL
    NSURL *url=[NSURL fileURLWithPath:URLStr];
    //根据url创建AVURLAsset
    AVURLAsset *urlAsset=[AVURLAsset assetWithURL:url];
    //根据AVURLAsset创建AVAssetImageGenerator
    AVAssetImageGenerator *imageGenerator=[AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    imageGenerator.appliesPreferredTrackTransform = YES;    // 截图的时候调整到正确的方向

    /*截图
     * requestTime:缩略图创建时间
     * actualTime:缩略图实际生成的时间
     */
    NSError *error=nil;
    CMTime time=CMTimeMakeWithSeconds(timeBySecond, 10);//CMTime是表示电影时间信息的结构体，第一个参数表示是视频第几秒，第二个参数表示每秒帧数.(如果要活的某一秒的第几帧可以使用CMTimeMake方法)
    CMTime actualTime;
    CGImageRef cgImage = [imageGenerator copyCGImageAtTime:time actualTime:&actualTime error:&error];
    if(error){
        NSLog(@"截取视频缩略图时发生错误，错误信息：%@",error.localizedDescription);
        return nil;
    }
    CMTimeShow(actualTime);
    UIImage *image =[UIImage imageWithCGImage:cgImage];//转化为UIImage
    
    CGImageRelease(cgImage);
    
    return image;
}


+ (UIImage*) getVideoPreViewImage:(NSString *)videoURL
{
//    videoURL = @"http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4";
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoURL] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMake(1, 1000);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return img;
    
}

+ (BOOL)saveImage:(UIImage *)image toPath:(NSString *)imagePath;
{
    //    //保存到相册
    //    UIImageWriteToSavedPhotosAlbum(image,nil, nil, nil);
    
    //保存到沙盒
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
    if ([data writeToFile:imagePath atomically:YES]) {
        NSLog(@"save thumbnail image success!");
        return YES;
    } else {
        NSLog(@"save thumbnail image error!");
        return NO;
    }
    
}

/**拍摄的视频格式为MOV，此方法将格式转换为MP4格式类型*/
+ (void)MOVFormatToMP4WithURL:(NSURL *)mediaURL saveToPath:(NSString *)savePath completion:(CompletionHandler)completion failuer:(FailureHandler)failuer
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:mediaURL options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPreset640x480];
        
        exportSession.outputURL = [NSURL fileURLWithPath:savePath];
        
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         
         {
             
             switch (exportSession.status) {
                     
                 case AVAssetExportSessionStatusUnknown:
                     
                     break;
                     
                 case AVAssetExportSessionStatusWaiting:
                     
                     break;
                     
                 case AVAssetExportSessionStatusExporting:
                     
                     break;
                     
                 case AVAssetExportSessionStatusCompleted:
                     
                     if (completion) {
                         completion(savePath);
                     }
                     
                     break;
                     
                 case AVAssetExportSessionStatusFailed:
                     
                     NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
                     if (failuer) {
                         failuer([exportSession error]);
                     }
                     break;
                     
                 case AVAssetExportSessionStatusCancelled:
                     break;
             }
             
         }];
        
    }
    
}

@end
