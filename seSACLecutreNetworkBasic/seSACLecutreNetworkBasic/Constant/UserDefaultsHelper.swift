import Foundation
// 유저디폴트는 곳곳에 많이 사용된다.
// 키를 열거형 또는 구조체로 정리 필요
// 한 단계 더 확장해보자.

class UserDefaultsHelper {
    
    private init() { } // 인스턴스 생성 방지
    
    static let standard = UserDefaultsHelper()
    // singleton pattern 자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음.
    
    let userDefaults = UserDefaults.standard
    // 애플이 만들어둔 싱글톤 패턴
    
    
    
    // 이 클래스 내에서만 사용할 거라면 열거형을 클래스 내부에 사용해도 된다.
    enum Key: String {
        case nickname, age
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장" // 옵셔널 오류가 뜬다. 해결 방법 1. 타입을 String?으로 하거나
        }
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue) // get에서는 값을 가져온다.
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}
