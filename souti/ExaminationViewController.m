//
//  ExaminationViewController.m
//  souti
//
//  Created by 周红敏 on 16/3/30.
//  Copyright © 2016年 zhangyanjiang. All rights reserved.
//

#import "ExaminationViewController.h"
#import "ExaminationViewCell.h"
#import "DetailViewController.h"
#import "PopoverView.h"

@interface ExaminationViewController ()<UITableViewDelegate, UITableViewDataSource>{

    UIBarButtonItem *leftItem;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *objects;

@end

@implementation ExaminationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1];
    self.title = @"我的题库";
    // 存储数据模型
    self.objects = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    
    
    [self initLeftItem];
    [self initRightItem];
    
    [self initTableView];
    
    if (self.objects.count == 0) {
        [self.tableView removeFromSuperview];
        // 没有搜题图片的情况下视图
        [self initEmptyView];
    }
}
- (void)initLeftItem{

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 9, 16);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_bar_normal"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    
    leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)leftItem{

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initRightItem{

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 18, 4);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"gengduo"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)more{

    [PopoverView addPellTableViewSelectWithWindowFrame:CGRectMake(0, 64, 150*Scale_W, 200*Scale_H) selectData:@[@"批量管理题目",@"删除全部题目"] action:^(NSInteger index) {
        NSLog(@"选择%ld",index);
        if (index == 0) {

            //[self.tableView setEditing:YES animated:YES];
            [self.tableView setEditing:!self.tableView.editing animated:YES];
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelTableEditClick:)];
            self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
        }else{
            NSString *title = @"确定删除所有题目？";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.objects removeAllObjects];
                [self.tableView removeFromSuperview];
                [self initEmptyView];
            }];
            [alert addAction:action1];
            [alert addAction:action2];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } animated:YES];

}
- (void)cancelTableEditClick:(id)sender{
    [self.tableView setEditing:NO animated:YES];
    self.navigationItem.leftBarButtonItem = leftItem;
}
#pragma mark - 空的时候的view
- (void)initEmptyView{
    
    UILabel *emptyLabel = [[UILabel alloc]init];
    emptyLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 21*Scale_H);
    emptyLabel.center = CGPointMake(self.view.center.x, self.view.center.y-30*Scale_H);
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    emptyLabel.text = @"心塞，竟然还没有搜题，作业都做完噜？";
    emptyLabel.font = [UIFont systemFontOfSize:15*Scale_W];
    emptyLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:emptyLabel];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(0, 0, 80*Scale_H, 80*Scale_H);
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y-90*Scale_H);
    imageView.image = [UIImage imageNamed:@"houzi.jpg"];
    [self.view addSubview:imageView];
}
#pragma mark - 表格
- (void)initTableView{
    
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width-0, self.view.frame.size.height - 64);
    self.tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor clearColor];
    UIView *footView = [[UIView alloc]init];
    footView.frame = CGRectMake(0, 0, self.view.frame.size.width, 10);
    self.tableView.tableFooterView = footView;
    [self.tableView registerNib:[UINib nibWithNibName:@"ExaminationViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.objects.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 170*Scale_H;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExaminationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DetailViewController *detailVc = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:detailVc animated:YES];
}
#pragma mark - 表格编辑式的两问一答
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        if (self.objects.count == 0) {
            [self initEmptyView];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
    }
}

#pragma mark - 警告内存处理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}


@end
