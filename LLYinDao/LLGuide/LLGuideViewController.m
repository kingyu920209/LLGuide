//
//  LLGuideViewController.m
//  LLYinDao
//
//  Created by 嘚嘚以嘚嘚 on 2018/5/21.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "LLGuideViewController.h"
#import "UIView+Frame.h"

#define WINSIZE [UIScreen mainScreen].bounds.size

#define imageViewW 60
#define imageViewH 46
#define titleLabW 200
@interface LLGuideViewController ()
@property (nonatomic, strong) UIButton * llBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) NSMutableArray *framesArr;
@property (nonatomic, strong) NSMutableArray *titlesArr;

@property (nonatomic, assign) CGFloat titleLabH;
@end

@implementation LLGuideViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.llBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.llBtn addTarget:self action:@selector(llBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.llBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
//    self.llBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.llBtn];
}
- (void)llBtnAction{
    [self upDataBtnFrame];

}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor=[UIColor colorWithWhite:0 alpha:0.4];
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.titlesArr) {
        self.titlesArr = [self.titles mutableCopy];
        
    }
    if (!self.framesArr) {
        self.framesArr = [self.frames mutableCopy];
    }
    [self upDataBtnFrame];
}
- (void)upDataBtnFrame{
    
    if (self.titlesArr.count>0&&self.framesArr.count>0) {
        CGRect rect = CGRectFromString(self.framesArr.firstObject);
        self.llBtn.x = rect.origin.x;
        self.llBtn.y = rect.origin.y;
        
        if (rect.size.width>0) {
            self.llBtn.width = rect.size.width;
        }else{
            self.llBtn.width = WINSIZE.width/375*120;
        }
        if (rect.size.height>0) {
            self.llBtn.height = rect.size.height;
        }
        [self.view layoutIfNeeded];
        [self.framesArr removeObjectAtIndex:0];
        
        self.titleLab.text = [self.titlesArr firstObject];
        [self.titlesArr removeObjectAtIndex:0];
        [self resetSubViewsFrameWithBtnFrame:self.llBtn.frame];

    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


- (void)resetSubViewsFrameWithBtnFrame:(CGRect)frame{
    CGFloat centerX = WINSIZE.width/2;
    CGFloat centerY = WINSIZE.height/2;
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;
    CGFloat btnW = frame.size.width;
    CGFloat btnH = frame.size.height;
    
    CGFloat arrowsX;
    CGFloat arrowsY;
    CGFloat titleLabX;
    CGFloat titleLabY;
    self.titleLabH = [self labelHeightFromeString:self.titleLab.text with:titleLabW];

    CGFloat angle;
    if (x<centerX && y<centerY) {
        //左上
        //箭头旋转180‘
        angle = M_PI;
        arrowsX = x+btnW/2;
        arrowsY = y+btnH;
        titleLabX = arrowsX+imageViewW;
        titleLabY = arrowsY;
        
    }else if(x>=centerX && y<=centerY){
        //右上
        //箭头旋转-90‘
        angle = -M_PI_2;
        arrowsX = x-imageViewW/2;
        arrowsY = y+btnH;
        titleLabX = arrowsX-titleLabW/2;
        titleLabY = arrowsY+imageViewH;
        
        
    }else if(x>=centerX && y>=centerY){
        //右下
        //箭头不旋转
        angle = 0;
        arrowsX = x;
        arrowsY = y-imageViewH;
        titleLabX = arrowsX-titleLabW+20;
        titleLabY = arrowsY-self.titleLabH+20;
        
        
    }else if(x<centerX && y>centerY){
        //左下
        angle = M_PI_2;
        arrowsX = x+imageViewW/2;
        arrowsY = y-btnH;
        titleLabX = arrowsX;
        titleLabY = arrowsY-self.titleLabH;
        
        
    }
    self.imageView.transform = CGAffineTransformMakeRotation(angle);
    self.imageView.frame = CGRectMake(arrowsX, arrowsY, imageViewW, imageViewH);
    self.titleLab.frame = CGRectMake(titleLabX, titleLabY, titleLabW, self.titleLabH);
    [self.view addSubview:self.imageView];
    [self startArrowsAnimation];
    [self.view addSubview:self.titleLab];
    //[self.view layoutSubviews];
    [self.view layoutIfNeeded];
}
/**
 * @desc根据字符串和宽度计算高度
 */
- (CGFloat)labelHeightFromeString:(NSString *)string with:(CGFloat)with
{
    CGRect tmpsize = [string boundingRectWithSize:CGSizeMake(with, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Wawati SC" size:24]} context:nil];
    return tmpsize.size.height;
}
- (void)startArrowsAnimation{
    
    if (self.imageView.animationImages == nil) {
        NSMutableArray *images = [[NSMutableArray alloc]init];
        for (int i = 1; i<=8; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat: @"userGuide_arrors%d",i]];
            [images addObject:image];
        }
        self.imageView.animationImages = images;
        self.imageView.animationDuration = 0.6;
        self.imageView.animationRepeatCount = 0;
    }
    
    [self.imageView startAnimating];
}
- (void)stopArrowsAnimation{
    if ([self.imageView isAnimating]) [self.imageView stopAnimating];
}

-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab =[[UILabel alloc]init];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.numberOfLines = 0;
        _titleLab.font = [UIFont fontWithName:@"Wawati SC" size:24];
        _titleLab.text = @"这是一个新功能，这个功能很牛逼啊很牛B";
    }
    return _titleLab;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
