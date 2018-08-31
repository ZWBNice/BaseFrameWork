//
//  WBPhotoSeleteView.m
//  imagePick
//
//  Created by ifly on 2018/5/22.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "WBPhotoSeleteView.h"
#import "WBPushImagePickHelp.h"
#import <Masonry/Masonry.h>
#import <TZImagePickerController/TZImagePickerController.h>
#import "SDPhotoBrowser.h"
@interface WBPhotoSeleteView()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,WBPushImagePickHelpDelegate,SDPhotoBrowserDelegate>{
    CGFloat _preHeight;
}
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) WBPushImagePickHelp *help;
@property(nonatomic, assign) NSInteger maxImageCount;
@property(nonatomic, assign) NSInteger maxColumn;
@property(nonatomic, assign) NSInteger maxImage; // 俩个加一起的最大张数

@end


@implementation WBPhotoSeleteView

- (void)setSelectedPhotos:(NSMutableArray *)selectedPhotos{
    _selectedPhotos = selectedPhotos;
    [self caltulate];
    if (self.delegate && [self.delegate respondsToSelector:@selector(WBPhotoSeleteViewHeightdidChanged:)]) {
            [self.delegate WBPhotoSeleteViewHeightdidChanged:self.frame.size.height];
    }
}

- (void)setNetworkPhotos:(NSMutableArray *)NetworkPhotos{
    _NetworkPhotos = NetworkPhotos;
    [self caltulate];
    [self.collection reloadData];
}

- (void)caltulate{
    CGRect newFrame = self.frame;
    _preHeight = newFrame.size.height;
    
    if (_selectedPhotos.count + _NetworkPhotos.count > 0) {
        CGFloat itemHeight = (self.frame.size.width - (self.maxColumn + 1) * _padding) / self.maxColumn;
        NSInteger rowCount = (_selectedPhotos.count + 1  + _NetworkPhotos.count) / self.maxColumn ;
        if ((_selectedPhotos.count + _NetworkPhotos.count + 1) % self.maxColumn == 0) {
            newFrame.size.height = rowCount * itemHeight + ((rowCount+ 1) * self.padding);
            self.frame = newFrame;
        }else{
            rowCount = rowCount + 1;
            newFrame.size.height = rowCount * itemHeight + ((rowCount+ 1) * self.padding);
            self.frame = newFrame;
        }
        
    }else{
        CGFloat itemHeight = (self.frame.size.width - (self.maxColumn + 1) * self.padding) / self.maxColumn;
        NSInteger rowCount = 1;
        newFrame.size.height = rowCount * itemHeight + ((rowCount+ 1) * self.padding);
        self.frame = newFrame;
    }
}


- (UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.showsVerticalScrollIndicator = false;
        _collection.showsHorizontalScrollIndicator = false;
        _collection.scrollEnabled = true;
        _collection.bounces = NO;
        _collection.backgroundColor = [UIColor whiteColor];
        [_collection registerClass:[WBPhotoSeleteCell class] forCellWithReuseIdentifier:@"PhotoSeletedViewCollectionViewCell"];
    }
    return _collection;
}

- (WBPushImagePickHelp *)help{
    if (!_help) {
        _help = [[WBPushImagePickHelp alloc] initWithTagert:self.viewController];
        _help.delegate = self;
        _help.maxColumn = self.maxColumn;
        _help.maxImageCount = self.maxImageCount;
    }
    return _help;
}




- (instancetype)initWithFrame:(CGRect)frame WithmaxImageCount:(NSInteger)maxImageCount WithmaxCloumn:(NSInteger)maxCloumn WithSelectedPhotos:(NSMutableArray *)seletedPhotos WithSelectedAssets:(NSMutableArray *)selectedAssets WithNetWorkImages:(NSMutableArray *)imageUrls{
    self = [super initWithFrame:frame];
    if (self) {
        self.padding = 5;
        self.maxColumn = maxCloumn;
        self.selectedPhotos = seletedPhotos;
        self.selectedAssets = selectedAssets;
        self.NetworkPhotos = imageUrls;
        self.maxImageCount = maxImageCount - self.NetworkPhotos.count;
        self.maxImage = maxImageCount;
        [self initUI];
    }
    return self;
}


- (void)initUI{
    
    [self addSubview:self.collection];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self).offset(0);
    }];
    [self.collection reloadData];

}

