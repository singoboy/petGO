//
//  PetHospitalMapCtrl.m
//  petShop
//
//  Created by GaryFan on 2016/7/21.
//  Copyright © 2016年 user12. All rights reserved.
//

#import "PetHospitalMapCtrl.h"
#import <MapKit/MapKit.h>
#import<CoreLocation/CoreLocation.h>

@interface PetHospitalMapCtrl ()<MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    NSMutableArray *locationArray ;
    CLLocationCoordinate2D nowCoordinate;
}
@property (weak, nonatomic) IBOutlet MKMapView *mainMapView;
@end

@implementation PetHospitalMapCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mainMapView.delegate = self ;
    locationManager =[CLLocationManager new];
    [locationManager requestWhenInUseAuthorization];//取得使用者授權 要去info加入NSLocationWhenUseUsage.. 隱私授權只會問一次 對同一個app而言
    // 加在info.plist黨裡面　就是存app自身要用的一些系統資料 ,讓app可以抓
    
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;//desiredAccuracy 我所期待的精確度
    //command +kCLLocationAccuracyBes=查看更多的選項,此選項會開啟GPS,(__MAC_10_7,__IPHONE_4_0) 表示從第幾版本開始支援,層級越高越耗電
    locationManager.activityType=CLActivityTypeAutomotiveNavigation;
    //活動的種類 來配置電力 有分 導航 運動 其他
    locationManager.delegate=self;
    [locationManager startUpdatingLocation];//回報位置
    [self getLocations];
    
    // Do any additional setup after loading the view.
}

- (IBAction)maptypecahnge:(id)sender {//Segment標準單選元件
    
    NSInteger targtIndex=[sender selectedSegmentIndex];//一定要用selectedSegmentIndex 注意
    switch (targtIndex) {
        case 0:
            self.mainMapView.mapType=MKMapTypeStandard;
            break;
        case 1:
            self.mainMapView.mapType=MKMapTypeSatellite;
            break;
        case 2:
            self.mainMapView.mapType=MKMapTypeHybrid;
            break;
            
    }
    
}

- (IBAction)uersTrackingMondeChange:(id)sender {//使用者追蹤模式
    NSInteger targtIndex=[sender selectedSegmentIndex];//一定要用selectedSegmentIndex 注意
    switch (targtIndex) {
        case 0:
            self.mainMapView.userTrackingMode=MKUserTrackingModeNone;
            break;
        case 1:
            self.mainMapView.userTrackingMode=MKUserTrackingModeFollow;//跑步 開車 等等狀態
            break;
        case 2:
            self.mainMapView.userTrackingMode=MKUserTrackingModeFollowWithHeading;//除了上方狀態之外 還顯示使用者面對的方向
            break;
            
    }
    
    
}

