
import UIKit

//0802
import Alamofire
import SwiftyJSON


extension UIViewController {
    func setBackgroundColor() {
        view.backgroundColor = .systemGray6
    }
}

// Protocol 문법과 연관
// Delegate
// Datasource

// 1. 왼팔, 오른팔을 가져와야 한다.
// 테이블 뷰 아울렛 연결
// 1+2

//7.28 수업 코드
// ViewPresentableProtocol 프로토콜 채택
class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //    var navigationTitleString: String
    //    var backgroundColor: UIColor
    //    static var identifier: String
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
//    0822
    // 박스오피스 데이터 담을 배열
//    var list: [String] = []
    var list: [BoxOfficeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
//        view.backgroundColor = .red
        searchTableView.backgroundColor = .clear
        
        //연결고리 작업, 테이블뷰가 해야 할 역할 -> 뷰 컨트롤러에게 요청
        //self는 searchViewController의 인스턴스 자체
        // 딜리게이트 패턴
        searchTableView.delegate = self
        searchTableView.dataSource = self
        // 테이블뷰가 사용할 테이블뷰 셀(XIB파일) 등록
        // XIB: xml interface Builder, 예전엔 Nib이라고 불렸다.
        searchTableView.register(UINib(nibName: ListTableViewCell.resueIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.resueIdentifier)
        // nibName도 identifier랑 같은 문자열이다. 리터럴 문자열 제거 필요
        
        searchBar.delegate = self
        
        //0802
        requestBoxOffice(text: "20220801")
        
    }
    
    //MARK: - 프로토콜
    //우리가 프로토콜에 만들었던 함수에 대한 내용이 추가된다.
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func configureLabel() {
        
    }
    
    
    func requestBoxOffice(text: String) {
        
        list.removeAll() // 서버 통신을 하기 전에 배열을 삭제 위치1, 로딩바를 띄우면 사용자가 인지할 수 있다
        // 실패했을 때 추가로 데이터를 지워주는 코드가 필요하기 때문에 수업은 위치 1로 진행
        
        // 0802
        // 박스오피스
        // 인증키 존재 그리고 제한이 있다. 박스 오피스 기준 3000회
        // 1. 화면을 띄우자 마자, 사용자가 검색을 했을 때 구현
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
//                self.list.removeAll() // 서버 통신을 하기 전에 데이터가 성공 시 배열 삭제 위치2
                // 반복문으로 코드 개선
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                   
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNm, releaseData: openDt, total: audiAcc)
                    
                    self.list.append(data)
                }
                print(self.list)
//                // 테이블 뷰에 보여줄 자료 구성하기
//                let movieNM1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
//                let movieNM2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
//                let movieNM3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
//
//                // list 배열에 데이터 추가
//                self.list.append(movieNM1)
//                self.list.append(movieNM2)
//                self.list.append(movieNM3)
                
                // viewdidload에서 호출될 때 list는 0
                // 데이터를 가져오는 시간이 있음
                // 데이터를 가져왔을 땐 이미 테이블 뷰가 구현되어 있는 상태
                // 따라서 테이블 뷰 리로드가 필요하다.
                
                // 데이터 갱신
                self.searchTableView.reloadData()
//                print(self.list)
                
                
             
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    // 상속이 아니라 override가 없다
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //08.11 수정
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.resueIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell()}
        
        cell.backgroundColor = .clear // 이렇게 하면 투명하게 되면서  뷰컨트롤러, 테이블뷰 컨트롤러 백그라운드 색상과 같아져서 작업량을 줄일 수 있다.
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "\(list[indexPath.row].movieTitle): \(list[indexPath.row].releaseData)"
        
        // viewdidload에서 호출될 때 list는 0
        // 데이터를 가져오는 시간이 있음
        // 데이터를 가져왔을 땐 이미 테이블 뷰가 구현되어 있는 상태
        // 따라서 테이블 뷰 리로드가 필요하다.
        
        return cell
    }
}

//0802
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice(text: searchBar.text!) // 옵셔널 바인딩 처리, 8글자, 숫자, 날짜로 변경 시 유효한 형태의 값인지 체크 필요. 수업상엔 !로 진행
    }
}

/*
 각 json value -> List -> 테이블뷰 갱신
 서버의 응답이 몇 개인지 모를 경우에는 반복문을 통해 해결
 */