- (void)setPadding:(CGFloat)padding{
    _padding = padding;
    [self.collection reloadData];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

// MARK: - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_selectedPhotos.count + _NetworkPhotos.count == self.maxImage) {
        
        return _selectedPhotos.count + _NetworkPhotos.count;
    }else{
        
        return _selectedPhotos.count + _NetworkPhotos.count + 1;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WBPhotoSeleteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoSeletedViewCollectionViewCell" forIndexPath:indexPath];
//    cell.photoImage.tag = indexPath.row + 20000;
    if (self.selectedPhotos.count + self.NetworkPhotos.count == indexPath.item) {
        cell.photoImage.image = [UIImage imageNamed:@"upload-holder"];
        cell.deleteBtn.hidden = true;
    }else{
        
        if (self.NetworkPhotos.count > indexPath.row && self.NetworkPhotos.count != 0) {
            cell.deleteBtn.hidden = false;
            [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:_NetworkPhotos[indexPath.row]] placeholderImage:nil];
            [cell.deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.deleteBtn.tag = indexPath.item;
            return cell;
        }else{
            cell.deleteBtn.hidden = false;
            cell.photoImage.image = _selectedPhotos[indexPath.item - self.NetworkPhotos.count];
            [cell.deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.deleteBtn.tag = indexPath.item - self.NetworkPhotos.count + 10000;
            return cell;
        }
    }
    
    return cell;
}

- (void)deleteClick:(UIButton *)btn{
    
    if (btn.tag >= 10000) {
        [_selectedAssets removeObjectAtIndex:btn.tag-10000];
        [self.selectedPhotos removeObjectAtIndex:btn.tag- 10000];
        self.selectedPhotos = [NSMutableArray arrayWithArray:self.selectedPhotos];
        [self.help removeSeletedimageAndSeletedAssetWithIndex:btn.tag-10000];
        if (self.selectedPhotos && _selectedAssets) {
            [self.collection performBatchUpdates:^{
                [self.collection deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:btn.tag-10000+self.NetworkPhotos.count inSection:0]]];
                if (self.selectedPhotos.count + self.NetworkPhotos.count == 5) {
                    [self.collection insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:5 inSection:0]]];
                }

            } completion:^(BOOL finished) {
                [self.collection reloadData];
            }];
        }
        
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(WBPhotoSeleteViewdidDeleteImageUrl:WithSuccessBlock:)]) {
            [self.delegate WBPhotoSeleteViewdidDeleteImageUrl:[self.NetworkPhotos objectAtIndex:btn.tag] WithSuccessBlock:^{
              
                [self.NetworkPhotos removeObjectAtIndex:btn.tag];
                self.help.maxImageCount = self.maxImage - self.NetworkPhotos.count;
                [self.collection performBatchUpdates:^{
                    [self.collection deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:btn.tag inSection:0]]];
                    if (self.selectedPhotos.count + self.NetworkPhotos.count == 5) {
                        [self.collection insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:5 inSection:0]]];
                    }
                } completion:^(BOOL finished) {
                    [self.collection reloadData];
                }];

            }];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(WBPhotoSeleteViewdidSeletedPhotos:AndSeletedAssets:)]) {
        [self.delegate WBPhotoSeleteViewdidSeletedPhotos:self.selectedPhotos AndSeletedAssets:_selectedAssets];
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake( (self.frame.size.width - (self.maxColumn + 1) * _padding) / self.maxColumn, (self.frame.size.width - (self.maxColumn + 1) * _padding) / self.maxColumn);
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return self.padding;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//
//    return self.padding;
//}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(self.padding, self.padding, self.padding, self.padding);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == _selectedPhotos.count + _NetworkPhotos.count) {
        [self.help prensentAlertSheetWithTarget:self.viewController];

    }else{
//        [self.help previewPhotosWithIndex:indexPath.item WithSelectedPhotos:_selectedPhotos WithSelectedAssets:_selectedAssets];
        SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
        browser.sourceImagesContainerView = self.collection; // 原图的父控件
        browser.imageCount = _selectedPhotos.count + _NetworkPhotos.count; // 图片总数
        browser.currentImageIndex = indexPath.row;
        browser.delegate = self;
        [browser show];
    }
}

#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    
    WBPhotoSeleteCell *cell = (WBPhotoSeleteCell *)[self collectionView:self.collection cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    return cell.photoImage.image;
}


// 返回高质量图片的url
//- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    
//    NSString *urlStr = _selectedPhotos[index];
//    return [NSURL URLWithString:urlStr];
//}




// MARK: - WBPushImagePickHelpDelegate

- (void)seletedImages:(NSMutableArray *)seletedImages withselectedAssets:(NSMutableArray *)selectedAssets{
    
    self.selectedPhotos = [NSMutableArray arrayWithArray:seletedImages];
    _selectedAssets = [NSMutableArray arrayWithArray:selectedAssets];
    [self.collection reloadData];
    if (self.delegate && [self.delegate respondsToSelector:@selector(WBPhotoSeleteViewdidSeletedPhotos:AndSeletedAssets:)]) {
        [self.delegate WBPhotoSeleteViewdidSeletedPhotos:self.selectedPhotos AndSeletedAssets:_selectedAssets];
    }
}

@end


@implementation WBPhotoSeleteCell

- (UIImageView *)photoImage{
    if (!_photoImage) {
        _photoImage = [[UIImageView alloc] init];
        _photoImage.contentMode = UIViewContentModeScaleToFill;
        _photoImage.userInteractionEnabled = false;
    }
    return _photoImage;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        [_deleteBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    [self.contentView addSubview:self.photoImage];
    [self.contentView addSubview:self.deleteBtn];
    self.contentView.clipsToBounds = true;
    
    [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.width.height.mas_equalTo(self.contentView.frame.size.width);

    }];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.width.height.mas_equalTo(20);

    }];

}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end

@implementation UIView (extension)

- (UIViewController *)viewController{
        UIResponder *responder = [self nextResponder];
        while (responder) {
            if ([responder isKindOfClass:[UIViewController class]]) {
                return (UIViewController*)responder;
            }
            responder = [responder nextResponder];
        }
    return  nil;

}

@end
