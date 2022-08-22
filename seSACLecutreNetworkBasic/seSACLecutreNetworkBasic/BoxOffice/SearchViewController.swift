
import UIKit

import Alamofire
import JGProgressHUD
import SwiftyJSON
import RealmSwift

extension UIViewController {
    func setBackgroundColor() {
        view.backgroundColor = .systemGray6
    }
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    //08.22 코드
    let localRealm = try! Realm()
    var tasks: Results<RealmBoxOffice>!
    
    var list: [BoxOfficeModel] = []
    let hub = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        searchTableView.backgroundColor = .clear

        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(UINib(nibName: ListTableViewCell.resueIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.resueIdentifier)
        searchTableView.rowHeight = 50
        
        searchBar.delegate = self
        searchBar.placeholder = "날짜를 입력해주세요. 예: 20220822"
        searchBar.searchBarStyle = .minimal
        
        //requestBoxOffice(text: calculatedDate())
        checklocalData()
        print("Realm is located at:", localRealm.configuration.fileURL!)
      
    }
    //08.22 코드
    func checklocalData() {
     
        if tasks == nil {
//            requestBoxOffice(text: calculatedDate())
            print(tasks)
            print("로컬 데이터가 없으므로 서버 통신 진행")
        } else {
            print("로컬 데이터 존재함")
        }
    }
    
    func calculatedDate() -> String {
        let date = Date()
        let mydate = DateFormatter()
        mydate.dateFormat = "yyyyMMdd"
        
        guard let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: date, wrappingComponents: false) else { return "오류 발생" }
    
        let previous = mydate.string(from: previousDay)
        print(previous)
        
        return previous
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func requestBoxOffice(text: String) {
        hub.show(in: view)
        // 08.22 코드
        //list.removeAll()
        tasks = nil

        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                   
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    // 08.22 코드
                    // 로컬 값
                    let task = RealmBoxOffice(movieTitle: movieNm, releaseDate: openDt, totalPersonCount: audiAcc)
                    
                    try! self.localRealm.write {
                        self.localRealm.add(task)
                        print("로컬 데이터 추가 성공")
                    }
//                    self.searchTableView.reloadData()
                    //let data = BoxOfficeModel(movieTitle: movieNm, releaseData: openDt, total: audiAcc)
                    //self.list.append(data)
                }
                self.tasks = self.localRealm.objects(RealmBoxOffice.self)
                self.searchTableView.reloadData()
                print(self.tasks)
                
                self.hub.dismiss(animated: true) // 데이터를 리로딩 완료했을 시점 // 실패됐을 때도 처리 필요
//                print(self.list)
             
            case .failure(let error):
                self.hub.dismiss(animated: true) // 실패했을 때도 처리 필요
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.resueIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell()}
        
        cell.backgroundColor = .clear
        cell.titleLabel.font = .boldSystemFont(ofSize: 17)
        // 08.22 코드
        cell.titleLabel.text = "\(tasks[indexPath.row].movieTitle): \(tasks[indexPath.row].releaseDate)"
//        cell.titleLabel.text = "\(list[indexPath.row].movieTitle): \(list[indexPath.row].releaseData)"
        
        return cell
    }
}

//0802
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //requestBoxOffice(text: searchBar.text!)
        
        //08.22
        guard let text = searchBar.text else { return }
        
    }
}
