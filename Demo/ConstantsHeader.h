//
//  ConstantHeader.h
//  Demo
//
//  Created by mac on 2020/8/11.
//  Copyright © 2020 MobiusAd. All rights reserved.
//

#ifndef ConstantHeader_h
#define ConstantHeader_h


#define CONST_MEDIA_ID @"1385996"
#define CONST_SPLASH_ID @"101112867839" //开屏
#define CONST_FEED_NATIVE_ID @"144244099425" //自渲染信息流   原生信息流
#define CONST_FEED_EXPRESS_ID @"102081776052"//信息流广告ios 模板信息流
#define CONST_BANNER_ID @"134437845508" //横幅广告ios
#define CONST_INTERSTITIAL_ID @"121062546321" //插屏广告ios
#define CONST_FULLSCREEN_ID @"181704152578"//全屏视频广告ios
#define CONST_REWARD_VIDEO_ID @"147647844008"//激励视频广告ios



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