#pragma  mark -cLLocationManagerDelegate Method


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    
    CLLocation *currentLocation=locations.lastObject;
    //Cllocation 內還有altitude;海拔  horizontalAccuracy 水平精確度 50m 100m  verticalAccuracy;垂直精確度
    //speed 會回報每秒幾公尺
    //distanceFromLocation 兩個經緯度的直線距離
    //路徑規劃 MKRoute
    
    
 //   NSLog(@"Lat: %.6f,Lon:%.6f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    //latitude 緯度 longitude 精度
    
    
    //make region be changed only once(gcd的一種)
    
    static dispatch_once_t changeRengionOnceToken;
    dispatch_once(&changeRengionOnceToken, ^{//changeRengionOnceToken 類似標籤 用來判斷是否執行過
        //寫在這邊的程式碼 整個app 只執行一次
        MKCoordinateRegion region=self.mainMapView.region;//region記錄地圖的中心跟縮放大小
        region.center=currentLocation.coordinate;//第一次設定的位置存給region
        region.span.latitudeDelta=0.01;//表示縮放到0.01個緯度  用1表示縮放到1緯度大小
        region.span.longitudeDelta=0.01;//縮放到0.01經度
        //但地球圓形  程式會自動調整
        [self.mainMapView setRegion:region animated:YES];
        
        
//        NSMutableArray *mapList= [NSMutableArray new] ;
        
        nowCoordinate=currentLocation.coordinate;//傳入使用者目前位置
/*
        if (locationArray.count == 0) {
            [self showUIAlertCtrl:@"後台服務錯誤"];
            return ;
        }
        
    //    MKPointAnnotation *annotion= [MKPointAnnotation new];//建立一個MKPointAnnotation物件 用來存標題副標題
        
        for (int i = 0; i<locationArray.count; i++) {
           MKPointAnnotation *annotion= [MKPointAnnotation new]; //如果不在這邊new指標都會指向同一筆 顯示只有一筆
            NSDictionary *item = locationArray[i];
            double lat =[item[@"lat"] doubleValue];
            double lon =[item[@"lon"] doubleValue];
            NSString *name = item[@"name"];
            NSString *phone = item[@"phone"];
            
            annotion.coordinate=CLLocationCoordinate2DMake(lat, lon);
            annotion.title=name;
            annotion.subtitle=phone;
            
            [mapList addObject:annotion];
        }
        
        [self.mainMapView addAnnotations:mapList];//資料設定好了加到地圖上
*/
    });
}
#pragma  mark MKmapviewdelegate
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    //監聽使用者位置 只要region改變就可以被掌握  看是要加入什麼服務給使用者 附近商電之類
    MKCoordinateRegion region=self.mainMapView.region;
  //  NSLog(@"regionDidChangeAnimated: lat:%.6f,lon:%.6f",region.center.latitude,region.center.longitude);
    
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if(annotation==mapView.userLocation){
        return nil;
    }
    
    NSString *indentifier=@"store";
    //官方圖釘版本
    
    //    MKPinAnnotationView *result=(MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:indentifier];//是否有可以回收的MKPinAnnotationView
    //
    //自訂圖釘版本
    MKAnnotationView *result=[mapView dequeueReusableAnnotationViewWithIdentifier:indentifier];
    
    //(MKPinAnnotationView*)自訂版本不用轉型 因為MKAnnotationView這個類是MKPinAnnotationView的副類別
    //方法原本就傳入(MKPinAnnotationView*) 型態
    
    
    
    if(result==nil){//如果沒有可以回收的來用 就重新造一個
        //官方圖釘
        //        result =[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:indentifier];
        //
        
        result =[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:indentifier];
        
    }else{
        result.annotation=annotation;//地127行的MKPointAnnotation *annotion 傳進來的值
    }
    result.canShowCallout=true;//出現泡泡 如果沒有實作 viewForAnnotation 泡泡預設會出現 但如果用viewForAnnotation 這個設定要開啟
    
    //如果使用自訂圖標下面兩個方法沒有用
    //    result.animatesDrop=true;
    //   // result.pinColor=MKPinAnnotationColorPurple;只支援到8要注意8版本的用戶
    //
    //    result.pinTintColor=[UIColor blackColor];//9才開始支援
    
    
    //以下自訂圖標圖片
    
    UIImage *Pinkimage=[UIImage imageNamed:@"pointRed.png"];//用途黨名把屠宰進來
    result.image=Pinkimage;
    
    //pink出圖的時候  圖的尖端一定要在圖的正中間 上下左右算進來的正中心
    
    
    //leftcalloutaccessoryView  點下圖標之後左邊出現一個圖標
    
    UIImage *detalImage=[UIImage imageNamed:@"Pet_Red.png"];
    
    
    result.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:detalImage];
    result.leftCalloutAccessoryView.contentMode =UIViewContentModeScaleAspectFit;
    //rightcalloutaccessoryview 點下圖標之後右邊出現一個按鈕 用selector當點下去之後執行buttonTapped: 方法  點擊泡泡也可以
    //    UIButton *button=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    //    result.rightCalloutAccessoryView=button;
    
    //detailcalloutaccessoryview   IOS9之後才有 會取代原本的“真好吃欄位”
    //    UIImage *detalImage=[UIImage imageNamed:@"u-bahn.png"];
    //    UIImageView *detailImageview=[[UIImageView alloc]initWithImage:detalImage];
    //    //    detailImageview.contentMode=UIViewContentModeScaleAspectFill;
    //    //    detailImageview.clipsToBounds=true;用填滿全圖 超出的部分切掉
    //    detailImageview.contentMode=UIViewContentModeScaleAspectFit;
    //    result.detailCalloutAccessoryView=detailImageview;
    return result;
}

