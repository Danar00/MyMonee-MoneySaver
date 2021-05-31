//
//  HomeViewCell.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 14/05/21.
//

import UIKit

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showData(usage: UsageHistory){
        titleLabel.text = usage.usageName
        dateLabel.text = usage.usageDate
        priceLabel.text = usage.formatRupiah()
        if usage.status {
            imageStatus.image = UIImage(named: "ic_down")
            priceLabel.textColor = .red
        }
        else{
            imageStatus.image = UIImage(named: "ic_up")
            priceLabel.textColor = .systemGreen
        }
    }
    
}
