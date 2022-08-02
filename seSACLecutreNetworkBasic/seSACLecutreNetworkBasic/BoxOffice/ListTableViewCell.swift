//
//  ListTableViewCell.swift
//  seSACLecutreNetworkBasic
//
//  Created by 이도헌 on 2022/07/27.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    //08.11
    
//    static let id = "ListTableViewCell"

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textAlignment = .center
            titleLabel.font = .systemFont(ofSize: 10)
            print("호출됨")
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
