import Foundation

class MainContainerVM {
    private var data: PageData!
    var selectedSuggestion: SuggestionCellVM?
    
    var title: String  {
        return data.title
    }
    var actionTitle: String {
        return data.actionTitle
    }
    
    var selectedActionTitle: String {
        return data.selectedActionTitle
    }
    
    init() {
        Service.instance.loadData(completion: { (data) in
            self.data = data
        })
    }
    
    func viewModelForSuggestionList() -> SuggestionListVM {
        return SuggestionListVM(data: data.list)
    }
    
}
