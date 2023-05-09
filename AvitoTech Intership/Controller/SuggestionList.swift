import UIKit
private let reuseIdentifier = "suggestionCell"
protocol SuggestionsListDelegate {
    func selectedSuggestion(suggestion: SuggestionCellVM)
}

class SuggestionList: UICollectionViewController {
    //MARK: - Properties
    var viewModel: SuggestionListVM!
    var delegate: SuggestionsListDelegate?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(SuggestionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        }
    //MARK: - Initialize
    init(viewModel : SuggestionListVM) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
