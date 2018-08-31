//
//  DefineHeader.h
//  ProjectFramework
//
//  Created by zwb on 2018/1/15.
//  Copyright © 2018年 WB. All rights reserved.
//

#ifndef DefineHeader_h
#define DefineHeader_h

#define WeakS __weak typeof(self) weakSelf = self;
#define StrongS __strong typeof(self) strongSelf = weakSelf;


/**
 *  主屏的宽
 */
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  主屏的高
 */
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height


#define WIDTH_SCALE(x) (SCREEN_WIDTH*(x)/375)

#define HEIGHT_SCALE(y) ((SCREEN_HEIGHT==812 ? 667 : SCREEN_HEIGHT)*(y)/667)

#define NavigationHeight  (SCREEN_HEIGHT==812 ? 88 : 64)

#define tabHeight  49.0

#define statusHeight (SCREEN_HEIGHT==812 ? 44 : 20)

#define safeAreaHeight (SCREEN_HEIGHT==812 ? 34 : 0)

/**
 *  自定义log
 */
#ifdef DEBUG
#define DELog(fmt, ...) NSLog((@"<%s : %d> %s  " fmt), [[[NSString stringWithUTF8String:__FILE__] lastPathComponent]   UTF8String], __LINE__, __PRETTY_FUNCTION__,  ##__VA_ARGS__);
#else
#define DLog(...)
#endif


/**
 国际化文本
 
 @param 国际化的key
 @return 国际化的文本
 */
#define LocalizableText(key) [[LocalizableManager shareLocalizableManager] getLocalizedTextWithKey:key]

#endif /* DefineHeader_h */
