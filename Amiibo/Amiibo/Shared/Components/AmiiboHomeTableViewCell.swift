//
//  AmiiboHomeTableViewCell.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import UIKit
import Domain

class AmiiboTableViewCell: UITableViewCell {

    
    @IBOutlet weak var amiiboImage: UIImageView!
    @IBOutlet weak var amiiboName: UILabel!
    @IBOutlet weak var amiiboSeries: UILabel!
    @IBOutlet weak var amiiboType: UILabel!
    @IBOutlet weak var imageNavigation: UIImageView!
    
    
    // Setup amiibo values
    func setCellWithValuesOf(_ amiibo: Amiibo) {
        updateUI(amiibo: amiibo)
    }
    
    // Update the UI Views
    private func updateUI(amiibo: Amiibo) {
        self.amiiboName.text = amiibo.name
        self.amiiboSeries.text = amiibo.amiiboSeries
        self.amiiboType.text = amiibo.type
        
        let url = URL(string: amiibo.image)!
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: url),
               let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.amiiboImage.image = image
                }
            }
        }
        
    }
    
}
