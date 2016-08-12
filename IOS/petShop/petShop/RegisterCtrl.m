//
//  RegisterCtrl.m
//  petShop
//
//  Created by user12 on 2016/7/15.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "RegisterCtrl.h"

@interface RegisterCtrl ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation RegisterCtrl
- (IBAction)register:(id)sender {
    
    NSString *checkString =[self checkInput];

    if(checkString.length> 0 ){
        [self showUIAlertCtrl:checkString];
        return ;
    }
    // check account is exis
    if([[self checkAccount] isEqualToString:@"error"]){
        return;
    }
    // insert member
    NSString *addString = [self addAccount];
    if([addString isEqualToString:@"error"]){
        return ;
    }
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate showUIAlertCtrl:@"註冊成功"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountText.delegate = self;
    self.passwordText.delegate = self;
    self.nameText.delegate = self;
    self.addressText.delegate = self;
    
    // Do any additional setup after loading the view.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES ;
}

-(NSString *)checkInput{
    NSString *errString =@"";
    if(self.accountText.text.length == 0){
        errString = [errString stringByAppendingString:@"請輸入帳號,"];
    }
    if(self.passwordText.text.length == 0){
        errString = [errString stringByAppendingString:@"請輸入密碼,"];
    }
    if(self.nameText.text.length == 0){
        errString = [errString stringByAppendingString:@"請輸入名稱,"];
    }
    if(self.addressText.text.length == 0){
        errString = [errString stringByAppendingString:@"請輸入地址"];
    }
    return errString ;

}

-(NSString *)checkAccount{
    NSString *result =@"";
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/member_check.php"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"account=%@",self.accountText.text];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
       result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    if ([result isEqualToString:@"error"]) {
        [self showUIAlertCtrl:@"帳號重複"];
        return @"error";
    }
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)addAccount{
    NSString *result =@"";
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/member_add.php"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"account=%@&password=%@&name=%@&address=%@",self.accountText.text,self.passwordText.text,self.nameText.text,self.addressText.text];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    if ([result isEqualToString:@"error"]) {
        [self showUIAlertCtrl:@"新增帳號失敗"];
        return @"error";
    }
    
    return result;
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
