
import UIKit



class BeerTableViewCell: UITableViewCell {

    @IBOutlet weak var beerImageView: UIImageView! {
        didSet {
            beerImageView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var beerNameLabel: UILabel! {
        didSet {
            beerNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
            beerNameLabel.numberOfLines = 1
        }
    }
    @IBOutlet weak var beerpairLabel: UILabel! {
        didSet {
            beerpairLabel.font = .systemFont(ofSize: 14)
        }
    }
    @IBOutlet weak var beertextLabel: UILabel! {
        didSet {
            beertextLabel.font = .systemFont(ofSize: 14)
            beertextLabel.numberOfLines = 0
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
