//
//  ANLScrollViewController.m
//  ScrollTabBar
//
//  Created by Amador Navarro Lucas on 22/08/14.
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

#import "ANLScrollViewController.h"
#import "UIViewController+ANLHideNavigationAndTabBars.h"



@implementation ANLScrollViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[self scrollView] setDelegate:self];
    [self setScrollViewInheritor:[self scrollView]];
    [self setHiddenEnable:YES];
    
    CGFloat widthScreen = [[UIScreen mainScreen] bounds].size.width;
    for (int idx = 0; idx < 50; idx++) {
        
        CGSize size = [[self scrollView] contentSize];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%i", idx % 28]];
        CGRect frame = CGRectMake(0,
                                  size.height,
                                  widthScreen,
                                  [image size].height * (widthScreen / [image size].width));
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
        [imgView setImage:image];
        [[self scrollView] addSubview:imgView];
        [[self scrollView] setContentSize:CGSizeMake(size.width, size.height + [imgView frame].size.height)];
    }
}



#pragma mark - actions

- (IBAction)hideButtonPushed:(id)sender {
    
    [self setHiddenEnable:![self isHiddenEnable]];
    NSString *text = [self isHiddenEnable] ? @"HideOff" : @"HideOn";
    [sender setTitle:text];
}
@end
