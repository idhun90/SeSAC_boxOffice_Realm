import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON
import SwiftUI

class BeerViewController: UIViewController {

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var paringFoodLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestBeerInfo()
        labelUI()
    }
    
    func requestBeerInfo() {
        
        let url = "https://api.punkapi.com/v2/beers/random"
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let beerName = json[0]["name"].stringValue
                let imageUrl = json[0]["image_url"].stringValue
                let description = json[0]["description"].stringValue
                let foodPairing = json[0]["food_pairing"][0].stringValue
                
                guard let url = URL(string: imageUrl) else { return }
                self.beerImageView.kf.setImage(with: url)
                
                self.beerNameLabel.text = beerName
                self.descriptionLabel.text = description
                self.paringFoodLabel.text = foodPairing
                
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func randomButtomClicked(_ sender: UIButton) {
        requestBeerInfo()
    }
}

extension BeerViewController: BeerViewProtocol {
    
    func labelUI() {
        beerNameLabel.font = .systemFont(ofSize: 13, weight: .bold)
        paringFoodLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        descriptionLabel.font = .systemFont(ofSize: 10)

        descriptionLabel.numberOfLines = 0
    }
    
    
}
