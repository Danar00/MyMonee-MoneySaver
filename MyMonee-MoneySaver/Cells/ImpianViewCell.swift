//
//  ImpianViewCell.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 14/05/21.
//

import UIKit

protocol ButtonCell {
    func confirmationButton(index: Int)
    func delete(index: Int)
}

class ImpianViewCell: UITableViewCell {
    
    var delegate: ButtonCell?
    
    var indexData: Int?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buttonDetail: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonDelete(_ sender: Any) {
        self.delegate?.delete(index: indexData ?? 0)
    }
    
    @IBAction func buttonDetail(_ sender: Any) {
        self.delegate?.confirmationButton(index: indexData ?? 0)
    }
    
}
