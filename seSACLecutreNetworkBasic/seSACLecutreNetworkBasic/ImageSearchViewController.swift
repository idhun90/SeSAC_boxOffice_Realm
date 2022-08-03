import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class ImageSearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageSearchCollectionView: UICollectionView!
    
    var imagedata: [ImageSearchModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.searchBarStyle = .minimal
        
        imageSearchCollectionView.delegate = self
        imageSearchCollectionView.dataSource = self
        searchBar.delegate = self
        
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
        
        imagedata.removeAll()
        
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! // 옵셔널 타입
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=1" // 왜 한글만 안될까?
        //한글은 url에서 인식하지 않아서, 인식되도록 변환해줘야 함 -> 인코딩 UTF8
        
        // get이기 때문에 parameter 불필요
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                for result in json["items"].arrayValue {
                    let title = result["title"].stringValue
                    let image = result["thumbnail"].stringValue
                    
                    let data = ImageSearchModel(title: title, thumbnail: image)
                    self.imagedata.append(data)
                }
                
                print(self.imagedata)
                self.imageSearchCollectionView.reloadData()
                
                
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func flowLayout() {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let itemCount: CGFloat = 2
        
        let width = (UIScreen.main.bounds.width - (spacing * (itemCount + 1))) / itemCount
        
//        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width, height: width * 1.2 )
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        imageSearchCollectionView.collectionViewLayout = layout
        
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        print("작동됨")
        fetchImage(query: text)
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
