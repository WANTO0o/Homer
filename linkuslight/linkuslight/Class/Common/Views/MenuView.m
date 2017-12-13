//
//  MenuView.m
//  gradeSystem
//
//  Created by jery on 16/1/4.
//  Copyright © 2016年 J.C. All rights reserved.
//

#import "MenuView.h"

@interface MenuView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, assign)CGRect TbViewFrame;

@property(nonatomic, assign)BOOL isShow;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)NSMutableArray *optionsArray;

@property(nonatomic, copy)NSString *optionStr;

@property(nonatomic, assign)CGFloat height;

@end

@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        CGRect frame;
        
        frame = self.frame;
        
        frame.origin.x = 0;
        
        frame.origin.y = 0;
        
        self.TbViewFrame = frame;
        
        self.height = frame.size.height;
        
        [self createUI];
        
    }
    
    return self;
}

- (void)createUI
{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.TbViewFrame style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.bounces = NO;
    
    self.tableView.separatorStyle = 0;
    
    [self addSubview:self.tableView];
    
    
}

- (void)MenuOptionsCount:(NSArray *)countArray
{
    
    self.optionsArray = (NSMutableArray *)countArray;
    
}

#pragma mark --UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.isShow) {
        
        [UIView animateWithDuration:0.4f animations:^{
            
            CGRect tableViewFrame = self.tableView.frame;
            
            tableViewFrame.size.height = (self.optionsArray.count + 1) * self.height;
            
            self.tableView.frame = tableViewFrame;
            
            CGRect frame = self.frame;
            
            frame.size.height = (self.optionsArray.count + 1) * self.height;
            
            self.frame = frame;
            
        }];
        
        return self.optionsArray.count;
        
    } else {
        
        [UIView animateWithDuration:0.4f animations:^{
            
            CGRect tableViewFrame = self.tableView.frame;
            
            tableViewFrame.size.height =  self.height;
            
            self.tableView.frame = tableViewFrame;
            
            CGRect frame = self.frame;
            
            frame.size.height = self.height;
            
            self.frame = frame;
            
        }];
        
        return 0;
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *menuCell = @"menuCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:menuCell];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCell];
        
    }
    
    cell.textLabel.text = self.optionsArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.height;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return self.height;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UILabel *label = (UILabel *)[self viewWithTag:101];
    
    label.text = self.optionsArray[indexPath.row];
    
    self.optionStr = self.optionsArray[indexPath.row];
    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect tableViewFrame = self.tableView.frame;
        
        tableViewFrame.size.height =  self.height;
        
        self.tableView.frame = tableViewFrame;
        
        CGRect frame = self.frame;
        
        frame.size.height = self.height;
        
        self.frame = frame;
        
    }];
    
    self.isShow = NO;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    self.view = [[UIView alloc]initWithFrame:self.TbViewFrame];
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    
    self.view.layer.borderWidth = 1;
    
    self.view.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    self.view.layer.cornerRadius = 5;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, self.view.frame.size.width - 20, 30)];
    
    label.tag = 101;
    
    label.text = self.optionStr;
    
    [self.view addSubview:label];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:sel_registerName("tapMenu:")];
    
    [self.view addGestureRecognizer:tap];
    
    return self.view;
    
}

- (void)tapMenu:(UITapGestureRecognizer *)tap
{
    
    if (self.isShow) {
        
        self.isShow = NO;
        
    } else {
        
        self.isShow = YES;
        
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    
}

@end
