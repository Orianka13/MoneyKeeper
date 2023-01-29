//
//  ItemModel.swift
//  MoneyKeeper
//
//  Created by Олеся Егорова on 24.01.2023.
//

import Foundation


struct Item: Equatable {
    let category: Category
    let item: String
    let date: Date
    let sum: Double
}

enum Category {
    case income
    case expense
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


//extension Item {
//    static func getItems() -> [Item] {
//
//        return [Item(category: .income, item: IncomeItem.gifts.rawValue, date: "10.01.23" , sum: 340),
//                Item(category: .income, item: IncomeItem.other.rawValue, date: "11.01.23", sum: 10),
//                Item(category: .income, item: IncomeItem.investments.rawValue, date: "11.01.23", sum: 100),
//                Item(category: .income, item: IncomeItem.rent.rawValue, date: "16.01.23", sum: 890),
//                Item(category: .income, item: IncomeItem.rent.rawValue, date: "16.01.23", sum: 1000),
//                Item(category: .expense, item: ExpenseItem.cafe.rawValue, date: "07.01.23", sum: 750),
//                Item(category: .expense, item: ExpenseItem.clothes.rawValue, date: "15.01.23", sum: 100),
//                Item(category: .expense, item: ExpenseItem.accounts.rawValue, date: "15.01.23", sum: 130)].reversed()
//    }
//}

