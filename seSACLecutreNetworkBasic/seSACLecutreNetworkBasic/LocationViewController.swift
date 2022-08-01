
import UIKit

class LocationViewController: UIViewController {
    // 08.01
    // 프로토콜 채택
//    static var resueIdentifier: String = String(describing: LocationViewController.self)
    //LocationViewController.self 메타 타입이라고 한다. => 자체가 "LocationViewController" 문자열이 된다.
    
    //08.01

    //Notification
    //1.노티를 담당하는 객체를 가져오기
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorization()
        
        // Custom Font 출력해보기
//        for family in UIFont.familyNames {
//            //패밀리 네임 -> 한 종류에 가는 폰트, 굵은 폰트 등을 포함하는 큰 틀에서의 이름
//            print("=====\(family)=====")
//            
//            // 특정 폰트가 가지고 있는 세부 네임 출력
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print(name)
//            }
//        }
        
        //0811
        LocationViewController.resueIdentifier

    }

    
    //Notification
    //2. 권한 요청
    func requestAuthorization() {
        
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            
            if success {
                self.sendNotification() // 함수의 함수가 있는 구조라 본인 클래스의 메소드를 구분 지어주기 위해
            }
        }
    }
    //Notification
    //3. 권한 허용한 사용자에게 알림 요청(언제 보낼건지? 어떤 컨텐츠?)
    //4. iOS 시스템에서 알림을 담당 -> 알림 등록 코드 필요
    func sendNotification() {
        //컨텐츠 구성
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "다마고치를 키워보세요"
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...100))입니다."
        notificationContent.body = "저는 방실방실 다마고치입니다. 배고파요."
        notificationContent.badge = 40
        
        //트리거 설정 (1. 시간 간격, 2. 캘린더, 3.위치에 따라 설정 가능)
        //시간 간격은 60초 이상 설정해야 반복할 수 있다.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
//        var dateComponent = DateComponents()
//        dateComponent.minute = 15
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        //알림 요청
        //identifier가 동일하다면 알림이 쌓이지 않고 하나의 알림에 갱신되고, 다르면 스택으로 쌓인다.
        //identifier 만약 알림 관리할 필요 없을 때 -> 알림 클릭하면 앱을 켜주는 정도
        // 만약 알림 관리를 할 필요 있을 때 -> +1, 고유 이름, 규칙 등 (예: 카톡 알림) "\(date())"사용)
        let request = UNNotificationRequest(identifier: "same" , content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
    }
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        sendNotification()
    }
}

// 뱃지 제거는 어떻게 처리? -> 언제 제거하는 게 맞을까? -> Scene딜리게이트에서 (액티브 상태에서)
// 노티는 어떻게 제거? -> 노티의 유효 기간은? (기본적으로 한달 정도) -> 하나만 클릭해도 있는 노티가 다 삭제되도록 구현한다 보통 (카톡) -> 런치에서 제거해보자.(상황에 따라 다르다)
// 포그라운드에서 노티 수신은 어떻게 처리? -> 앱딜리게이트

// 정리
// 권한 허용해야만 알림이 온다.
// 권한 허용 문구 시스템적으로 최초 한 번만 뜬다.
// 허용이 안 되어 있는 경우 애플 설정으로 직접 유도하는 코드를 구성해야 한다.
// 기본적으로 알림은 포그라운드에서 수신되지 않는다. 개발자가 별도로 구현해야함.
// 60초 이상 반복 가능하다. 갯수 제한 64개. 커스텀 사운드 (30초 제한) (로컬 알림 기준) (갯수 제한 찾아보기)

// +알파 앞으로 배워야할 것들
// 노티는 앱 실행이 기본이지만, 특정 노티를 클릭할 때 특정 화면으로 가고 싶다면?
// 포그라운드 수신, 특정 화면에서는 안 받고 특정 조건에서만 포그라운드 수신을 받고 싶다면?(예: 카톡 1:1 대화중 상대방 알림은 오지 않는 것, 다른 사람 알림은 받는 것)
// iOS 15 집중모드 등 5~6개 우선순위가 있다. 이런 부분도 고려해서 처리해야 함.
