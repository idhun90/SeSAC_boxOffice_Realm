import Foundation

import Alamofire
import SwiftyJSON


//클래스 싱글턴 패턴 vs 구조체 싱글턴 패턴
//왜 구조체는 싱글턴 패턴을 사용하지 않을까?
class ImageSearchAPIManager {
    
    static let shared = ImageSearchAPIManager()
    
    private init() {} // 싱글턴 패턴을 잘 만들기 위해 초기화 제한
    
    typealias completionHandler = (Int, [String]) -> Void
    
    // non-escaping -> @escaping
    func fetchImageData(query: String, startPage: Int, completionHandler: @escaping (Int, [String]) -> Void) {
        //        imagedata.removeAll() // 주석처리하니 인덱스 오류 사라짐
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! // 옵셔널 타입
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(startPage)" // 왜 한글만 안될까?
        //한글은 url에서 인식하지 않아서, 인식되도록 변환해줘야 함 -> 인코딩 UTF8 -> .urlQueryAllowed
        
        // get이기 때문에 parameter 불필요
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON(queue: .global()) { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let totalCount = json["total"].intValue
                
                //0805 map 활용
                
                
                //
                for result in json["items"].arrayValue {
                    // 0805 map 활용
//                    self.list = result["item"].arrayValue.map { $0["link"].stringValue } //$0 -> 첫 번째 요소, jsonswift를 활용해서 첫 요서에 있는 link만 가져오기
                    
                    //페이지네이션 적용 목적
                    let list = result["item"].arrayValue.map { $0["link"].stringValue }
//                    self.list.append(contentsOf: newResult)
                    
                    //
                    //                    let title = result["title"].stringValue
                    //                    let image = result["thumbnail"].stringValue
                    //                    let data = ImageSearchModel(title: title, thumbnail: image)
                    //                    self.imagedata.append(data)
                    
                    DispatchQueue.main.async {
                        completionHandler(totalCount, list) // 처리된 데이터를 viewControoler에게 클로저를 통해 전달
                    }
                    
                }

            case .failure(let error):
                print(error)
            }
        }
    }
    
}


