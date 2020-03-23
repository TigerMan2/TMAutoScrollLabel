//
//  ViewController.m
//  TMAutoScrollLabel
//
//  Created by edward lannister on 2018/7/18.
//  Copyright © 2018年 edward lannister. All rights reserved.
//

#import "ViewController.h"
#import "TMAutoScrollLabel.h"

@interface ViewController ()

@property (nonatomic, strong) TMAutoScrollLabel *autos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TMAutoScrollLabel *autoScroll = [[TMAutoScrollLabel alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 50) titles:@[@"烧烤假按揭啊放假了",@"456456456",@"了家世界李开复啊",@"司法局爱上了几分爱睡懒觉杀",@"发生加减法是甲方按时令肌肤按时杀戮空间"]];
    self.autos = autoScroll;
    autoScroll.directionType = TMScrollDirectionTypeTop;
    autoScroll.isHaveTouchEvent = YES;
    [self.view addSubview:autoScroll];
    [autoScroll beginScroll];
    
    autoScroll.adActionBlock = ^(NSInteger index, NSString *adStr) {
        NSLog(@"-----%ld,-----%@",index,adStr);
    };
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.autos closeScroll];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
