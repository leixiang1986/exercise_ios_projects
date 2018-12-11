//
//  ViewController.m
//  CategoryExcercise
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Test.h"
#import "Person+Test.h"

@interface ViewController ()
@property (nonatomic, strong) Person *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Person *person = [[Person alloc] init];
    {
        Test *test = [[Test alloc] init];
        test.age = 10;
        person.test = test;
        NSLog(@"test age1:%d",person.test.age);
    }
    
    NSLog(@"test age2: %d",person.test.age);
    _person = person;
    
}


@end
