//
//  TableViewCell.swift
//  togtail
//
//  Created by Tolga Yakar on 29.01.2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientCellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
