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
        addAction(UIAlertAction(title: "Закрыть", style: .cancel))
        guard let viewModel = viewModel else {
            title = "Необходимо выбрать один из вариантов"
            return
        }
        title = "\(viewModel.title)"
        message = "\(viewModel.description)"
    }
}
