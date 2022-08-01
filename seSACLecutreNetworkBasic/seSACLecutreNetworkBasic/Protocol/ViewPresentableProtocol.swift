import Foundation
import UIKit

// 7/28일
// 네이밍은 ~~~프로토콜, ~~~딜리게이트로 자주 쓰인다.

// 프로토콜에만 주석 처리를 하면 개발자가 아 이런 프로토콜이구나 하고 구조 파악하는데 용이하다.
// 프로토콜에는 실질적인 기능은 담당하지 않고, 공통적으로 사용할 네이밍만 만든다.
// 프로토콜은 규약이자 필요한 요소를 명세만 할 뿐, 실질적인 구현부는 작성하지 않는다.
// 실질적인 구현은 프로토콜을 채택 또는 준수한 타입이 구현한다.
// 클래스, 구조체, 익스텐션, 열거형... 등에서 사용할 수 있다.
// 클래스는 단일 상속만 가능하지만, 프로토콜은 채택 갯수에 제한이 없다.
// @objc optional -> 선택적 요청(Optional Requirement): 오브젝트C로부터 받아온 구조들이 많아서 @objc 키워드가 필요하다. @objc 함수를 만드려면 프로토콜 키워드 앞에도 @objc도 추가해줘야 한다.

// 프로토콜 프로퍼티: 연산 프로퍼티로 쓰든 저장 프로퍼티로 쓰든 상관하지 않는다. 명세하지 않기에, 구현을 할 때 프로퍼티를 저장 프로퍼티로 쓸 수도 있고, 연산 프로퍼티로 사용할 수도 있다.
// 따라서 무조건 var로 사용해야 한다.
// 만약 get을 명시했다면, get 기능만 최소한 구현되어 있으면 된다. 그래서 필요하다면 set도 구현해도 괜찮다. 그래서 저장 프로퍼티로 구현해도 문제 없었다.

@objc protocol ViewPresentableProtocol {
    
    // 프로토콜 프로퍼티도 실질적인 구현부는 구현하지 않는다.
    // 프로토콜 프로퍼티: 연산 프로퍼티로 쓰든 저장 프로퍼티로 쓰든 상관하지 않는다. 명세하지 않기에, 구현을 할 때 프로퍼티를 저장 프로퍼티로 쓸 수도 있고, 연산 프로퍼티로 사용할 수도 있다.
    
    var navigationTitleString: String { get set }
    var backgroundColor: UIColor { get }
    static var identifier: String { get }
    
    // 프로토콜 메소드
    func configureView() // 뷰의 UI를 조절해주는 함수 생성
    @objc optional func configureLabel() // 레이블 관련 함수
    @objc optional func configureTextField() // 옵셔널을 추가하려면 @objc 키워드를 사용해야한다.
    
}

/*
 예: 테이블뷰
 
 
 */

@objc protocol LeeTableViewProtocal {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
    @objc optional func didSelectRowAt()
}
