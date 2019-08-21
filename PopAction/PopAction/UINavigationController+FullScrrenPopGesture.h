//
//  UINavigationController+FullScrrenPopGesture.h
//  PopAction
//
//  Created by Jiawei Dong on 2019/8/20.
//  Copyright © 2019 Jiawei Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (FullScrrenPopGesture) <UIGestureRecognizerDelegate>

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *fs_fullScrrenPopGesture;


@end

NS_ASSUME_NONNULL_END
