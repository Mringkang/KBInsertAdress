//
//  ViewController.m
//  iosInsertAddress
//
//  Created by kangbing on 16/9/2.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import "ViewController.h"
#import "AddressBookTool.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}
- (IBAction)insert:(id)sender {
    
    
    [AddressBookTool insertAnContentName:self.textName.text andWithPhoneNum:self.phoneNum.text];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
