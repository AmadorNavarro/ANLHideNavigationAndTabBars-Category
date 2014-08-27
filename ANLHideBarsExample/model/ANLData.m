//
//  ANLData.m
//  ScrollTabBar
//
//  Created by Amador Navarro Lucas on 20/08/14.
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

#import "ANLData.h"



@implementation ANLData



#pragma mark - class metods

+(instancetype)sharedInstance {
 
    static ANLData *data = nil;
    if (!data) {
        
        data = [[super allocWithZone:nil] init];
    }
    return data;
}

+(NSArray *)dataNames {
    
    return [[self sharedInstance] imagesNames];
}

+(id)allocWithZone:(struct _NSZone *)zone {
    
    return [self sharedInstance];
}



#pragma mark - instance methods

-(id)init {
    
    if (self = [super init]) {
        
        [self setImagesNames:[self configureNames]];
    }
    return self;
}

-(NSArray *)configureNames {
    
    return @[@"Apple I", @"Apple II", @"Apple III", @"AppleTV", @"iBook G4", @"iBook G3", @"iMac 1999", @"iMac 2007", @"iMac 2011", @"iMac 2013", @"iPad mini", @"iPad", @"iPhone 2G", @"iPhone 3G", @"iPhone 4", @"iPhone 5", @"iPhone 5S", @"iPod Classic", @"iPod mini", @"iPod shuffle", @"Lisa", @"mac pro", @"mac cube", @"macBook white", @"macBooks", @"Macintosh plus", @"Macintosh II", @"Newton"];
}

@end
