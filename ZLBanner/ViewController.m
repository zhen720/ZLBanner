//
//  ViewController.m
//  ZLBanner
//
//  Created by liuzhen on 30/03/2017.
//  Copyright © 2017 liuzhen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat globleWidth;
@property (nonatomic, strong) NSMutableArray *muArrayImages;
@property (nonatomic, strong) NSMutableArray *pageArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.mainScroll.backgroundColor = [UIColor redColor];
    self.pageControl.backgroundColor = [UIColor clearColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    self.pageControl.pageIndicatorTintColor = [UIColor redColor];
    
    self.globleWidth = self.view.frame.size.width;
    //page的个数
    self.pageArr = [NSMutableArray array];
    for (int i = 1; i <= 3; i++) {
        [self.pageArr addObject:[NSString stringWithFormat:@"%d.png",i]];
    }
    //重新获取imgView的个数，将显示的第最后一张图片放在第一张，而在最后一张放置显示的第一张图片
    self.muArrayImages = [NSMutableArray array];
    [self.muArrayImages addObject:self.pageArr[self.pageArr.count - 1]];
    for (NSString *imgSrc in self.pageArr) {
        [self.muArrayImages addObject:imgSrc];
    }
    [self.muArrayImages addObject:self.pageArr[0]];
    self.mainScroll.contentSize = CGSizeMake(self.globleWidth*self.muArrayImages.count, 0);
    //开始塞入图片
    for (int i = 0; i < self.muArrayImages.count; i++) {
        NSString *imgSrc = self.muArrayImages[i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.globleWidth, 0, self.globleWidth, 200)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [imgView setImage:[UIImage imageNamed:imgSrc]];
        imgView.backgroundColor = [UIColor grayColor];
        [self.mainScroll addSubview:imgView];
    }
    self.pageControl.numberOfPages = self.pageArr.count;
    self.mainScroll.bounces = NO;
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.showsHorizontalScrollIndicator = NO;
    self.mainScroll.showsVerticalScrollIndicator = NO;
    self.mainScroll.delegate = self;
    //自动将scrollView移动显示的第一张图片处
    [self.mainScroll setContentOffset:CGPointMake(self.globleWidth, 0) animated:NO];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mainScroll.contentSize = CGSizeMake(self.globleWidth*self.muArrayImages.count, 0);
}
- (void)viewDidLayoutSubviews
{
    self.mainScroll.contentSize = CGSizeMake(self.globleWidth*self.muArrayImages.count, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    int index = offsetX/self.globleWidth;
    if (index == 0) {
        [self.mainScroll setContentOffset:CGPointMake(self.globleWidth*(self.muArrayImages.count-2), 0) animated:NO];
        self.pageControl.currentPage = self.pageArr.count - 1;
    }else if (index == self.muArrayImages.count -1){
        [self.mainScroll setContentOffset:CGPointMake(self.globleWidth, 0) animated:NO];
        self.pageControl.currentPage = 0;
    }else{
        self.pageControl.currentPage = index - 1;
    }
    
}

@end
