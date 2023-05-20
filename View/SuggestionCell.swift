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
    
    lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var title: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var isSelectedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        return imageView
    }()
    // MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("DEBUG: Init cell")
        configureCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell() {
        backgroundColor = UIColor.cellBackground
        layer.cornerRadius = 10
        
        contentView.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            iconImage.heightAnchor.constraint(equalToConstant: 52),
            iconImage.widthAnchor.constraint(equalToConstant: 52)
        ])
        
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: iconImage.topAnchor),
            title.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
        contentView.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            subTitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
        contentView.addSubview(price)
        price.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            price.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 15),
            price.leadingAnchor.constraint(equalTo: subTitle.leadingAnchor),
            price.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
        contentView.addSubview(isSelectedIcon)
        isSelectedIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            isSelectedIcon.topAnchor.constraint(equalTo: title.topAnchor, constant: 25),
            isSelectedIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            isSelectedIcon.heightAnchor.constraint(equalToConstant: 25),
            isSelectedIcon.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    //MARK: - Helpers
    func setImageIcon() {
        if (iconImage.image == nil) {
            DispatchQueue.main.async {
                self.iconImage.image = self.viewModel?.iconImage()
            }
        }
    }
    override var isHighlighted: Bool {
        didSet {
            
            UIView.animate(withDuration: 0.4) {
                self.backgroundColor = self.isHighlighted ? .grayLight : .cellBackground
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.isSelectedIcon.alpha = 0.0
                self.isSelectedIcon.isHidden = false
                UIView.animate(withDuration: 0.3) {
                    self.isSelectedIcon.alpha = 1.0
                }
            } else {
                self.isSelectedIcon.alpha = 1.0
                self.isSelectedIcon.isHidden = false
                UIView.animate(withDuration: 0.3) {
                    self.isSelectedIcon.alpha = 0.0
                }
            }
        }
    }
    
    
}
    
