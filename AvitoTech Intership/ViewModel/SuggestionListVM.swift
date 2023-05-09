import Foundation
class SuggestionListVM {
    
    private var data: [Suggestion]!
    var listCount: Int {
        return data.count
    }
    init(data: [Suggestion]!) {
        self.data = data
    }
    func viewModelForCell(indexPath: IndexPath) -> SuggestionCellVM {
        return SuggestionCellVM(data[indexPath.row])
    }
}
