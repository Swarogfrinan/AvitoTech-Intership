import Foundation


class PageData  {
    let title: String
    let actionTitle: String
    let selectedActionTitle: String
    var list: [Suggestion]
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? "-"
        self.actionTitle = dictionary["actionTitle"] as? String ?? "-"
        self.selectedActionTitle = dictionary["selectedActionTitle"] as? String ?? "-"
        self.list = []
        let listDictionary = dictionary["list"] as? [[String: Any]] ?? []
        
        for item in listDictionary {
            let isSelcted = item["isSelected"] as? Bool
            guard isSelcted == true else { break }
            self.list.append(Suggestion(dictionary: item))
        }
    }
}
struct Suggestion {
    var id: String
    var title: String
    var description: String
    var icon: [String: String]
    var price: String
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? "-"
        self.title = dictionary["title"] as? String ?? "-"
        self.description = dictionary["description"] as? String ?? "-"
        self.icon = dictionary["icon"] as? [String: String] ?? [:]
        self.price = dictionary["price"] as? String ?? "-"
    }
}

