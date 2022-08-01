
import UIKit

class ViewController: UIViewController, ViewPresentableProtocol  {
    
    
    static var identifier: String = "ViewController" // static let으로 써도 된다. let일 때 성능 부분이 더 빠르다.
    
//    var navigationTitleString: String = "대장님의 다마고치" // {get set}도 최소 조건을 만족해야 함으로, let으로 설정하면 {set}이 안 되기 때문에 오류가 발생한다.
    
//    var backgroundColor: UIColor = .blue // {get} 만 썼을 때 let으로 바꿀 수 있다. 명확하게 읽기 모드만 가능하도록
    
    //연산 프로퍼티
    var navigationTitleString: String {
        get {
            return "대장님의 다마고치"
        }
        set {
            title = newValue
        }
    }
    
    //연산 프로퍼티
    var backgroundColor: UIColor {
        get {
            return .red
        }
    }
    
    
    
    func configureView() {
        
        navigationTitleString = "고래밥님의 다마고치" // {set}으로 사용
//        backgroundColor = .red // {get}만 설정했는데 왜 값이 변경됐을까? 프로토콜 파일 참조. {get} 만 썼을 때 let으로 바꿀 수 있다. 명확하게 읽기 모드만 가능하도록
        
        title = navigationTitleString
        view.backgroundColor = backgroundColor
    }
    

    //0801
//    let helper = UserDefaultsHelper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        helper.nickname = "고래밥" // set 호출
//        title = helper.nickname // 네비게이션 타이틀에 닉네임 설정, get 호출
//        helper.age = 80
//        print(helper.age)
        
        UserDefaultsHelper.standard.nickname = "고래밥"
        title = UserDefaultsHelper.standard.nickname
        UserDefaultsHelper.standard.age = 80
        print(UserDefaultsHelper.standard.age)
    }


}

