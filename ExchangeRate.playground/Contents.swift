import UIKit

//struct ExchangeRate {
//
//    var currencyRate: Double { // 저장 프로퍼티
//        willSet {
//            print("currencyRate willSet - 환율 변동 예정: \(currencyRate) -> \(newValue)")
//        }
//
//        didSet {
//            print("currencyRate didSet - 환율 변동 완료: \(oldValue) -> \(currencyRate)")
//        }
//
//    }
//
//    var USD: Double { // 저장 프로퍼티
//        willSet {
//            print("USD willset - 환전 금액: \(newValue)달러로 환전될 예정")
//        }
//
//        didSet {
//            print("USD didSet - KRW: \(KRW)원 -> \(USD)달러로 환전되었음")
//        }
//
//    }
//
//    var KRW: Double { // 연산 프로퍼티
//        get {
//            let krw = currencyRate * USD
//            return krw
//        }
//
//        set {
//            USD = newValue / currencyRate
//        }
//    }
//}
//
//var rate = ExchangeRate(currencyRate: 1100, USD: 1)
//rate.KRW = 500000
//rate.currencyRate = 1350
//rate.KRW = 500000



// 프로토콜
protocol Study {
    func til(what: String) -> String
    func question(count: Int)
}

class Swift: Study {
    
    func til(what: String) -> String {
        return "오늘은 \(what)을 배웠습니다."
    }
    
    func question(count: Int) {
        print("오늘은 해결하지 못한 문제가 \(count)개입니다.")
    }
}

var swift = Swift()
swift.question(count: 1) // 오늘은 해결하지 못한 문제가 1개입니다.
swift.til(what: "프로토콜") // 오늘은 프로토콜을 배웠습니다.


protocol NavigationUIProtocol {
    
    var navigationTitle: String {get set}
    var backgroundColor: UIColor {get}
    static var id: String {get}
    
    func configueView()
    
}

class Navi: NavigationUIProtocol {
    
    var navigationTitle: String = "시작화면"
    
    var backgroundColor: UIColor = .red
    
    static let id: String = "Navi"
    
    func configueView() {
//        title = navigationTitle
//        view.backgroundColor = backgroundColor
    }
}
