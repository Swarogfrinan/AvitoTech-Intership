import UIKit

class MainContainer: UIViewController {
    
    //MARK: Properties
    
    var viewModel = MainContainerVM()
    lazy var screenTitle = makeScreenTitle()
    lazy var closeIcon = makeCloseIcon()
    lazy var collectionView = makeCollectionView()
    lazy var contentView = makeContentView()
    lazy var chooseButton = makeChooseButton()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    //MARK: - Selectors
    @objc func handleChoseButton(sender: UIButton) {
        UIButton.animateHandleButton(sender: sender) {
            guard let suggestion = self.viewModel.selectedSuggestion else {
                self.initAlertController(suggestion: nil)
                return
            }
            self.initAlertController(suggestion: suggestion)
        }
        
    }
}

private extension MainContainer {
    func makeCloseIcon() -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(systemName: "xmark")
        image.contentMode = .scaleAspectFit
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
    
    func makeCollectionView() -> UIView {
        let suggestionCollectionViewModel = self.viewModel.viewModelForSuggestionList()
        let collectionController = SuggestionList(viewModel : suggestionCollectionViewModel)
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
        button.addTarget(self, action: #selector(handleChoseButton(sender:)), for: .touchUpInside)
        return button
    }
}
extension MainContainer {
    func initAlertController(suggestion: SuggestionCellVM?) {
        let alert = AlertController(title: "", message: "", preferredStyle: .alert)
        alert.viewModel = suggestion
        present(alert, animated: true)
    }
    
    func chooseButtonSettings() -> UIButton {
        let isActive = (viewModel.selectedSuggestion != nil) ? true : false
        let title = viewModel.selectedActionTitle
        let button = UIButton()
        button.setTitleColor(isActive ? .white : .mainBlue, for: .normal)
        button.setTitle(title, for: .normal)
        button.backgroundColor = isActive ? .mainBlue : .disableBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleChoseButton(sender:)), for: .touchUpInside)
        return button
    }
    func configureChouseButton() {
        contentView.addSubview(chooseButton)
        NSLayoutConstraint.activate([
            chooseButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            chooseButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            chooseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            chooseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension MainContainer: SuggestionsListDelegate {
    func selectedSuggestion(suggestion: SuggestionCellVM) {
        viewModel.selectedSuggestion = suggestion
        chooseButton = chooseButtonSettings()
        configureChouseButton()
    }
}

extension MainContainer {
    //MARK: - Constraints
    func configureView() {
        for views in [contentView, collectionView, closeIcon, screenTitle, chooseButton] {
            views.translatesAutoresizingMaskIntoConstraints = false
        }
        view.backgroundColor = .white
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        contentView.addSubview(closeIcon)
        NSLayoutConstraint.activate([
            closeIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            closeIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            closeIcon.widthAnchor.constraint(equalToConstant: 20),
            closeIcon.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        contentView.addSubview(screenTitle)
        NSLayoutConstraint.activate([
            screenTitle.topAnchor.constraint(equalTo: closeIcon.bottomAnchor, constant: 20),
            screenTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screenTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        configureChouseButton()
        
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: chooseButton.topAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
            
        ])
    }
}
