#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSObject+Swizzling.h"
#import "NSString+email.h"
#import "NSString+format.h"
#import "NSString+IDCard.h"
#import "NSString+MD5.h"
#import "NSString+Size.h"
#import "NSString+Tool.h"
#import "PrefixOs.h"

FOUNDATION_EXPORT double PoporFoundationVersionNumber;
FOUNDATION_EXPORT const unsigned char PoporFoundationVersionString[];

