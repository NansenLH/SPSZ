//
//  NSNull+LUNullExtention.m
//  smartlife
//
//  Created by nansen on 2017/3/28.
//  Copyright © 2017年 jingxi. All rights reserved.
//

#import "NSNull+LUNullExtention.h"
#import <objc/Runtime.h>


#define NSNullObjects @[@"", @0, @{}, @[]]


@implementation NSNull (LUNullExtention)

+ (void)load
{
    @autoreleasepool {
        [self lu_swizzleInstanceMethodWithClass:[NSNull class] originalSel:@selector(methodSignatureForSelector:) replacementSel:@selector(lu_methodSignatureForSelector:)];
        [self lu_swizzleInstanceMethodWithClass:[NSNull class] originalSel:@selector(forwardInvocation:) replacementSel:@selector(lu_forwardInvocation:)];
    }
}

- (NSMethodSignature *)lu_methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        for (NSObject *object in NSNullObjects) {
            signature = [object methodSignatureForSelector:aSelector];
            if (!signature) {
                continue;
            }
            if (strcmp(signature.methodReturnType, "@") == 0) {
                signature = [[NSNull null] methodSignatureForSelector:@selector(lu_nil)];
            }
            return signature;
        }
        return [self lu_methodSignatureForSelector:aSelector];
    }
    return signature;
}

- (void)lu_forwardInvocation:(NSInvocation *)anInvocation
{
    if (strcmp(anInvocation.methodSignature.methodReturnType, "@") == 0)
    {
        anInvocation.selector = @selector(lu_nil);
        [anInvocation invokeWithTarget:self];
        return;
    }
    
    for (NSObject *object in NSNullObjects)
    {
        if ([object respondsToSelector:anInvocation.selector])
        {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    
    [self lu_forwardInvocation:anInvocation];
}

- (id)lu_nil
{
    return nil;
}

+ (void)lu_swizzleInstanceMethodWithClass:(Class)clazz originalSel:(SEL)original replacementSel:(SEL)replacement
{
    Method originMethod = class_getInstanceMethod(clazz, original);
    Method replaceMethod = class_getInstanceMethod(clazz, replacement);
    if (class_addMethod(clazz, original, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod)))
    {
            class_replaceMethod(clazz, replacement, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));

    } else {
            method_exchangeImplementations(originMethod, replaceMethod);
    }
}

@end
