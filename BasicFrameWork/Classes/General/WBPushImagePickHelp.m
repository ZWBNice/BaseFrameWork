//
//  WBPushImagePickHelp.m
//  imagePick
//
//  Created by ifly on 2018/5/22.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "WBPushImagePickHelp.h"
#import <TZImagePickerController/TZImagePickerController.h>


@interface WBPushImagePickHelp ()<UIImagePickerControllerDelegate,TZImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;

}
@property (nonatomic, strong)UIImagePickerController *imagePickController;
@property (nonatomic, weak) UIViewController *target;
@property (nonatomic, strong) NSURL *videoUrl;
@end

@implementation WBPushImagePickHelp

- (UIImagePickerController *)imagePickController{
    if (!_imagePickController) {
        _imagePickController = [[UIImagePickerController alloc] init];
        _imagePickController.delegate = self;
        _imagePickController.navigationBar.barTintColor = self.target.navigationController.navigationBar.barTintColor;
        _imagePickController.navigationBar.tintColor =  self.target.navigationController.navigationBar.tintColor;
        _imagePickController.allowsEditing = true;

    }
    return _imagePickController;
}

- (instancetype)initWithTagert:(UIViewController *)target{
    if (self = [super init]) {
        self.target = target;
        _selectedPhotos = [NSMutableArray array];
        _selectedAssets = [NSMutableArray array];
    }
    return self;
}

- (void)prensentAlertSheetWithTarget:(UIViewController *)target{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:LocalizableText(@"please_choose_photo") message:LocalizableText(@"please_choose_photo") preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:LocalizableText(@"takephoto") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *pushImagePickAction = [UIAlertAction actionWithTitle:LocalizableText(@"choose_ablum") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushTZImagePickerController];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:LocalizableText(@"cancle") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:takePhotoAction];
    [alertController addAction:pushImagePickAction];
    [alertController addAction:cancleAction];
    
    [target presentViewController:alertController animated:true completion:nil];
}


- (void)prensentvideoAlertSheetWithTarget:(UIViewController *)target{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择视频" message:@"请选择视频" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takeVideo];
    }];
    UIAlertAction *pushImagePickAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushVideoAblum];
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:takePhotoAction];
    [alertController addAction:pushImagePickAction];
    [alertController addAction:cancleAction];
    
    [target presentViewController:alertController animated:true completion:nil];

}


// MARK: - 拍照点击
- (void)takePhoto{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) && iOS7Later) {
        // 无权限 做一个友好的提示
        NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
        if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
        NSString *message = [NSString stringWithFormat:[NSBundle tz_localizedStringForKey:@"请允许%@使用您的相机权限 \"设置 -> 隐私 -> 相机\""],appName];
        if (iOS8Later) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"不能使用相机" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"不能使用相机" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self pushImagePick];
                    });
                }
            }];
        } else {
            [self pushImagePick];
        }
    } else {
        [self pushImagePick];
    }

}



- (void)pushImagePick{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;

    BOOL isSourceTypeAvailable =    [UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)];
    if (isSourceTypeAvailable) {
        self.imagePickController.sourceType = sourceType;

//        if(iOS8Later) {
//            self.imagePickController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        }
        [self.target presentViewController:self.imagePickController animated:YES completion:nil];

    }else{
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)pushTZImagePickerController{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImageCount columnNumber:self.maxColumn delegate:self];
    imagePickerVc.selectedAssets = _selectedAssets;
    imagePickerVc.preferredLanguage = LocalizableText(@"TZIlanguageCode");
    imagePickerVc.allowPickingOriginalPhoto = false;
    imagePickerVc.allowPickingVideo = false;
    imagePickerVc.allowCrop = true;
    NSInteger left = 30;
    NSInteger widthHeight = [UIScreen mainScreen].bounds.size.width - 2 * left;
    NSInteger top = ([UIScreen mainScreen].bounds.size.height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
        cropView.layer.borderColor = [UIColor whiteColor].CGColor;
        cropView.layer.borderWidth = 1.0;
    }];

    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self->_selectedPhotos = [NSMutableArray arrayWithArray:photos];
        self->_selectedAssets = [NSMutableArray arrayWithArray:assets];
        if (self.delegate && [self.delegate respondsToSelector:@selector(seletedImages:withselectedAssets:)]) {
            [self.delegate seletedImages:self->_selectedPhotos withselectedAssets:self->_selectedAssets];
        }

    }];

    [self.target presentViewController:imagePickerVc animated:YES completion:nil];


}

