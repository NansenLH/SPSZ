

#import "UIView+Extension.h"
#import <objc/runtime.h>

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterx:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerx
{
    return self.center.x;
}

- (void)setCentery:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centery
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

@end


@implementation NSArray (Safe)

+ (void)load
{
    // 选择器
    SEL safeSel = @selector(safeObjectAtIndex:);
    SEL unsafeSel = @selector(objectAtIndex:);
    
    Class class = NSClassFromString(@"__NSArrayI");
    // 方法
    Method safeMethod = class_getInstanceMethod(class, safeSel);
    Method unsafeMethod = class_getInstanceMethod(class, unsafeSel);
    
    // 交换方法
    method_exchangeImplementations(unsafeMethod, safeMethod);
}

- (id)safeObjectAtIndex:(NSUInteger)index
{
    // 数组越界也不会崩，但是开发的时候并不知道数组越界
    if (index > (self.count - 1)) { // 数组越界
        NSAssert(NO, @"数组越界了"); // 只有开发的时候才会造成程序崩了
        return nil;
    }else { // 没有越界
        return [self safeObjectAtIndex:index];
    }
}


@end




