//
//  AppDelegate.m
//  SystemShareAndReceiveDoc
//
//  Created by leixiang on 2021/5/20.
//

#import "AppDelegate.h"
//参考：https://www.jianshu.com/p/978d38533c5c
@interface AppDelegate ()<UIDocumentInteractionControllerDelegate>
@property (nonatomic, strong) UIDocumentInteractionController *docVc;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation{
    // 判断传过来的url是否为文件类型
    if ([url.scheme isEqualToString:@"file"]) {
        _docVc = [UIDocumentInteractionController interactionControllerWithURL:url];
        _docVc.delegate = self;
        [_docVc presentPreviewAnimated:YES];
        
    }
    
}

#else
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    // 判断传过来的url是否为文件类型
    if ([url.scheme isEqualToString:@"file"]) {
        _docVc = [UIDocumentInteractionController interactionControllerWithURL:url];
        _docVc.delegate = self;
        [_docVc presentPreviewAnimated:YES];
    }
    return YES;
}
#endif
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}
#pragma mark -- UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    // 返回当前控制器
    return [self getCurrentVC];
}


@end
