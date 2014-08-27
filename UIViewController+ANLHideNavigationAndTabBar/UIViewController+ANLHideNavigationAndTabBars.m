//
//  UIViewController+HideNavigationAndTabBars.m
//  ScrollTabBar
//
//  Created by Amador Navarro Lucas on 23/08/14.
//  Copyright (c) 2014 Amador Navarro Lucas - @madmak3r
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "UIViewController+ANLHideNavigationAndTabBars.h"
#import <objc/runtime.h>



static const char anlDurationKey;
static const char anlHiddenKey;
static const char anlEnableKey;
static const char anlTimerKey;
static const char anlScrollViewInheritorKey;

@implementation UIViewController (ANLHideNavigationAndTabBars)



#pragma mark - setters and getters

-(void)setDuration:(NSInteger)duration {
    
    NSNumber *durationValue = @(duration);
    objc_setAssociatedObject(self, &anlDurationKey, durationValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSInteger)duration {
    
    return [objc_getAssociatedObject(self, &anlDurationKey) integerValue];
}

-(void)setHidden:(BOOL)hidden {
    
    NSNumber *hiddenValue = @(hidden);
    objc_setAssociatedObject(self, &anlHiddenKey, hiddenValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(BOOL)isHidden {
    
    return [objc_getAssociatedObject(self, &anlHiddenKey) boolValue];
}

-(void)setHiddenEnable:(BOOL)enable {
    
    NSNumber *enableValue = @(enable);
    objc_setAssociatedObject(self, &anlEnableKey, enableValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(BOOL)isHiddenEnable {
    
    return [objc_getAssociatedObject(self, &anlEnableKey) boolValue];
}

-(void)setTimer:(NSDate *)timer {
    
    objc_setAssociatedObject(self, &anlTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSDate *)timer {
    
    return objc_getAssociatedObject(self, &anlTimerKey);
}

-(void)setScrollViewInheritor:(UIScrollView *)scrollView {
    
    if ([scrollView isKindOfClass:[UIScrollView class]]) {
        
        objc_setAssociatedObject(self, &anlScrollViewInheritorKey,
                                 scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self setDuration:2];
    [self setHidden:NO];
}

-(UIScrollView *)scrollViewInheritor {
    
    return objc_getAssociatedObject(self, &anlScrollViewInheritorKey);
}



#pragma mark - scrollView delegate methods

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([self isHidden] && [self isHiddenEnable]) {
        
        [self setTimer:[NSDate date]];
        [self performSelector:@selector(hiddenTabAndNavigationBar:) withObject:NO afterDelay:[self duration]];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self setTimer:nil];
    if (![self isHidden] && [self isHiddenEnable]) {
        
        [self hiddenTabAndNavigationBar:YES];
    }
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if (CGPointEqualToPoint(velocity, CGPointZero)) {
        
        [self scrollViewDidEndDecelerating:scrollView];
    }
}



#pragma mark - public methods

-(void)showNavigationAndTabBar {
    
    if ([self isHidden]) {
        
        [self setTimer:[NSDate dateWithTimeIntervalSinceNow:-[self duration]]];
        [self hiddenTabAndNavigationBar:NO];
    }
}



#pragma mark - private methods

- (void)hiddenTabAndNavigationBar:(BOOL)hidden {
    
    if ([self isHidden] == hidden) return;
    if ([[NSDate date] timeIntervalSinceDate:[self timer]] < [self duration]) return;
    
    [self setTimer:nil];
    [self setHidden:hidden];
    [[self navigationController] setNavigationBarHidden:hidden animated:YES];
    
    UITabBar *tabBar = [[self tabBarController] tabBar];
    UIScrollView *scrollView = [self scrollViewInheritor];
    
    CGPoint tabBarCenter = tabBar ? [tabBar center] : CGPointZero;
    CGFloat height = tabBar ? [tabBar frame].size.height : 0;
    CGPoint newCenter = CGPointMake(tabBarCenter.x, tabBarCenter.y + (hidden ? height : -height));
    
    if (!hidden && scrollView) {
        
        CGPoint offSet = [scrollView contentOffset];
        [scrollView setContentOffset:CGPointMake(offSet.x, offSet.y + 44.5)];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [tabBar setCenter:newCenter];
    }];
}

@end
