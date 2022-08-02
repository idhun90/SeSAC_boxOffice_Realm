import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class BeerListViewController: UIViewController {

    @IBOutlet weak var beerTableView: UITableView!
    
    var beerData: [Beer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerTableView.delegate = self
        beerTableView.dataSource = self
        
        let UINib = UINib(nibName: BeerTableViewCell.resueIdentifier, bundle: nil)
        beerTableView.register(UINib, forCellReuseIdentifier: BeerTableViewCell.resueIdentifier)
        beerTableView.rowHeight = 200
        

        requestBeerAPI()
    }
    
    func requestBeerAPI() {
        
        let url = EndPoint.beerURL
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for beer in json.arrayValue {
                    let name = beer["name"].stringValue
                    let url = beer["image_url"].stringValue
                    let description = beer["description"].stringValue
                    let foodPairing = beer["food_pairing"][0].stringValue
                    
                    let data = Beer(beerName: name, imageUrl: url, description: description, foodPairing: foodPairing)
                    
                    self.beerData.append(data)
                }
                
                self.beerTableView.reloadData()
                        
                
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = beerTableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.resueIdentifier, for: indexPath) as? BeerTableViewCell else { return BeerTableViewCell() }
        
        cell.beerNameLabel.text = beerData[indexPath.row].beerName
        cell.beerpairLabel.text = "찰떡궁합: \(beerData[indexPath.row].foodPairing)"
        cell.beertextLabel.text = beerData[indexPath.row].description
        
        
        let url = URL(string: beerData[indexPath.row].imageUrl)
        cell.beerImageView.kf.setImage(with: url)
        
        
        return cell
    }
    
    
}
