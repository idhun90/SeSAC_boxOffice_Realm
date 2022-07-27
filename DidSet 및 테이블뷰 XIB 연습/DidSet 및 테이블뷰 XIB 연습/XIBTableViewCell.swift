//
//  XIBTableViewCell.swift
//  DidSet 및 테이블뷰 XIB 연습
//
//  Created by 이도헌 on 2022/07/27.
//

import UIKit

class XIBTableViewCell: UITableViewCell {
    
    static let id = "XIBTableViewCell"

    @IBOutlet weak var checkBoxButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
