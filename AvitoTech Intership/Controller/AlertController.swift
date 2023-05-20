import UIKit

class AlertController: UIAlertController {
    
    //MARK: - Properties
    var viewModel: SuggestionCellVM? {
        didSet {
            configureUI()
        }
    }
    
    //MARK: - Helpers
    func configureUI() {
        addAction(UIAlertAction(title: Constants.title, style: .cancel))
        guard let viewModel = viewModel else {
            title = Constants.message
            return
        }
        title = "\(viewModel.title)"
        message = "\(viewModel.description)"
    }
}

private extension Constants {
    static let title = "Закрыть"
    static let message = "Необходимо выбрать один из вариантов"
}
