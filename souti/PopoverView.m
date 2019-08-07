//
//  PopoverView.m
//  souti
//
//  Created by 周红敏 on 16/3/30.
//  Copyright © 2016年 zhangyanjiang. All rights reserved.
//

#import "PopoverView.h"

#define  LeftView 10.0f
#define  TopToView 10.0f

@interface PopoverView()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *selectData;
@property (strong, nonatomic) void(^action)(NSInteger index);
@property (nonatomic, strong) UIImageView *containerView;

@end

PopoverView * backgroundView;
UITableView *tableView;

@implementation PopoverView

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

+ (void)addPellTableViewSelectWithWindowFrame:(CGRect)frame
                                   selectData:(NSArray *)selectData
                                       action:(void(^)(NSInteger index))action animated:(BOOL)animate{
    if (backgroundView != nil) {
        [PopoverView hiden];
    }
    UIWindow *win = [[[UIApplication sharedApplication]windows] firstObject];
    backgroundView = [[PopoverView alloc] initWithFrame:win.bounds];
    backgroundView.action = action;
    backgroundView.selectData = selectData;
    backgroundView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.3];
    [win addSubview:backgroundView];
    
    // tableView
    CGRect rect = CGRectMake([UIScreen mainScreen].bounds.size.width - 80 , 70.0 -  20.0 * selectData.count , frame.size.width, 40 * selectData.count);
    tableView = [[UITableView alloc] initWithFrame:rect style:0];
    tableView.delegate = backgroundView;
    tableView.dataSource = backgroundView;
    tableView.layer.cornerRadius = 5.0f;
    

    // 定点
    tableView.layer.anchorPoint = CGPointMake(1.0, 0);
    tableView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    tableView.rowHeight = 40;
    [win addSubview:tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBackgroundClick)];
    [backgroundView addGestureRecognizer:tap];
    
    if (animate == YES) {
        [UIView animateWithDuration:0.3 animations:^{
            //backgroundView.alpha = 0.5;
            tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
}
+ (void)tapBackgroundClick{

    [PopoverView hiden];
}
+ (void)hiden{

    if (backgroundView != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            tableView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
            tableView.alpha = 0.0f;
            //backgroundView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
            backgroundView.alpha = 0.0f;
            
        }completion:^(BOOL finished) {
            [backgroundView removeFromSuperview];
            [tableView removeFromSuperview];
            tableView = nil;
            backgroundView = nil;
        }];
    }
}
#pragma mark - 表格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _selectData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _selectData[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    [cell setSeparatorInset:UIEdgeInsetsZero];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.action) {
        self.action(indexPath.row);
    }
    [PopoverView hiden];
}
#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect{
    //设置背景色
    [[UIColor whiteColor] set];

    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    CGContextBeginPath(context);
    CGFloat location = [UIScreen mainScreen].bounds.size.width ;
    CGContextMoveToPoint(context, location - LeftView -10, 70);//设置起点
    CGContextAddLineToPoint(context, location - 2*LeftView - 10 ,  60);
    CGContextAddLineToPoint(context, location - TopToView * 3 - 10, 70);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [[UIColor whiteColor] setFill];  //设置填充色
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path

}





@end
