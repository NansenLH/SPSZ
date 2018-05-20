
/**
 *  直接获得frame的各个值
 *  直接改变frame的各个值
 */

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerx;
@property (nonatomic, assign) CGFloat centery;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat right;
@end


@interface NSArray (Safe)

@end


