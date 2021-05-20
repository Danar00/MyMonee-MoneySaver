//
//  DetailImpianViewController.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 14/05/21.
//

import UIKit

class DetailImpianViewController: UIViewController {
    
    
    @IBOutlet weak var titleImpian: UILabel!
    
    @IBOutlet weak var targetImpian: UILabel!
    
    @IBOutlet weak var progressTarget: UILabel!
    
    @IBOutlet weak var progressBarTarget: UIProgressView!
    
    @IBOutlet weak var priceProgress: UILabel!
    
    @IBOutlet weak var viewProgress: UIView!
    
    @IBOutlet weak var confirmationOutletButton: UIButton!
    
    var textTitle: String = ""
    var textPrice: String = ""
    var textProgressTarget: String = ""
    var progressBar: Float = 0.0
    var progressPrice: String = ""
    var indexData: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleImpian.text = textTitle
        targetImpian.text = "Rp \(convertIntToFormatMoneyRaw(money: Int(textPrice.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression))!))"
        progressTarget.text = textProgressTarget
        progressBarTarget.progress = progressBar
        priceProgress.text = progressPrice
        
        viewProgress.layer.shadowOpacity = 0.35
        viewProgress.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewProgress.layer.shadowRadius = 3.0
        viewProgress.layer.shadowColor = UIColor.darkGray.cgColor
        
        checkedProgress()
        
    }

    @IBAction func updateButton(_ sender: Any) {
        let updateImpian = EditImpianViewController(nibName: String(describing: EditImpianViewController.self), bundle: nil)
        updateImpian.textTitle = titleImpian.text!
        updateImpian.textPrice = targetImpian.text!
        updateImpian.indexData = indexData
        navigationController?.pushViewController(updateImpian, animated: true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func goBackToMainTabBar(){
        let viewController = MainTabController(nibName: String(describing: MainTabController.self), bundle: nil)
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .flipHorizontal
//        navigationController?.pushViewController(viewController, animated: true)
        self.present(viewController, animated: true, completion: nil)
    }
    
    func checkedProgress() {
        if progressBarTarget.progress == 1 {
            confirmationOutletButton.layer.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
            confirmationOutletButton.isEnabled = true
        }
        else{
            confirmationOutletButton.isEnabled = false
        }
    }
    
    @IBAction func confirmationButton(_ sender: Any) {
        impianData.remove(at: indexData!)
        usageHistory.append(UsageHistory(usageName: titleImpian.text!, usageDate: currentDate(), price: Int(textPrice.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression))!, status: true))
        
        goBackToMainTabBar()
    }
}

extension DetailImpianViewController: ConvertDate {
    func currentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy - HH.mm"
        let result = formatter.string(from: date)
        return result
    }
}
