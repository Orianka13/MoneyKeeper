//
//  User.swift
//  MoneyKeeper
//
//  Created by Артём on 29.01.2023.
//

struct User {
    let login: String
    let password: String
    let developer: [Developer]
    
    static func getUserData() -> User {
        User(
            login: "1",
             password: "1",
            developer: Developer.getDeveloper()
        )
    }

}

struct Developer {
    let name: String
    let surName: String
    var fullName: String {
        "\(name) \(surName)"
    }
    
    static func getDeveloper() -> [Developer] {
        [
        Developer(
            name: "Артем",
            surName: "Петров"
        ),
        Developer(
            name: "Олеся",
            surName: "Петров"
        ),
        Developer(
            name: "Филипп",
            surName: "Петров"
        )
        ]
    }
}
