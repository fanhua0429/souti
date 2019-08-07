//
//  DetailViewController.m
//  souti
//
//  Created by 樊华 on 16/3/30.
//  Copyright © 2018年 fanhua. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithBack:(BOOL)dismiss{

    if (self = [super init]) {
        _dismiss = dismiss;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.picture.frame = CGRectMake(10*Scale_W, 10*Scale_W, kScreenW - 20*Scale_W, 150*Scale_W - 20*Scale_H);
    //self.picture.contentMode = UIViewContentModeScaleAspectFit;
    [self.backgroundView addSubview:self.picture];
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0f green:248/255.0f blue:248/255.0f alpha:1];
    self.title = @"题目详情";
    [self initLeftItem];
    self.content.text = @"上夜班回来，在一楼停车，听见屋里有一小屁孩哭闹不停，他妈妈就骗他说外面有鬼。本着助人为乐的精神，我恐怖的嚎了一嗓子，结果……里面俩人都哭了\n唐僧：“悟空你听我说，最近悟净的行为很奇怪。为师多说了他两句，他就一言不发走开，然后躺进小白龙的食槽里。”悟空：“沙师弟不善言辞，他应该是在用行动表达对您的不满。”“什么意思？”“卧槽！\n走过一处网吧的时候正好赶上JC突击队检查未成年人上网问题。几个小伙子被叫出来排成一队，当JC问到一个平头小伙儿的时候，我恰巧走过。于是听到对话如下。“职业？”“法师。”我用无比崇敬的目光看了他一眼，默默地为他祈祷！\n来学校没带铺盖，借同班一个哥们的被子用了几天。结果来大姨妈，蹭上去好多。于是想周末带回家洗了还给他。周末那天痛经，一直流着眼泪没力气，于是我又找他帮忙拿着去坐车。正巧那男同学他爸来学校看他，结果看到他领着一眼泪汪汪的姑娘，还抱着带血迹的床单。气的直接就一脚把他踹翻在地……";
}
- (void)initLeftItem{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 9, 16);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_bar_normal"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)leftItem{
    
    if (_dismiss == YES) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
