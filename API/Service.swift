import Foundation
class Service {
    static let instance = Service()
    private init() {}
    
    func loadData(completion: @escaping(PageData) -> Void) {
        let dictionary = parseJSON()
        let pageDataModel = PageData(dictionary: dictionary)
        completion(pageDataModel)
    }
    private func parseJSON() -> Dictionary<String, Any> {
        let pathForFile = Bundle.main.path(forResource: "result", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: pathForFile))
        let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
        let resultDictionary = dictionary["result"] as! [String: Any]
        return resultDictionary
    }
}


