//
//  User.swift
//  MoneyKeeper
//
//  Created by Артём on 29.01.2023.
//

struct User {
    let login: String
    let password: String
    let person: Person
    
    static func getUserData() -> User {
        User(
            login: "1",
             password: "1",
            person: Person.getPerson()
        )
    }

}

struct Person {
    let name: String
    let surName: String
    var fullName: String {
        "\(name) \(surName)"
    }
    
    static func getPerson() -> Person {
        Person(
            name: "Иван",
            surName: "Петров"
        )
    }
}
