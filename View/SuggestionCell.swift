import UIKit

class SuggestionCell: UICollectionViewCell {
    
    // MARK: - Properties
    var viewModel: SuggestionCellVM? {
        didSet {
            title.text = viewModel!.title
            subTitle.text = viewModel!.description
            price.text = viewModel!.price
            setImageIcon()
        }
    }
    
   private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var title: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.Fonts.titleFont)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.Fonts.subTitleFont)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var price: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Constants.Fonts.priceFont)
        return label
    }()
    
    private lazy var isSelectedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(systemName: Constants.Image.selectedIcon)
        return imageView
    }()
    
    // MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(Constants.Messages.debugMessage)
        configureCell()
    }
    required init?(coder: NSCoder) {
        fatalError(Constants.Messages.fatalErrorMessage)
    }
    
    // MARK: - Methods
   private func configureCell() {
        backgroundColor = UIColor.cellBackground
        layer.cornerRadius = Constants.cellCornerRadius
        
        contentView.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.indent),
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.indent),
            iconImage.heightAnchor.constraint(equalToConstant: Constants.size),
            iconImage.widthAnchor.constraint(equalToConstant: Constants.size)
        ])
        
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: iconImage.topAnchor),
            title.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: Constants.indent),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.doubleIndent)
        ])
        contentView.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Constants.subTitle.top),
            subTitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.doubleIndent)
        ])
        contentView.addSubview(price)
        price.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            price.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: Constants.indent),
            price.leadingAnchor.constraint(equalTo: subTitle.leadingAnchor),
            price.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.doubleIndent)
        ])
        contentView.addSubview(isSelectedIcon)
        isSelectedIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            isSelectedIcon.topAnchor.constraint(equalTo: title.topAnchor, constant: Constants.top),
            isSelectedIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.doubleIndent),
            isSelectedIcon.heightAnchor.constraint(equalToConstant: Constants.smallSize),
            isSelectedIcon.widthAnchor.constraint(equalToConstant: Constants.smallSize)
        ])
    }
    //MARK: - Helpers
   private func setImageIcon() {
        if (iconImage.image == nil) {
            DispatchQueue.main.async {
                self.iconImage.image = self.viewModel?.iconImage()
            }
        }
    }
    override var isHighlighted: Bool {
        didSet {
            
            UIView.animate(withDuration: Constants.duration) {
                self.backgroundColor = self.isHighlighted ? .grayLight : .cellBackground
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.isSelectedIcon.alpha = .zero
                self.isSelectedIcon.isHidden = false
                UIView.animate(withDuration: Constants.duration) {
                    self.isSelectedIcon.alpha = 1.0
                }
            } else {
                self.isSelectedIcon.alpha = 1.0
                self.isSelectedIcon.isHidden = false
                UIView.animate(withDuration: Constants.duration) {
                    self.isSelectedIcon.alpha = .zero
                }
            }
        }
    }
}

private extension Constants {
    
    enum Messages {
        static let fatalErrorMessage = "init(coder:) has not been implemented"
        static let debugMessage = "DEBUG: Init cell"
    }
    
    enum Image {
        static let selectedIcon = "checkmark.circle.fill"
    }
    
    enum Fonts {
        static let titleFont : CGFloat = 20
        static let subTitleFont : CGFloat = 16
        static let priceFont : CGFloat = 18
    }
    
    enum subTitle {
        static let top : CGFloat = 10
    }
  
    static let size : CGFloat = 52
    static let smallSize : CGFloat = 25
    static let doubleIndent : CGFloat = 30
    static let duration : CGFloat = 0.4
}
    
