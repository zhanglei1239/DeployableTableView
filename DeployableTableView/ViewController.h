//
//  ViewController.h
//  DeployableTableView
//
//  Created by highcom on 15-2-12.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) int selected;
@property (nonatomic,retain) UITableView * utDeploy;
@property (nonatomic,retain) NSMutableArray * keyArray;
@property (nonatomic,retain) NSMutableArray * listArr;
@property (nonatomic,retain) NSMutableArray * containArray;
//@property (nonatomic,retain) NSMutableArray * allDataArr;
@property (nonatomic,retain) NSMutableArray * dataArr1;
@property (nonatomic,retain) NSMutableArray * dataArr2;
@property (nonatomic,retain) NSMutableArray * dataArr3;
@property (nonatomic,retain) NSMutableDictionary * allDataArr;  
@end

