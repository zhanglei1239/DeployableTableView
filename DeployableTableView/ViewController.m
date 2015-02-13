//
//  ViewController.m
//  DeployableTableView
//
//  Created by highcom on 15-2-12.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.containArray = [NSMutableArray array];
    
    [self initData:[self getData]];
    
    self.utDeploy = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    [self.view addSubview:self.utDeploy];
    self.utDeploy.delegate = self;
    self.utDeploy.dataSource = self;
    
}

-(void)initData:(NSMutableArray *)temp{
    
    self.listArr = [NSMutableArray array];
    self.allDataArr = [[NSMutableDictionary alloc] init];
    int i = 0;
    for (NSString * key in self.keyArray) {
        [self.allDataArr setObject:[temp objectAtIndex:i] forKey:key];
        i++;
    }
    
    [self resetData];
    
}

-(NSMutableArray *)getData{
    
    self.keyArray = [NSMutableArray array];
    
    self.dataArr1 =  [NSMutableArray array];
    
    self.dataArr2 = [NSMutableArray array];
    
    self.dataArr3 = [NSMutableArray array];
    
    [self.keyArray addObject:@"1.拿着录取通知书和材料准备办理入学"];
    [self.keyArray addObject:@"2.办理入学之后的学生信息等级"];
    [self.keyArray addObject:@"3.根据等级之后的学生信息领取学生物品"];
    
    [self.dataArr1 addObject:@"1.录取通知书"];
    [self.dataArr1 addObject:@"2.一寸照片3张"];
    [self.dataArr1 addObject:@"3.身份证"];
    [self.dataArr1 addObject:@"4.录取学号"];
    [self.dataArr1 addObject:@"5.录取专业号"];
    
    [self.dataArr2 addObject:@"1.录取学院"];
    [self.dataArr2 addObject:@"2.录取专业"];
    [self.dataArr2 addObject:@"3.录取学区"];
    [self.dataArr2 addObject:@"4.录取班级"];
    
    [self.dataArr3 addObject:@"1.领取被褥"];
    [self.dataArr3 addObject:@"2.领取学生卡"];
    [self.dataArr3 addObject:@"3.领取校服"];
    [self.dataArr3 addObject:@"4.领取宿舍钥匙"];
    
    NSMutableArray * temp = [NSMutableArray array];
    
    [temp addObject:self.dataArr1];
    [temp addObject:self.dataArr2];
    [temp addObject:self.dataArr3];
  
    return temp;
}

-(void)resetData{
    [self.listArr removeAllObjects];
    for (int i = 0; i<[self.keyArray count]; i++) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
         [dic setObject:[NSMutableArray array] forKey:[self.keyArray objectAtIndex:i]];
         [self.listArr addObject:dic];
    }
}

-(void)tapAction:(UIButton *)sender{
    
    if ([self.containArray containsObject:[NSString stringWithFormat:@"%ld",sender.tag]]) {
        [self.containArray removeObject:[NSString stringWithFormat:@"%ld",sender.tag]];
    }else{
        [self.containArray addObject:[NSString stringWithFormat:@"%ld",sender.tag]];
    }
    
    [self filterData];
    [self.utDeploy reloadData];
}

-(void)filterData{
    [self resetData];
    for (NSString * key in self.containArray) {
        NSDictionary * dic =  [self.listArr objectAtIndex:[key intValue]];
        for (NSString * keyString in [dic allKeys]) {
            NSMutableDictionary * dicn = [[NSMutableDictionary alloc] init];
            NSMutableArray * arr = [dic objectForKey:keyString];
            arr = [self.allDataArr objectForKey:keyString];
            [dicn setObject:arr forKey:keyString];
            [self.listArr removeObjectAtIndex:[key intValue]];
            [self.listArr insertObject:dicn atIndex:[key intValue]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *tempV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50)];
    tempV.backgroundColor = [UIColor colorWithRed:(236)/255.0f green:(236)/255.0f blue:(236)/255.0f alpha:1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(16, 2, 240, 40)];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont fontWithName:@"Arial" size:16];
    label1.text = [[self.listArr[section] allKeys] objectAtIndex:0];
    label1.numberOfLines = 2;
    UIImageView *tempImageV = [[UIImageView alloc]initWithFrame:CGRectMake(286, 20, 20, 11)];
    
    if ([self.containArray containsObject:[NSString stringWithFormat:@"%ld",section]]) {
        tempImageV.image = [UIImage imageNamed:@"close"];
    }else{
        tempImageV.image = [UIImage imageNamed:@"open"];
    }
    
    ///给section加一条线。
    CALayer *_separatorL = [CALayer layer];
    _separatorL.frame = CGRectMake(0.0f, 49.0f, [UIScreen mainScreen].bounds.size.width, 1.0f);
    _separatorL.backgroundColor = [UIColor lightGrayColor].CGColor;
    
    [tempV addSubview:label1];
    [tempV addSubview:tempImageV];
    [tempV.layer addSublayer:_separatorL];
    
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempBtn.frame = CGRectMake(0, 0, 320, 50);
    [tempBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    tempBtn.tag = section;
    [tempV addSubview:tempBtn];
    return tempV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

#pragma mark -- UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    NSMutableDictionary * dic = [self.listArr objectAtIndex:indexPath.section];
    NSMutableArray * arr;
    
    for (NSString * key in [dic allKeys]) {
        arr = [dic objectForKey:key];
        break;
    }
    NSString * str = [arr objectAtIndex:indexPath.row];
    cell.textLabel.text = str;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.listArr count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableDictionary * dic = [self.listArr objectAtIndex:section];
    NSMutableArray * arr;
    for (NSString * key in [dic allKeys]) {
        arr = [dic objectForKey:key];
        break;
    }
    return [arr count];
}

@end
