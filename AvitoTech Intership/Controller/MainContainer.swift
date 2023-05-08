import UIKit

class MainContainer: UIViewController {
    
    var viewModel = MainContainerVM()
    lazy var screenTitle = makeScreenTitle()
    lazy var closeIcon = makeCloseIcon()
    lazy var collectionView = makeCollectionView()
    lazy var contentView = makeContentView()
    lazy var chooseButton = makeChooseButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension MainContainer {
    func makeCloseIcon() -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(systemName: "xMark")
        image.contentMode = .scaleAspectFill
        return image
    }
    
    func makeScreenTitle() -> UILabel {
    let title = UILabel()
        title.text = self.viewModel.title
        title.font = UIFont.boldSystemFont(ofSize: 30)
        title.numberOfLines = 0
        return title
    }
    
    func makeContentView() -> UIView {
        let view = UIView()
        return view
    }
    
    func makeCollectionView() -> UICollectionView {
        let suggestionCollectionView = self.viewModel.viewModelForSeggustionList()
        let collectionController = SuggestionList(viewModel : suggesctionViewModel)
        addChild(collectionController)
        collectionController.delegate = self
        return collectionController.view
    }
    func makeChooseButton() -> UIButton {
        let isActive = (viewModel.selectedSuggestion != nil) ? true : false
               let title = viewModel.selectedActionTitle
               let button = UIButton()
               button.setTitleColor(isActive ? .white : .mainBlue, for: .normal)
               button.setTitle(title, for: .normal)
               button.backgroundColor = isActive ? .mainBlue : .disableBlue
               button.layer.cornerRadius = 5
               button.addTarget(self, action: #selector(handleChoseBUtton(sender:)), for: .touchUpInside)
               return button
    }
}

private extension MainContainer: SuggestionsListDelegate {
    func selectedSuggestion(suggestion: SuggestionCellVM) {
        viewModel.selectedSuggestion = suggestion
        chooseButton = chooseButtonSettings()
        configureChoiseButton()
    }
}

