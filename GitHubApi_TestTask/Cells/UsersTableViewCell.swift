import UIKit

class UsersTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "usersCell"
    
    var avatar = UIImageView()
    var name = UILabel()
    var id = UILabel()
    var user: User? {
        didSet {
            guard let user = user else { return }
            name.text = user.name
            id.text = "\(user.id)"
            guard let url = user.avatar else { return }
            avatar.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder.png")) { [weak self] (_, _, _, _) in
                self?.aspectConstraint = self?.avatar.aspectConstraint
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        avatar.kf.cancelDownloadTask()
    }
    
    // MARK: - Constraints
    
    private var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if let old = oldValue {
                avatar.removeConstraint(old)
            }
            if let new = aspectConstraint {
                avatar.addConstraint(new)
            }
        }
    }
    
    private func setConstraints() {
        [avatar, name, id].forEach { contentView.addSubview($0) }
        [avatar, name, id].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatar.widthAnchor.constraint(lessThanOrEqualToConstant: 70),
            avatar.heightAnchor.constraint(lessThanOrEqualToConstant: 70),
            
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            name.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            
            id.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            id.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            id.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            id.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8)
            ])
    }
}
