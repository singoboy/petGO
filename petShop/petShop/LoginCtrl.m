//
//  LoginCtrl.m
//  petShop
//
//  Created by user12 on 2016/7/15.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "LoginCtrl.h"

@interface LoginCtrl ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation LoginCtrl
- (IBAction)login:(id)sender {
    
    NSString * checkString =  [self checkInput];
    if (checkString.length>0) {
        [self showUIAlertCtrl:checkString];
        return ;
    }
    
    
    
    
}

-(NSString *)checkInput{
    NSString *errString = @"";
    if (self.accountText.text.length == 0) {
        errString = [errString stringByAppendingString:@"請輸入帳號,"];
    }
    if (self.passwordText.text.length == 0) {
        errString = [errString stringByAppendingString:@"請輸入密碼"];
    }
    
    return errString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountText.delegate =self ;
    self.passwordText.delegate = self ;
    // Do any additional setup after loading the view.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showUIAlertCtrl:(NSString *)message{
    
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"提示" message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction =
    [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
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
