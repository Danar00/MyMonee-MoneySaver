//
//  DetailHomeViewController.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class DetailHomeViewController: UIViewController {
    
    @IBOutlet var imageStatus: UIImageView!
    
    @IBOutlet var titleUsageLabel: UILabel!
    
    @IBOutlet weak var statusUsageLabel: UILabel!
    
    @IBOutlet weak var priceUsageLabel: UILabel!
    
    @IBOutlet weak var labelID: UILabel!
    
    @IBOutlet weak var createDateLabel: UILabel!
    
    
    var textTitle: String = ""
    var textPrice: String = ""
    var textId: String = ""
    var textDate: String = ""
    var textStatus: String = ""
    var imageToShow: UIImage?
    var colorToShow: UIColor?
    var indexData: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleUsageLabel.text = textTitle
        priceUsageLabel.text = textPrice
        labelID.text = textId
        createDateLabel.text = textDate
        statusUsageLabel.text = textStatus
        imageStatus.image = imageToShow
        priceUsageLabel.textColor = colorToShow
        
    }

    @IBAction func backHomeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func editHomeButton(_ sender: Any) {
        
        let editHome = EditHomeViewController(nibName: String(describing: EditHomeViewController.self), bundle: nil)
        
        editHome.textTitle = textTitle
        editHome.textPrice = textPrice
        editHome.indexData = indexData
        editHome.id = textId
        
        navigationController?.pushViewController(editHome, animated: true)
        
    }
    
    
    
}
