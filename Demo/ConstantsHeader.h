//
//  ConstantHeader.h
//  Demo
//
//  Created by mac on 2020/8/11.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

#ifndef ConstantHeader_h
#define ConstantHeader_h


#define CONST_MEDIA_ID @"194254620"
#define CONST_SPLASH_ID @"141846962557" //开屏
#define CONST_FEED_NATIVE_ID @"188365472702" //自渲染信息流   原生信息流
#define CONST_FEED_EXPRESS_ID @"104839529683"//信息流广告ios 模板信息流
#define CONST_BANNER_ID @"106467382054" //横幅广告ios
#define CONST_INTERSTITIAL_ID @"123993067264" //插屏广告ios
#define CONST_FULLSCREEN_ID @"159261486405"//全屏视频广告ios
#define CONST_REWARD_VIDEO_ID @"123505912353"//激励视频广告ios



#import "HDWindowLogger.h"
#define AdKleinSDKDemo_Log(frmt, ...)   \
do {\
NSString *msg = [NSString stringWithFormat:frmt,##__VA_ARGS__]; \
NSLog(@"【AggrDemo】%@", msg);  \
HDNormalLog(msg);    \
} while(0)




/**
 Synthsize a weak or strong reference.

 Example:
    @weakify(self)
    [self doSomething^{
        @strongify(self)
        if (!self) return;
        ...
    }];
 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif


#endif /* ConstantHeader_h */


