//
//  AddHomeViewController.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class AddHomeViewController: UIViewController {

    var statusPemasukan: Bool = false
    var statusPenarikan: Bool = false
    var statusInsert: Bool = false
    
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var priceLabel: UITextField!
    
    @IBOutlet weak var saveOutletButton: UIButton!
    
    @IBOutlet weak var pemasukanView: UIView!
    
    @IBOutlet weak var pengeluaranView: UIView!
    
    @IBAction func pemasukanGesture(_ sender: Any) {
        if statusPemasukan {
            pemasukanView.layer.borderWidth = 0
            statusPemasukan = true
            saveOutletButton.layer.backgroundColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1).cgColor
            saveOutletButton.isEnabled = false
            
        }
        else{
            pemasukanView.layer.borderWidth = 3
            pemasukanView.layer.borderColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
            statusPemasukan = true
            pengeluaranView.layer.borderWidth = 0
            saveOutletButton.layer.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
            saveOutletButton.isEnabled = true
        }
        statusPenarikan = false
        statusInsert = false
    }
    
    @IBAction func pengeluaranGesture(_ sender: Any) {
        if statusPenarikan {
            pengeluaranView.layer.borderWidth = 0
            statusPenarikan = false
            saveOutletButton.layer.backgroundColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1).cgColor
            saveOutletButton.isEnabled = false
        }
        else{
            pengeluaranView.layer.borderWidth = 3
            pengeluaranView.layer.borderColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
            statusPenarikan = true
            pemasukanView.layer.borderWidth = 0
            saveOutletButton.layer.backgroundColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
            saveOutletButton.isEnabled = true
        }
        statusPemasukan = false
        statusInsert = true
    }
    
    fileprivate func goBackToMainTabBar(){
        let viewController = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .flipHorizontal
        navigationController?.pushViewController(viewController, animated: true)
//        self.present(viewController, animated: true, completion: nil)
    }
    
    private func alert() {
        let alert = UIAlertController(title: "Data Tidak Lengkap", message: "Tolong masukkan data dengan lengkap", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    fileprivate func insertUsageHistory(type: TypeHistory){
        usageHistory.append(UsageHistory(usageName: titleLabel.text!, usageDate: getCurrentDate(), price: Int(priceLabel.text!)!, status: statusInsert))
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        saveOutletButton.isEnabled = false
        
        shadowView(uiView: pemasukanView)
        shadowView(uiView: pengeluaranView)

    }
    
    private func shadowView(uiView: UIView){
        uiView.layer.shadowOpacity = 0.35
        uiView.layer.shadowOffset = CGSize(width: 0, height: 2)
        uiView.layer.shadowRadius = 3.0
        uiView.layer.shadowColor = UIColor.darkGray.cgColor
    }

    @IBAction func backHomeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if titleLabel.text!.isEmpty || priceLabel.text!.isEmpty || statusPemasukan == false && statusPenarikan == false {
            alert()
            return
        }
        
        if statusPemasukan {
            insertUsageHistory(type: .deposit)
        }
        
        if statusPenarikan {
            insertUsageHistory(type: .withdraw)
        }
        goBackToMainTabBar()
    }
    
}
