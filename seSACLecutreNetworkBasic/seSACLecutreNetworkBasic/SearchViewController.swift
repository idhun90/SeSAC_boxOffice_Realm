//
//  SearchViewController.swift
//  seSACLecutreNetworkBasic
//
//  Created by 이도헌 on 2022/07/27.
//

import UIKit


extension UIViewController {
    func setBackgroundColor() {
        view.backgroundColor = .red
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
//    
//    var backgroundColor: UIColor
//    
//    static var identifier: String
    
    

    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
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

    // 상속이 아니라 override가 없다
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //08.11 수정
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.resueIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell()}
        
        cell.backgroundColor = .clear // 이렇게 하면 투명하게 되면서  뷰컨트롤러, 테이블뷰 컨트롤러 백그라운드 색상과 같아져서 작업량을 줄일 수 있다.
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "Hello"
        
        return cell
    }
}
