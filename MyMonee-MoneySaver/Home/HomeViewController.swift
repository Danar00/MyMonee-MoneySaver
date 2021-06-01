//
//  HomeViewController.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EmptyDataDelegate {
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelBalance: UILabel!
    
    @IBOutlet var greeting: UILabel!
    
    @IBOutlet weak var lastDeposit: UILabel!
    
    @IBOutlet weak var lastWithdraw: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var emptyDataViewComponent: EmptyDataHome!
    
        var networkService: NetworkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        emptyDataViewComponent.delegate = self
        
        let uiNib = UINib(nibName: String(describing: HomeViewCell.self), bundle: nil)
        tableView.register(uiNib, forCellReuseIdentifier: String(describing: HomeViewCell.self))
        
        labelBalance.text! = currentCurrency()
        lastDeposit.text! = getLastTransactionDeposit()
        lastWithdraw.text! = getLastTransactionWithdraw()
        
        emptyDataViewComponent.isHidden = true
        
        greetings()
//        validateEmptyData()
        
        
        
        loadData()
        
        //Utk presisten data
//        if let savedData = UserDefaults.standard.value(forKey: "savedArray") as? Data {
//            let _usageHistory = try? PropertyListDecoder().decode(Array<UsageHistory>.self, from: savedData)
//            usageHistory = _usageHistory ?? []
//        }

    }
    func loadData() {
        networkService.loadTransactionList { (UsageHistory) in
            DispatchQueue.main.async {
                self.loadingIndicator.startAnimating()
                usageHistory = UsageHistory
                self.tableView.reloadData()
                self.labelBalance.text! = self.currentCurrency()
                self.lastDeposit.text! = getLastTransactionDeposit()
                self.lastWithdraw.text! = getLastTransactionWithdraw()
                self.validateEmptyData()
                self.loadingIndicator.stopAnimating()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usageHistory.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeViewCell.self), for: indexPath) as! HomeViewCell
        cell.selectionStyle = .none
        cell.titleLabel.text = usageHistory[indexPath.row].usageName
        
        cell.dateLabel.text = usageHistory[indexPath.row].formatDate()
        if usageHistory[indexPath.row].status {
            cell.imageStatus.image = UIImage(named: "ic_down")
            cell.priceLabel.text = convertIntToFormatMoney(money: usageHistory[indexPath.row].price, isDepoOrWithdraw: .withdraw)
            cell.priceLabel.textColor = .red
        }
        else{
            cell.imageStatus.image = UIImage(named: "ic_up")
            cell.priceLabel.text = convertIntToFormatMoney(money: usageHistory[indexPath.row].price, isDepoOrWithdraw: .deposit)
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        labelName.text! = user.username
//        loadData()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        labelBalance.text! = convertIntToFormatMoney(money: Int(getBalance()), isDepoOrWithdraw: nil)
//        lastDeposit.text! = getLastTransactionDeposit()
//        lastWithdraw.text! = getLastTransactionWithdraw()
//        validateEmptyData()
        loadData()
//        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailHomeViewController = DetailHomeViewController(nibName: String(describing: DetailHomeViewController.self), bundle: nil)
        
        let selectedRow = usageHistory[indexPath.row]
        detailHomeViewController.textTitle = selectedRow.usageName
        detailHomeViewController.textId = "\(selectedRow.id)"
        detailHomeViewController.textDate = selectedRow.usageDate
        detailHomeViewController.indexData = indexPath.row
        
        if usageHistory[indexPath.row].status {
            detailHomeViewController.textStatus = "Pengeluaran"
            detailHomeViewController.imageToShow = UIImage(named: "ic_down")
            detailHomeViewController.colorToShow = .red
            detailHomeViewController.textPrice = convertIntToFormatMoney(money: selectedRow.price, isDepoOrWithdraw: .withdraw)
        }
        else{
            detailHomeViewController.textStatus = "Pemasukan"
            detailHomeViewController.imageToShow = UIImage(named: "ic_up")
            detailHomeViewController.colorToShow = .systemGreen
            detailHomeViewController.textPrice = convertIntToFormatMoney(money: selectedRow.price, isDepoOrWithdraw: .deposit)
        }
        
        navigationController?.pushViewController(detailHomeViewController, animated: true)
    }
    
    @IBAction func addHomeButton(_ sender: Any) {
        let addHome = AddHomeViewController(nibName: String(describing: AddHomeViewController.self), bundle: nil)
        navigationController?.pushViewController(addHome, animated: true)
    }
    
    func validateEmptyData(){
        if usageHistory.isEmpty {
            tableView.isHidden = true
            emptyDataViewComponent.isHidden = false
        }
        else{
            tableView.isHidden = false
            emptyDataViewComponent.isHidden = true
        }
    }
    
    func greetings(){
        let date = NSDate()
        let calendar = NSCalendar.current
        let currentHour = calendar.component(.hour, from: date as Date)
        let hourInt = Int(currentHour.description)!
        var greeting = ""
        
        if hourInt >= 10 && hourInt <= 15 {
            greeting = "Selamat Siang,"
        }
        else if hourInt >= 6 && hourInt <= 10 {
            greeting = "Good Morning,"
        }
        else if hourInt >= 15 && hourInt <= 20 {
            greeting = "Selamat Sore,"
        }
        else if hourInt >= 20 && hourInt <= 24 {
            greeting = "Selamat Malam,"
        }
        else if hourInt >= 0 && hourInt <= 6 {
            greeting = "You should be sleeping right now"
        }
        self.greeting.text = greeting
    }
    
    func add() {
        let addHome = AddHomeViewController(nibName: String(describing: AddHomeViewController.self), bundle: nil)
        navigationController?.pushViewController(addHome, animated: true)
    }
}

extension HomeViewController: ConvertCurrency {
    func currentCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "Id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        var result: String = ""
        if let formatterTipAmount = formatter.string(from: getBalance() as NSNumber) {
            result = "Rp \(formatterTipAmount)"
        }
        return result
    }
}


