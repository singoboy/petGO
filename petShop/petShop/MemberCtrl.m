//
//  MemberCtrl.m
//  petShop
//
//  Created by user12 on 2016/7/15.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "MemberCtrl.h"
#import "RegisterCtrl.h"
#import "LoginCtrl.h"
#import "Member.h"
#import "CoreDataHelper.h"



@interface MemberCtrl ()
{
    Member *member ;

}
@property (weak, nonatomic) IBOutlet UILabel *memberText;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;

@end

@implementation MemberCtrl



- (void)viewDidLoad {
    [super viewDidLoad];
    self.memberText.text = [NSString stringWithFormat:@"未登入"];
    self.totalAmount.text = @"0";
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    //query from coredata
    NSManagedObjectContext *context = [CoreDataHelper sharedInstance].managedObjectContext;
    //要抓取的物件
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Member"];

    NSError *error = nil ;
    //執行查詢後的結果
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"getMember error");
        return ;
    }
    
    if (results.count == 0) {
        member = nil ;
        NSLog(@"查無結果");
        return;
    }

    member =results[0];
    
    self.memberText.text = member.memberName;

    if ( member != nil) {
        [self memberGetTotalAmount];
    }
    
}



- (IBAction)logout:(id)sender {
    
    if (member == nil) {
        [self showUIAlertCtrl:@"尚未登入"];
        return;
    }
    CoreDataHelper *helper = [CoreDataHelper sharedInstance];
    [helper.managedObjectContext deleteObject:member];
    NSError *error = nil ;
    [helper.managedObjectContext save:&error];
    if (error) {
        NSLog(@"Delete member error  %@",error);
        return;
    }
    
    member = nil ;
    self.memberText.text =@"未登入";
    self.totalAmount.text = @"0";
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"register"]) {
        RegisterCtrl *registerCtrl =segue.destinationViewController;
        registerCtrl.delegate = self ;
    }
    if ([segue.identifier isEqualToString:@"login"]) {
        if (member != nil) {
            [self showUIAlertCtrl:@"請先登出"];
            return;
        }
        
        LoginCtrl *loginCtrl =segue.destinationViewController;
        loginCtrl.delegate = self ;
    }
}
-(void)memberGetTotalAmount{
    NSURL *url = [NSURL URLWithString:@"http://localhost:8888/petShop/order_getTotal.php"];
    
    NSString *parameters = [NSString stringWithFormat:@"memberID=%@",member.memberID];
    
    NSMutableURLRequest  *request = [NSMutableURLRequest requestWithURL:url];
    //設定為POST method
    [request setHTTPMethod:@"POST"];
    //NSString　轉成NSData
    NSData *body = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    //利用uploadTask上傳
    NSURLSessionTask *task = [session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        /* 去除多餘的換行符號   取回mysql的資料時不知為何會被加上換行符號*/
        result  = [result  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
        //放到主執行緒執行
        dispatch_async(dispatch_get_main_queue(), ^{
            self.totalAmount.text = result ;
        });
        
        
    }];
    [task resume];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
