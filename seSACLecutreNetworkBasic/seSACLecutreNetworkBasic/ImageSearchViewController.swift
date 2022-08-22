import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class ImageSearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageSearchCollectionView: UICollectionView!
    
    var imagedata: [ImageSearchModel] = []
    var list: [String] = []
    
    //0804
    //네트워크 요청할 때 시작 페이지 넘버
    var startPage = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.searchBarStyle = .minimal
        
        imageSearchCollectionView.delegate = self
        imageSearchCollectionView.dataSource = self
        searchBar.delegate = self
        imageSearchCollectionView.prefetchDataSource = self // 페이지네이션
        
        searchBar.placeholder = "검색어를 입력하세요."
        
        let uinib = UINib(nibName: ImageSearchCollectionViewCell.resueIdentifier, bundle: nil)
        imageSearchCollectionView.register(uinib, forCellWithReuseIdentifier: ImageSearchCollectionViewCell.resueIdentifier)
        
        flowLayout()
        
    }
    
    //0803
    // 네트워크 통신을 할 때 함수명을 fetch 또는 request, call 많이 씀
    // fetchImage, requestImage, callRequestImage, getImage ... -> response에 따라 네이밍 설정함.
    // 내일 페이지네이션(무한스크롤)
    
    
    func fetchImage(query: String) {
        
        ImageSearchAPIManager.shared.fetchImageData(query: query, startPage: startPage) { totalCount, list in
            // 뷰에 보여지는 요소들만 밖에서 처리
            self.totalCount = totalCount
            self.list.append(contentsOf: list)
            self.imageSearchCollectionView.reloadData()
            
        }

    }
    
    func flowLayout() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let itemCount: CGFloat = 2
        
        let width = (UIScreen.main.bounds.width - (spacing * (itemCount + 1))) / itemCount
        
        layout.itemSize = CGSize(width: width, height: width * 1.2 )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        imageSearchCollectionView.collectionViewLayout = layout
        
    }
    
    //0804
    // 페이지네이션 방법1. 컬렉션뷰가 특정 셀을 그리려는 시점에서 호출되는 메소드
    // 마지막 셀에 사용자가 위치해있는지 명확하게 확인하기 어려움
//        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        }
    
    // 페이지네이션 방법2. UIScrollViewDelegateProtocol 활용
    // 테이블뷰나 컬렉션뷰는 스크롤뷰를 상속받고 있어서 스크롤뷰 프로토콜을 사용할 수 있음
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //     print(scrollView.contentOffset) // 얼마만큼 내려왔는지 확인할 수 있다.
    //    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        // 검색 단어가 바뀔 수 있음.
        // 이전 검색 결과를 지우고, 시작화면을 다시 1로 바꿔줌
        imagedata.removeAll()
        startPage = 1 //
        
        fetchImage(query: text)
    }
    
    //취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        imagedata.removeAll()
        imageSearchCollectionView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    //커서가 생겼을 때
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}


//0804
// 페이지네이션 방법3
// 용량이 큰 이미지를 다운받아 셀에 보여주려고 하는 경우에 효과적
// 셀이 화면에 보이기 전에 미리 필요한 리소스를 다운 받을 수 있고, 필요하지 않다면 데이터를 취소할 수도 있음.
// iOS10 이상 지원, 스크롤 성능 향상됨.
extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    
    //셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운 받는 목적으로 사용
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("====\(indexPaths)")
        
        for indexPath in indexPaths {
            if imagedata.count - 1 == indexPath.item && imagedata.count < totalCount { // 마지막 페이지에서 중복되는 무한 스크롤 방지
                startPage += 30 // imagedata.count로 하면 통신할 때마다 수가 증가됨
                
                fetchImage(query: searchBar.text!)
            }
        }
    }
    
    //작업을 취소할 때
    //직접 취소하는 기능 구현해야 함
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("====취소 \(indexPaths)")
    }
    
}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagedata.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageSearchCollectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.resueIdentifier, for: indexPath) as? ImageSearchCollectionViewCell else { return UICollectionViewCell() }
        
        let url = URL(string: imagedata[indexPath.row].thumbnail)
        cell.imageView.kf.setImage(with: url)
        cell.imageView.contentMode = .scaleAspectFill
        cell.imageLabel.text = imagedata[indexPath.row].title
        
        return cell
    }
    
    
}
