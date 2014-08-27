//
//  ViewController.m
//  ScrollTabBar
//
//  Created by Amador Navarro Lucas on 19/07/14.
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

#import "ANLTableViewController.h"
#import "ANLTableViewCell.h"
#import "UIViewController+ANLHideNavigationAndTabBars.h"
#import "ANLDetailViewController.h"
#import "ANLData.h"



@interface ANLTableViewController ()

@property (strong, nonatomic) ANLData *nameData;

@end



@implementation ANLTableViewController



#pragma mark - lifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNameData:[ANLData sharedInstance]];
}

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self setTitle:@"TableView"];
    
    [self setScrollViewInheritor:[self tableView]];
    [self setHiddenEnable:YES];
    [self setDuration:0];
}



#pragma mark - dataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString static *identifier = @"reusableCell";
    ANLTableViewCell *cell = (ANLTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSInteger row = [indexPath row] % 28;
    [[cell lblRow] setText:[[[self nameData] imagesNames] objectAtIndex:row]];
    [[cell imgView] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"image%li", (long)row]]];
    
    return cell;
}



#pragma mark - Delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [[segue destinationViewController] setImage:[[sender imgView] image]];
    [[segue destinationViewController] setTitle:[[sender lblRow] text]];
    
    [self showNavigationAndTabBar];
    [self setHiddenEnable:NO];
}



#pragma mark - Actions

- (IBAction)hideButtonPushed:(id)sender {
    
    [self setHiddenEnable:![self isHiddenEnable]];
    NSString *text = [self isHiddenEnable] ? @"HideOff" : @"HideOn";
    [sender setTitle:text];
}

@end
