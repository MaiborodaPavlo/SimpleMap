//
//  ViewController.m
//  SimpleMap
//
//  Created by Pavel on 01.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "ViewController.h"
#import "PMStudent.h"
#import <MapKit/MapKit.h>

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *studentsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.studentsArray = [NSMutableArray array];
    NSInteger count = arc4random() % 31 + 10;
    
    for (int i = 0; i < count; i++) {
        [self.studentsArray addObject: [PMStudent randomStudent]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
