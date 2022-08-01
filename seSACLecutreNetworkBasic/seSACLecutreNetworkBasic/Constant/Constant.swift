import Foundation

// 문자열 하드코딩을 줄이는 방법1. 열거형
// case는 소문자로 해줘야 한다.

//enum StoryboardName: String {
//    case Main
//    case Search
//    case Setting
//}

// 방법2. 구조체 활용
// 방법4. private로 init() 제한하기
//struct StoryboardName {
//
//    // 접근 제어를 통해 초기화(인스턴스 생성) 방지
//    //5 단계
//    //private가 붙으면 다른 파일에서 사용할 수 없다. 오직 StoryboardName에서만 사용할 수 있다.
//     private init() {
//
//     }
//
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}


// 방법3 = 방법 1+2
// StoryboardName.search
// 열거형 내에서도 타입 프로퍼티를 사용할 수 있다.
// 인스턴스를 만들 수 없어서 인스턴스 저장 프로퍼티는 사용할 수 없다.

// 장점
// 1. struct 타입 프로퍼티 vs eunm 타입 프로퍼티 -> 인스턴스에 대한 생성 방지, 열거형은 인스턴스 초기화 자체가 안 되기 때문

enum StoryboardName {
    //     var nickname = "고래밥"
    static var nickname = "고래밥"
    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

// 열거형에서 case, static 차이 -> 중복된 내용을 하드코딩 가능 여부
// case는 선택 제약이 있다.
// 스토리보드 네임은 겹치지 않는다 -> case도 사용 가능하다
// 폰트나 이미지 등 똑같은 문자열이 있는 경우 case로는 확장성에 문제가 있다. 타입 프로퍼티로 사용하는 것이 더 나을 수 있다.

enum FontName {
//    case title = "SanFransisco"
//    case body = "SanFransisco"
//    case caption = "AppleSandol"
    
    static let title = "SanFransisco"
    static let body = "SanFransisco"
    static let caption = "AppleSandol"
}
