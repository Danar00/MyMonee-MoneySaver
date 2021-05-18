//
//  EditHomeViewController.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 15/05/21.
//

import UIKit

class EditHomeViewController: UIViewController {
    
    var statusPemasukan: Bool = false
    var statusPenarikan: Bool = false
    var statusInsert: Bool = false
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var pemasukanView: UIView!
    
    @IBOutlet weak var pengeluaranView: UIView!
    
    var textTitle: String = ""
    var textPrice: String = ""
    var indexData: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.text = textTitle
        priceTextField.text = textPrice.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        shadowView(uiView: pemasukanView)
        shadowView(uiView: pengeluaranView)
    }
    
    
    @IBAction func pemasukanGesture(_ sender: Any) {
        if statusPemasukan {
            pemasukanView.layer.borderWidth = 0
            statusPemasukan = true
        }
        else{
            pemasukanView.layer.borderWidth = 3
            pemasukanView.layer.borderColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
            statusPemasukan = true
            pengeluaranView.layer.borderWidth = 0
        }
        statusInsert = false
    }
    
    @IBAction func pengeluaranGesture(_ sender: Any) {
        if statusPenarikan {
            pengeluaranView.layer.borderWidth = 0
            statusPenarikan = false
        }
        else{
            pengeluaranView.layer.borderWidth = 3
            pengeluaranView.layer.borderColor = UIColor(red: 0.314, green: 0.412, blue: 0.722, alpha: 1).cgColor
            statusPenarikan = true
            pemasukanView.layer.borderWidth = 0
        }
        statusInsert = true
    }
    
    
    @IBAction func backEditHomeButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func updateHomeButton(_ sender: Any) {
        if titleTextField.text!.isEmpty || priceTextField.text!.isEmpty || statusPemasukan == false && statusPenarikan == false {
            alert()
            return
        }
        
        if statusPemasukan {
            updateData(type: .deposit)
        }
        
        if statusPenarikan {
            updateData(type: .withdraw)
        }
        goBackToMainTabBar()
    }
    
    fileprivate func goBackToMainTabBar(){
        let viewController = MainTabController(nibName: String(describing: MainTabController.self), bundle: nil)
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
    
    fileprivate func updateData(type: TypeHistory){
        usageHistory[indexData!] = UsageHistory(usageName: titleTextField.text!, usageDate: getCurrentDate(), price: Int(priceTextField.text!)!, status: statusInsert)
    }
    
    private func shadowView(uiView: UIView){
        uiView.layer.shadowOpacity = 0.35
        uiView.layer.shadowOffset = CGSize(width: 0, height: 2)
        uiView.layer.shadowRadius = 3.0
        uiView.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    
    @IBAction func deleteButton(_ sender: UIButton) {
        usageHistory.remove(at: indexData!)
        goBackToMainTabBar()
    }
    
}
