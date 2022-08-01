import Foundation
import UIKit

protocol ResuableViewProtocol {
    static var resueIdentifier: String { get }
}

extension UIViewController: ResuableViewProtocol {
    //extension 저장 프로퍼티 불가능
    
    static var resueIdentifier: String { // 연산 프로퍼티 get만 사용한다면 get 생략 가능
            return String(describing: self) // get 블럭 생략
    }
}

extension UITableViewCell: ResuableViewProtocol {
    static var resueIdentifier: String {
        return String(describing: self)
    }
}
