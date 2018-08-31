//
//  WBPhotoSeleteView.h
//  imagePick
//
//  Created by ifly on 2018/5/22.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WBPhotoSeleteViewDelegate <NSObject>

@optional

/**
 @param height WBPhotoSeleteView的height
 */
- (void)WBPhotoSeleteViewHeightdidChanged:(CGFloat)height;

- (void)WBPhotoSeleteViewdidSeletedPhotos:(NSMutableArray *)seletedPhotos AndSeletedAssets:(NSMutableArray *)seletedAssets;

@optional

- (void)WBPhotoSeleteViewdidDeleteImageUrl:(NSString *)url WithSuccessBlock:(void(^)(void))success;

@end

@interface WBPhotoSeleteView : UIView


/**
 网络图片数组
 */
@property (nonatomic, strong) NSMutableArray *NetworkPhotos;
/**
 选中的图片数组
 */
@property (nonatomic, strong) NSMutableArray *selectedPhotos;

/**
 选中的图片数组asset
 */
@property (nonatomic, strong) NSMutableArray *selectedAssets;

/**
 初始化方法

 @param frame frame
 @param maxImageCount 照片可选最大数
 @param maxCloumn 最大的列数
 @return WBPhotoSeleteView对象
 */
- (instancetype)initWithFrame:(CGRect)frame WithmaxImageCount:(NSInteger)maxImageCount WithmaxCloumn:(NSInteger)maxCloumn WithSelectedPhotos:(NSMutableArray *)seletedPhotos WithSelectedAssets:(NSMutableArray *)selectedAssets WithNetWorkImages:(NSArray *)imageUrls;
/**
 间距
 */
@property(nonatomic, assign) CGFloat padding;

/**
 返回heightdelegate
 */
@property(nonatomic, weak) id<WBPhotoSeleteViewDelegate>delegate;

@end


@interface WBPhotoSeleteCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *photoImage;
@property (nonatomic, strong) UIButton *deleteBtn;

@end


@interface UIView (extension)

@property(nonatomic, strong,readonly) UIViewController *viewController;

@end