// MARK: - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:true completion:nil];
    NSString *type = info[@"UIImagePickerControllerMediaType"];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.preferredLanguage = @"zh-Hans";

//        tzImagePickerVc.sortAscendingByModificationDate = self.sortAscendingSwitch.isOn;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error) {
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:NO completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                    }];
                }];
            }
        }];
    }else if ([@"public.movie" isEqualToString:type]){
        NSURL *mediaURL = info[UIImagePickerControllerMediaURL];
        NSURL *referenceURL = info[UIImagePickerControllerReferenceURL];
        if (mediaURL) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(seletedVideoUrl:)]) {
                [self.delegate seletedVideoUrl:mediaURL];
            }
        }else{
            NSLog(@"%@",@"从相册选取");
        }
    }

}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    if (self.delegate && [self.delegate respondsToSelector:@selector(seletedImages:withselectedAssets:)]) {
        [self.delegate seletedImages:_selectedPhotos withselectedAssets:_selectedAssets];
    }
    
//    if ([asset isKindOfClass:[PHAsset class]]) {
//        PHAsset *phAsset = asset;
//        NSLog(@"location:%@",phAsset.location);
//    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
}

- (void)removeSeletedimageAndSeletedAssetWithIndex:(NSInteger)index{
    
    [_selectedAssets removeObjectAtIndex:index];
    [_selectedPhotos removeObjectAtIndex:index];
}

- (void)previewPhotosWithIndex:(NSInteger)index WithSelectedPhotos:(NSMutableArray *)seletedPhotos WithSelectedAssets:(NSMutableArray *)selectedAssets{
    
    _selectedPhotos = seletedPhotos;
    _selectedAssets = selectedAssets;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:index];
    imagePickerVc.maxImagesCount = self.maxImageCount;
    imagePickerVc.allowPickingOriginalPhoto = false;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        self->_selectedPhotos = [NSMutableArray arrayWithArray:photos];
        self->_selectedAssets = [NSMutableArray arrayWithArray:assets];
        if (self.delegate && [self.delegate respondsToSelector:@selector(seletedImages:withselectedAssets:)]) {
            [self.delegate seletedImages:self->_selectedPhotos withselectedAssets:self->_selectedAssets];
        }

    }];
    [self.target presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)pushVideoAblum{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxImageCount columnNumber:self.maxColumn delegate:self];
//    imagePickerVc.selectedAssets = _selectedAssets;
//    imagePickerVc.preferredLanguage = @"zh-Hans";
//    imagePickerVc.allowPickingOriginalPhoto = false;
//    imagePickerVc.allowCrop = true;
    
    //展示相册中的视频
    imagePickerVc.allowPickingVideo = YES;
    //不展示图片
    imagePickerVc.allowPickingImage = NO;
    //不显示原图选项
    imagePickerVc.allowPickingOriginalPhoto = NO;
    //按时间排序
    imagePickerVc.sortAscendingByModificationDate = YES;

    NSInteger left = 30;
    NSInteger widthHeight = [UIScreen mainScreen].bounds.size.width - 2 * left;
    NSInteger top = ([UIScreen mainScreen].bounds.size.height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
        cropView.layer.borderColor = [UIColor whiteColor].CGColor;
        cropView.layer.borderWidth = 1.0;
    }];
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, id asset) {
        //iOS8以后返回PHAsset
        PHAsset *phAsset = asset;
        if (phAsset.mediaType == PHAssetMediaTypeVideo) {
            //从PHAsset获取相册中视频的url
            PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
            options.version = PHImageRequestOptionsVersionCurrent;
            options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
            PHImageManager *manager = [PHImageManager defaultManager];
            [manager requestAVAssetForVideo:phAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                AVURLAsset *urlAsset = (AVURLAsset *)asset;
                NSURL *url = urlAsset.URL;
                if (self.delegate && [self.delegate respondsToSelector:@selector(seletedVideoUrl:)]) {
                    [self.delegate seletedVideoUrl:url];
                }
            }];
        }

    }];
    
    [self.target presentViewController:imagePickerVc animated:YES completion:nil];
    

}

- (void)takeVideo{
    
    BOOL isSourceTypeAvailable =    [UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)];
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;

    if (isSourceTypeAvailable) {
        self.imagePickController.sourceType = sourceType;
        if(iOS8Later) {
            self.imagePickController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        self.imagePickController.videoMaximumDuration = 300;

        self.imagePickController.delegate = self;
        self.imagePickController.mediaTypes =  @[(NSString *)kUTTypeMovie];
        [self.target presentViewController:self.imagePickController animated:YES completion:nil];
        
    }else{
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }

}

@end

