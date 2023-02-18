//
//  ProductCell.swift
//  Project_1
//
//  Created by Valodya Galstyan on 11.02.23.
//

import UIKit

protocol ProductCelldelegate: AnyObject {
    func didSelectFavorite(selectedIndex: Int)
}

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    
    weak var delegate: ProductCelldelegate?
    
    var selectedInndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func setFavorite(_ sender: UIButton) {
        delegate?.didSelectFavorite(selectedIndex: selectedInndex)
    }
    
    func setData(_ protuct: Product, index: Int) {
        
        self.selectedInndex = index
        iconImage.image = UIImage(named: protuct.icon)
        titleLbl.text = protuct.title
        favBtn.setImage(protuct.isFavorite ? UIImage.init(systemName: "checkmark.circle.fill") : UIImage.init(systemName: "checkmark.circle"), for: .normal)
        
    }
}