-(void)buttonTapped:(id)sender{
    NSLog(@"buttonTapped");
    
}
/*
-(void)getLocation{

        NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8888/petShop/map_json.php"];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:60.0];
        [request setHTTPMethod:@"POST"];
        NSString *postString = [NSString stringWithFormat:@"none"];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
        NSError *error = nil;
    
        // notices 回傳的是 NSARRAY 不是 NSMUTABLEARRAY
         NSArray  *jsonArray = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"Error parsing JSON.");
        return ;
    }
        locationArray = [jsonArray mutableCopy];
  //  NSLog(@"locationArray=%@",locationArray);


}
*/
-(void)getLocations {
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:8888/petShop/map_json.php"];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        locationArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSMutableArray<MKPointAnnotation*> *items = [NSMutableArray new];
            
            for (int i = 0; i<locationArray.count; i++) {
                MKPointAnnotation *annotation= [MKPointAnnotation new]; //如果不在這邊new指標都會指向同一筆 顯示只有一筆
                NSDictionary *item = locationArray[i];
                double lat =[item[@"lat"] doubleValue];
                double lon =[item[@"lon"] doubleValue];
                NSString *name = item[@"name"];
                NSString *phone = item[@"phone"];
                
                annotation.coordinate=CLLocationCoordinate2DMake(lat, lon);
                annotation.title=name;
                annotation.subtitle=phone;
                
                [items addObject:annotation];
            }
            
            [self.mainMapView addAnnotations:items];//資料設定好了加到地圖上
            
        });
        
    }];
    
    [task resume];
    
}



//導航
- (IBAction)goShortCut:(id)sender {
    
    if (locationArray.count == 0) {
        [self showUIAlertCtrl:@"server 連線錯誤"];
        return ;
    }
    //找最近的物件
    NSMutableDictionary *returnDic = [self countDistance];
    
//    NSLog(@"returnDic=%@",returnDic);
    
    CLLocationCoordinate2D now = CLLocationCoordinate2DMake(nowCoordinate.latitude, nowCoordinate.longitude);
    
    
    CLLocationCoordinate2D target = CLLocationCoordinate2DMake([returnDic[@"lat"] doubleValue], [returnDic[@"lon"] doubleValue]);
    
    // 根據座標得到地標
    MKPlacemark *pA = [[MKPlacemark alloc] initWithCoordinate:now addressDictionary:nil];
    MKPlacemark *pB = [[MKPlacemark alloc] initWithCoordinate:target addressDictionary:nil];
    
    // 根據地標建立地圖項目
    MKMapItem *miA = [[MKMapItem alloc] initWithPlacemark:pA];
    MKMapItem *miB = [[MKMapItem alloc] initWithPlacemark:pB];
    
    miA.name = @"現在位置";
    miB.name = returnDic[@"name"];
    miB.phoneNumber =  returnDic[@"phone"]  ;
    // 將起迄點放到陣列中
    NSArray *routes = @[miA, miB];
    
    // 設定為開車模式
    NSDictionary *param = [NSDictionary dictionaryWithObject:MKLaunchOptionsDirectionsModeWalking forKey:MKLaunchOptionsDirectionsModeKey];
    
    // 開啟地圖開始導航
    [MKMapItem openMapsWithItems:routes launchOptions:param];
    
}

-(NSMutableDictionary *)countDistance{
    
    double  shortDistance = 0 ;
    NSMutableDictionary *selectDic ;
    for (int i = 0; i<  locationArray.count; i++) {
        NSMutableDictionary *dic  = locationArray[i];
        CLLocation *current = [[CLLocation alloc] initWithLatitude:nowCoordinate.latitude longitude:nowCoordinate.longitude];
        
        CLLocation *itemLoc = [[CLLocation alloc] initWithLatitude:[dic[@"lat"] doubleValue]   longitude:[dic[@"lon"] doubleValue]];   //notice 複製貼上時 lat 忘記改成 lon
        
        CLLocationDistance itemDist = [itemLoc distanceFromLocation:current];

        if (i == 0) {
            shortDistance = itemDist ;
           // selectDic = dic ;
            selectDic = [dic mutableCopy] ;
        }
        
        if (itemDist < shortDistance) {
            
        NSLog(@"dic name: %@", dic[@"name"]);
            NSLog(@"Distance: %f", itemDist);
            shortDistance = itemDist ;
          //  selectDic = dic ;       // 錯誤版本 ??  dic 的指標 給了 selecDic  所以 dic變  selectDic 跟者變
           selectDic = [dic mutableCopy];  //只複製值
            
        }

        
       // NSLog(@"Distance: %f", itemDist);
    }
    
    return selectDic ;
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
