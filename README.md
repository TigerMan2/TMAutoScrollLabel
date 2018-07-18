# YJAutoScrollLabel
iOS 广告滚动效果

#### 例：
    YJAutoScrollLabel *autoScroll = [[YJAutoScrollLabel alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 50) titles:@[@"烧烤假按揭啊放假了",@"456456456",@"了家世界李开复啊",@"司法局爱上了几分爱睡懒觉杀",@"发生加减法是甲方按时令肌肤按时杀戮空间"]];
    autoScroll.isHaveTouchEvent = YES;
    [self.view addSubview:autoScroll];
    [autoScroll beginScroll];
    
#### 还可以获取广告点击的index和文字
    autoScroll.adActionBlock = ^(NSInteger index, NSString *adStr) {
        NSLog(@"-----%ld,-----%@",index,adStr);
    };
