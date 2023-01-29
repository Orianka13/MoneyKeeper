//
//  ListViewController.swift
//  MoneyKeeper
//
//  Created by Олеся Егорова on 24.01.2023.
//

import UIKit

///Делегат для передачи данных из NewItemViewController
protocol NewItemViewControllerDelegate {
    func addNew(item: Item)
}

class ListViewController: UIViewController {
    ///Хранение шрифтов
    private enum Fonts {
        static let segmentedControllFont = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        static let cellTextFont = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        static let cellSecontTextFont = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        static let sectionHeaterFont = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
    }
    ///Хранение цветов
    private enum Colors {
        static let secondaryTextColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.7)
        static let sectionTextColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.5)
        static let cellTextColor: UIColor = .white
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    ///Основной массив хранения данных (не изменяемый)
    private var itemsData: [Item] = []
    ///Массив для заполнения таблицы (изменяемый)
    private var items: [Item] = []
    ///Массив с датами для секций
    private var dates: [Date] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setBalance()
        setDates()
        setSegmentedControl()
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        setValueOfSegmentedControl()
    }
    
    ///Установка содержимого таблицы в зависимсоти от значения SegmentedControl
    private func setValueOfSegmentedControl() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            items = itemsData.filter({$0.category == .income}).reversed()
            setDates()
            tableView.reloadData()
        default:
            items = itemsData.filter({$0.category == .expense}).reversed()
            setDates()
            tableView.reloadData()
        }
    }
    ///Внешний вид SegmentedControl
    private func setSegmentedControl(){
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, .font: Fonts.segmentedControllFont ?? UIFont()], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, .font: Fonts.segmentedControllFont ?? UIFont()], for: .normal)
    }
    ///Создает уникальный массив [Date]  и присваивает его dates
    private func setDates() {
        let mappingDates = items.map({$0.date})
        var uniqueDates: [Date] = []
        for date in mappingDates {
            if !uniqueDates.contains(date) {
                uniqueDates.append(date)
            }
        }
        dates = uniqueDates.sorted {$0 > $1}
    }
    /// Расчет Баланса и установка значения в title
    private func setBalance() {
        let totalIncome = itemsData.filter({$0.category == .income}).map({$0.sum}).reduce(0, +)
        let totalExpense = itemsData.filter({$0.category == .expense}).map({$0.sum}).reduce(0, +)
       
        title = "Баланс: \(totalIncome - totalExpense) руб"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let newItemVC = segue.destination as? NewItemViewController {
               newItemVC.delegate = self
               if segue.identifier == "addIncome" {
                   newItemVC.isIncome = true
               } else {
                   newItemVC.isIncome = false
               }
           }
       }
}

//MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filteredItems = items.filter{$0.date == dates[section]}
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let filteredItems = items.filter{$0.date == dates[indexPath.section]}
        let item = filteredItems[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = item.item
        content.textProperties.color = Colors.cellTextColor
        content.textProperties.font = Fonts.cellTextFont ?? UIFont()
        content.secondaryText = "\(item.sum) руб."
        content.secondaryTextProperties.color = Colors.secondaryTextColor
        content.secondaryTextProperties.font = Fonts.cellSecontTextFont ?? UIFont()
        cell.contentConfiguration = content
        return cell
    }
}


//MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dateLabel = UILabel(
            frame: CGRect(x: 20, y: 3, width: self.view.frame.width, height: 20)
        )
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        dateLabel.text = formatter.string(from: dates[section])
        dateLabel.font = Fonts.sectionHeaterFont
        dateLabel.textColor = Colors.sectionTextColor
        
        let contentVIew = UIView()
        contentVIew.addSubview(dateLabel)
        return contentVIew
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let filteredItems = items.filter{$0.date == dates[indexPath.section]}
            let item = filteredItems[indexPath.row]
            
            if let index = itemsData.firstIndex(of: item) {
                itemsData.remove(at: index)
            }
            if let itemIndex = items.firstIndex(of: item) {
                items.remove(at: itemIndex)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            setBalance()
        }
    }
}

// MARK: - NewItemViewControllerDelegate
extension ListViewController: NewItemViewControllerDelegate {
    func addNew(item: Item) {
        self.itemsData.append(item)
        items = itemsData.filter({$0.category == item.category}).reversed()
        setValueOfSegmentedControl()
        tableView.reloadData()
        setBalance()
        setDates()
    }
}
