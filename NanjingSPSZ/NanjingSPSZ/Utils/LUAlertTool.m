//
//  LUAlertTool.m
//  MyAlertTool
//
//  Created by nansen on 2016/12/7.
//  Copyright © 2016年 nansen. All rights reserved.
//

#import "LUAlertTool.h"

#define canUseAlertController ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


static LUAlertTool *_defaultTool = nil;

@interface LUAlertTool () <UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic, copy) void(^alertBlock)();

@property (nonatomic, strong) NSMutableArray *sheetActionsArray;

@end


@implementation LUAlertTool

- (NSMutableArray *)sheetActionsArray
{
    if (!_sheetActionsArray) {
        _sheetActionsArray = [NSMutableArray array];
    }
    return _sheetActionsArray;
}

+ (instancetype)defaultTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultTool = [[LUAlertTool alloc] init];
    });
    return _defaultTool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)Lu_alertInViewController:(UIViewController *)vc
                           title:(NSString *)title
                         message:(NSString *)message
               cancelButtonTitle:(NSString *)cancelTitle
{
    [self Lu_alertActionInViewController:vc title:title message:message cancelButtonTitle:cancelTitle actionButtonTitle:nil actionBlock:nil];
}


- (void)Lu_alertActionInViewController:(UIViewController *)vc
                                 title:(NSString *)title
                               message:(NSString *)message
                     cancelButtonTitle:(NSString *)cancelTitle
                     actionButtonTitle:(NSString *)actionTitle
                           actionBlock:(void(^)(void))actionBlock
{
    if (canUseAlertController) {
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
        [alertControl addAction:action];
        
        if (actionTitle) {
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (actionBlock) {
                    actionBlock();
                }
            }];
            [alertControl addAction:action2];
        }
        
        [vc.view endEditing:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc presentViewController:alertControl animated:YES completion:nil];
        });
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:actionTitle, nil];
        if (actionBlock) {
            self.alertBlock = actionBlock;
        }
        [vc.view endEditing:YES];
        [alertView show];
    }
}


/**
 选择框Sheet
 */
- (void)Lu_actionSheetInViewController:(UIViewController *)vc
                                 title:(NSString *)title
                    actionButtonTitles:(NSArray *)actionTitles
                          actionBlocks:(NSArray *)actionBlocks
{
    if (canUseAlertController)
    {
        UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        for (int i = 0; i < actionTitles.count; i++) {
            NSString *actionTitle = actionTitles[i];
            void(^actionBlock)(void) = actionBlocks[i];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (actionBlock) {
                    actionBlock();
                }
            }];
            
            [sheetController addAction:action];
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [sheetController addAction:cancelAction];
        
        [vc presentViewController:sheetController animated:YES completion:nil];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:title
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:nil,nil];
        
        for (NSString *btnTitle in actionTitles) {
            [actionSheet addButtonWithTitle:btnTitle];
        }
        
        for (void(^actionBlock)(void) in actionBlocks) {
            [self.sheetActionsArray addObject:actionBlock];
        }
        
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        [actionSheet showInView:vc.view];
    }
}



#pragma mark - ======== UIAlertViewDelegate ========
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.alertBlock && buttonIndex == 1) {
        self.alertBlock();
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.alertBlock = nil;
}

#pragma mark - ======== UIActionSheetDelegate ========
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex > 0) {
        void(^actionBlock)(void) = self.sheetActionsArray[buttonIndex-1];
        actionBlock();
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.sheetActionsArray removeAllObjects];
}


//有取消按钮的
+(UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message  confirmHandler:(void(^)(UIAlertAction *))confirmHandler cancleHandler:(void(^)(UIAlertAction *))cancleHandler viewController:(UIViewController *)vc
{
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:confirmHandler];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancleHandler];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancleAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
    
}

@end
