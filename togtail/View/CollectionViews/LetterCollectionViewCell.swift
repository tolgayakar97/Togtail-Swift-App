//
//  CollectionViewCell.swift
//  togtail
//
//  Created by Tolga Yakar on 23.01.2024.
//

import UIKit

class LetterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Round cellViews corners in order to get a circular cell.
        cellView.layer.cornerRadius = 15
    }

}
