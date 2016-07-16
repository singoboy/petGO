//
//  LoginCtrl.m
//  petShop
//
//  Created by user12 on 2016/7/15.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "LoginCtrl.h"
#import "Member.h"
#import "CoreDataHelper.h"

@interface LoginCtrl ()<UITextFieldDelegate>{
    Member *member ;

}
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation LoginCtrl

// This is workaroud
- (IBAction)login:(id)sender {
    
    NSString * checkString =  [self checkInput];
    if (checkString.length>0) {
        [self showUIAlertCtrl:checkString];
        return ;
    }
    
    // 先 check
    NSString *checkExistString = [self checkExist];
    if ([checkExistString isEqualToString:@"error"]) {
        [self showUIAlertCtrl:@"帳號密碼錯誤"];
        return ;
    }
    
    //check 完  再 get
      NSMutableArray *memberArray = [self getMember];
    //存到coreData
    NSManagedObjectContext *context = [CoreDataHelper sharedInstance].managedObjectContext;
    member= [NSEntityDescription insertNewObjectForEntityForName:@"Member" inManagedObjectContext:context];
    member.memberID = [memberArray[0] valueForKey:@"memberID"];
    member.memberAccount = [memberArray[0] valueForKey:@"memberAccount"];
    member.memberName = [memberArray[0] valueForKey:@"memberName"];
    member.memberAddr=[memberArray[0] valueForKey:@"memberAddr"];
    NSLog(@"member=%@",member);
    [context save:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate showUIAlertCtrl:@"登入成功"];
    
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

-(NSString *)checkExist{

    NSString *result = @"";
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/member_check_get.php"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"account=%@&password=%@",self.accountText.text,self.passwordText.text];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    return  result;
}

-(NSMutableArray *)getMember{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/member_get.php"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"account=%@&password=%@",self.accountText.text,self.passwordText.text];
    NSLog(@"postString=%@",postString);
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError *error = nil;
    
    /* notices 回傳的是 NSARRAY 不是 NSMUTABLEARRAY */
    NSArray  *jsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    if (error != nil) {
        NSLog(@"Error");
    }
    NSMutableArray  *memberValueArray = [jsonArray mutableCopy];
    
    return memberValueArray;

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
