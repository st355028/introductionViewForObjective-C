//
//  ViewController.m
//  introAndGuideView
//
//  Created by MinYeh on 2016/8/3.
//  Copyright © 2016年 MINYEH. All rights reserved.
//

#import "ViewController.h"




@interface ViewController ()<UIScrollViewDelegate>
{
    double width;
    double height;
    UIButton * goButton;
}
@property (weak, nonatomic) IBOutlet UIScrollView *guideScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@end

@implementation ViewController


#pragma mark viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    //抓取螢幕寬、高
    width  = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    self.guideScrollView.delegate = self;
    [self setScrollView];
    [self setGoButton];
}

#pragma mark 頁面停止滑動觸發
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int currentPage = self.guideScrollView.contentOffset.x / width;
    
    self.pageController.currentPage = currentPage;
}

#pragma mark 設定scrollView

-(void)setScrollView{
    
    self.guideScrollView.contentSize = CGSizeMake(width*3.0, height);
    
    for(int i=1;i<=3;i++){
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(width * (i-1), 0, width, height)];
        
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"page%d.jpg",i]];
        
        [self.guideScrollView addSubview:imageView];
    }
}

#pragma mark 設定按鈕
-(void)setGoButton{
    
    goButton = [[UIButton alloc]initWithFrame:CGRectMake(width * 2.0, height - 100.0, 100, 35)];
    
    goButton.center = CGPointMake(self.view.center.x + 2*width, height - 100.0);

    
    //讓按鈕垂直置中在頁面
    //goButton.center.x = self.view.center.x + 2*width
    [goButton setBackgroundImage:[UIImage imageNamed:@"bg.png"] forState:UIControlStateNormal];
    
    [goButton setTitle:@"開始體驗" forState:UIControlStateNormal];
    
    //forState: UIControlState.Normal (Normal代表控制元件狀態為尚未被使用)
    [goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //forState: UIControlState.Highlighted (Highlighted代表控制元件狀態為正在被點選或使用中)
    [goButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [goButton addTarget:self action:@selector(goMainPage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.guideScrollView addSubview:goButton];
    
    }

#pragma mark 實作跳轉功能
-(void) goMainPage{
    
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"mainPage"];
    [self presentViewController:vc animated:true completion:nil];
}

#pragma mark didReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
