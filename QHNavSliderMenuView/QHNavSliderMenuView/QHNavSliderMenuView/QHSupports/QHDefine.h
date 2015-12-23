//
//  QHDefine.h
//  QHTableViewProfile
//
//  Created by imqiuhang on 15/8/12.
//  Copyright (c) 2015年 imqiuhang. All rights reserved.
//

#ifndef QHTableViewProfile_QHDefine_h
#define QHTableViewProfile_QHDefine_h
#import "QHUtil.h"
#import "NSString+QHNSStringCtg.h"
#import "UILabel+QHLabelCtg.h"

#define QHRGB(r, g, b)    [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define QHRGBA(r, g, b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]
#define lineViewColor      QHRGB(232,232,232)
#define defaultFont(s) [UIFont fontWithName:@"STHeitiSC-Light" size:s]

#define QHKEY_WINDOW      [[UIApplication sharedApplication] keyWindow]
#define QHScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define QHScreenHeight    [[UIScreen mainScreen] bounds].size.height

#define QHIOS_VERSION     [[[UIDevice currentDevice] systemVersion] floatValue]

#ifdef DEBUG
#define QHLog(fmt,...) NSLog((@"\n\n[行号]%d\n" "[函数名]%s\n" "[日志]"fmt"\n"),__LINE__,__FUNCTION__,##__VA_ARGS__);
#else
#define QHLog(fmt,...);
#endif



#define YMSViewBackgroundColor         [QHUtil colorWithHexString:@"f5f5f5"]

//app的文本标题颜色
#define YMSTitleColor                  [QHUtil colorWithHexString:@"333333"]

//通用的副标题颜色
#define YMSSubTitleLableColor          [QHUtil colorWithHexString:@"aaaaaa"]

//展位图统一的背景颜色
#define YMSPlaceHolderBgColor           [QHUtil colorWithHexString:@"#F5F5F5"]

//统一的列表线条颜色
#define YMSLineViewColor                [QHUtil colorWithHexString:@"#E8E8E8"]


//品牌色
#define YMSBrandColor                  [QHUtil colorWithHexString:@"ff807a"]

//导航栏的背景颜色
#define YMSNavBarTinkColor              [UIColor  whiteColor]

//导航栏的标题颜色
#define YMSNavTitleColor                [QHUtil colorWithHexString:@"333333"]
//状态栏
#define YMSStatusBarStyle              UIStatusBarStyleDefault

#define YMSTabBarBarTintColor          [UIColor  whiteColor]


/*字体*/




#endif
