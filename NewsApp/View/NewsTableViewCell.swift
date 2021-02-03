import UIKit

final class NewsTableViewCell: UITableViewCell, NewsCellView {
    
    let titlelabel = UILabel()
    let descriptionLabel = UILabel()
    
    static let identifier = "NewsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addElementsToContentView(view: titlelabel)
        addElementsToContentView(view: descriptionLabel)
        
        setupConstraints()
        
        setNumberOfLines(for: titlelabel)
        setNumberOfLines(for: descriptionLabel)
        
        titlelabel.font = AppTheme.sanFranciscoFont()
        descriptionLabel.font = AppTheme.sanFranciscoFont(with: .S)
    }
    
    
    // MARK: - Private Method
    
    private func setNumberOfLines(for textLabel : UILabel) {
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
    }
    
    private func addElementsToContentView( view: UIView) {
        contentView.addSubview(view)
    }
    private func setupConstraints() {
        
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titlelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titlelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titlelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titlelabel.leadingAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
       
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(title: String) {
        titlelabel.text = title
    }
    
    func display(description: String) {
        descriptionLabel.text = description
    }
}

