import UIKit

struct ExchangeRate {
    
    var currencyRate: Double { // 저장 프로퍼티
        willSet {
            print("currencyRate willSet - 환율 변동 예정: \(currencyRate) -> \(newValue)")
        }
        
        didSet {
            print("currencyRate didSet - 환율 변동 완료: \(oldValue) -> \(currencyRate)")
        }
        
    }
    
    var USD: Double { // 저장 프로퍼티
        willSet {
            print("USD willset - 환전 금액: \(newValue)달러로 환전될 예정")
        }
        
        didSet {
            print("USD didSet - KRW: \(KRW)원 -> \(USD)달러로 환전되었음")
        }
        
    }
    
    var KRW: Double { // 연산 프로퍼티
        get {
            let krw = currencyRate * USD
            return krw
        }
        
        set {
            USD = newValue / currencyRate
        }
    }
}

var rate = ExchangeRate(currencyRate: 1100, USD: 1)
rate.KRW = 500000
rate.currencyRate = 1350
rate.KRW = 500000
