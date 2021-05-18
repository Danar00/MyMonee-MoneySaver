//
//  HomeViewController.swift
//  MyMonee-MoneySaver
//
//  Created by MacBook on 13/05/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelBalance: UILabel!
    
    @IBOutlet var greeting: UILabel!
    
    @IBOutlet weak var lastDeposit: UILabel!
    
    @IBOutlet weak var lastWithdraw: UILabel!
    
    @IBOutlet weak var emptyDataViewHome: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let uiNib = UINib(nibName: String(describing: HomeViewCell.self), bundle: nil)
        tableView.register(uiNib, forCellReuseIdentifier: String(describing: HomeViewCell.self))
        
        labelBalance.text! = convertIntToFormatMoney(money: Int(getBalance()), isDepoOrWithdraw: nil)
        lastDeposit.text! = getLastTransactionDeposit()
        lastWithdraw.text! = getLastTransactionWithdraw()
        greetings()
        validateEmptyData()
        
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usageHistory.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeViewCell.self), for: indexPath) as! HomeViewCell
        cell.selectionStyle = .none
        cell.titleLabel.text = usageHistory[indexPath.row].usageName
        
        cell.dateLabel.text = usageHistory[indexPath.row].usageDate
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
            
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailHomeViewController = DetailHomeViewController(nibName: String(describing: DetailHomeViewController.self), bundle: nil)
        
        detailHomeViewController.hidesBottomBarWhenPushed = true
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
            emptyDataViewHome.isHidden = false
        }
        else{
            tableView.isHidden = false
            emptyDataViewHome.isHidden = true
        }
    }
    
    
    @IBAction func addUsageDataButton(_ sender: Any) {
        let addHome = AddHomeViewController(nibName: String(describing: AddHomeViewController.self), bundle: nil)
        navigationController?.pushViewController(addHome, animated: true)
    }
    
    func greetings(){
        let date = NSDate()
        let calendar = NSCalendar.current
        let currentHour = calendar.component(.hour, from: date as Date)
        let hourInt = Int(currentHour.description)!
        var greeting = ""
        
        if hourInt >= 12 && hourInt <= 16 {
            greeting = "Selamat Siang,"
        }
        else if hourInt >= 7 && hourInt <= 12 {
            greeting = "Selamat Pagi,"
        }
        else if hourInt >= 16 && hourInt <= 20 {
            greeting = "Selamat Sore,"
        }
        else if hourInt >= 20 && hourInt <= 24 {
            greeting = "Selamat Malam,"
        }
        else if hourInt >= 0 && hourInt <= 7 {
            greeting = "You should be sleeping right now"
        }
        self.greeting.text = greeting
    }
    
    

}
