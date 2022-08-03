
import UIKit

class ImageSearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var imageLabel: UILabel! {
        didSet {
            imageLabel.font = .boldSystemFont(ofSize: 17)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
