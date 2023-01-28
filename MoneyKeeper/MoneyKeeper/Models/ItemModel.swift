//
//  ItemModel.swift
//  MoneyKeeper
//
//  Created by Олеся Егорова on 24.01.2023.
//

import Foundation


struct ItemModel {
    let item: String
    let date: String
    let sum: Int
}

enum IncomeItem: String, CaseIterable {
    case rent           = "Аренда"
    case salary         = "Зарплата"
    case investments    = "Инвестиции"
    case gifts          = "Подарки"
    case saving         = "Сбережения"
    case other          = "Другое"
}
enum ExpenseItem: String, CaseIterable {
    case rent               = "Аренда"
    case health             = "Здоровье"
    case cafe               = "Кафе"
    case credit             = "Кредит"
    case clothes            = "Одежда"
    case pet                = "Питомец"
    case gifts              = "Подарки"
    case products           = "Продукты"
    case entertainment      = "Развлечения"
    case connection         = "Связь"
    case sport              = "Спорт"
    case accounts           = "Счета"
    case transport          = "Транспорт"
    case other              = "Другое"
}


extension ItemModel {
    static func getIncomes() -> [ItemModel] {
        
        return [ItemModel(item: IncomeItem.gifts.rawValue, date: "10.01.23" , sum: 340),
                ItemModel(item: IncomeItem.other.rawValue, date: "11.01.23", sum: 10),
                ItemModel(item: IncomeItem.investments.rawValue, date: "11.01.23", sum: 100),
                ItemModel(item: IncomeItem.rent.rawValue, date: "16.01.23", sum: 890),
                ItemModel(item: IncomeItem.rent.rawValue, date: "16.01.23", sum: 1000),
                ItemModel(item: IncomeItem.salary.rawValue, date: "18.01.23", sum: 15000)].reversed()
    }
    static func getExpenses() -> [ItemModel] {
        
        return [ItemModel(item: ExpenseItem.cafe.rawValue, date: "07.01.23", sum: 750),
                ItemModel(item: ExpenseItem.clothes.rawValue, date: "15.01.23", sum: 100),
                ItemModel(item: ExpenseItem.accounts.rawValue, date: "15.01.23", sum: 130),
                ItemModel(item: ExpenseItem.accounts.rawValue, date: "06.01.23", sum: 130),
                ItemModel(item: ExpenseItem.rent.rawValue, date: "06.12.22", sum: 130),
        ].reversed()
    }
}

