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
        self.showToast(message: "Data Berhasil Di input", font: .systemFont(ofSize: 12.0))
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {             self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        
//        self.present(viewController, animated: true, completion: nil)
    }
    
    private func alert() {
        let alert = UIAlertController(title: "Data Tidak Lengkap", message: "Tolong masukkan data dengan lengkap", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    fileprivate func insertUsageHistory(type: TypeHistory){
//        usageHistory.append(UsageHistory(usageName: titleLabel.text!, usageDate: currentDate(), price: Int(priceLabel.text!)!, status: statusInsert))
//
//        UserDefaults.standard.set(try? PropertyListEncoder().encode(usageHistory), forKey: "savedArray")
        
        guard let url = URL(string: "https://60a5fb0ac0c1fd00175f4d86.mockapi.io/api/v1/transaction") else {
            print("Error: cannot create URL")
            return
        }
        
        let uploadDataModel = UsageHistory(usageName: titleLabel.text!, usageDate: currentDate(), price: Int(priceLabel.text!)!, status: statusInsert)
        
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
                    print("Error: Trying to convert model to JSON data")
                    return
                }
                // Create the url request
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
                request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
                request.httpBody = jsonData
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard error == nil else {
                        print("Error: error calling POST")
                        print(error!)
                        return
                    }
                    guard let data = data else {
                        print("Error: Did not receive data")
                        return
                    }
                    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                        print("Error: HTTP request failed")
                        return
                    }
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Couldn't print JSON in String")
                            return
                        }
                        
                        print(prettyPrintedJson)
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                }.resume()
        
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
    
    func showToast(message : String, font: UIFont) {

           let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height/2, width: 150, height: 35))
           toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
           toastLabel.textColor = UIColor.white
           toastLabel.font = font
           toastLabel.textAlignment = .center;
           toastLabel.text = message
           toastLabel.alpha = 1.0
           toastLabel.layer.cornerRadius = 10;
           toastLabel.clipsToBounds  =  true
           self.view.addSubview(toastLabel)
           UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
           }, completion: {(isCompleted) in
               toastLabel.removeFromSuperview()
           })
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


extension AddHomeViewController: ConvertDate {
    func currentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy - HH.mm"
        let result = formatter.string(from: date)
        return result
    }
    
}
