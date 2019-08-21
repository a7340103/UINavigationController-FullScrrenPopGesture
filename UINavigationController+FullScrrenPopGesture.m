//
//  UINavigationController+FullScrrenPopGesture.m
//  PopAction
//
//  Created by Jiawei Dong on 2019/8/20.
//  Copyright © 2019 Jiawei Dong. All rights reserved.
//

#import "UINavigationController+FullScrrenPopGesture.h"
#import <objc/runtime.h>



@implementation UINavigationController (FullScrrenPopGesture)

+ (void)load{
    Method ori_push = class_getInstanceMethod(self, @selector(pushViewController:animated:));
    Method swi_push = class_getInstanceMethod(self, @selector(fs_pushViewController:animated:));
    method_exchangeImplementations(ori_push, swi_push);
}

- (void)fs_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.fs_fullScrrenPopGesture]) {
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.fs_fullScrrenPopGesture];
        
        NSArray *_targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id target = [_targets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        [self.fs_fullScrrenPopGesture addTarget:target action:internalAction];
        // Disable the onboard gesture recognizer.
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [self fs_pushViewController:viewController animated:animated];
}

- (UIPanGestureRecognizer *)fs_fullScrrenPopGesture{
    UIPanGestureRecognizer *panGesture = objc_getAssociatedObject(self, _cmd);
    if (!panGesture) {
        panGesture = [[UIPanGestureRecognizer alloc] init];
        panGesture.maximumNumberOfTouches = 1;
//        panGesture.delegate = self;
        objc_setAssociatedObject(self, _cmd, panGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return panGesture;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

@end
