import UIKit
import Kingfisher

class UserDetailsViewController: UIViewController {
    
    static let formatter: DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MM-YYYY"
        return dateformatter
    }()
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    
    public var user: User?
    private let userDetailsModel = UserDetailsModel()
    
    private var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if let old = oldValue {
                avatarImageView.removeConstraint(old)
            }
            if let new = aspectConstraint {
                avatarImageView.addConstraint(new)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserDetails()
        fetchAvatar(user?.avatar)
        guard let user = user else { return }
        navigationItem.title = "\(user.name)"
    }
    
    // MARK: - Fetch user's details
    
    private func fetchUserDetails() {
        userDetailsModel.requestUserDetails(user: user) { [weak self] result in
            guard let userDetails = result else { return }
            self?.fetchOrganizations(userDetails.organization)
            
            DispatchQueue.main.async {
                self?.nameLabel.text = userDetails.name
                self?.emailLabel.text = userDetails.email
                self?.followingLabel.text = "\(userDetails.following)"
                self?.followersLabel.text = "\(userDetails.followers)"
                let creationDate = UserDetailsViewController.formatter.string(from: userDetails.createdAt)
                self?.createdLabel.text = creationDate
            }
        }
    }
    
    // MARK: - Fetch user's organizations
    
    private func fetchOrganizations(_ url: URL?) {
        guard let url = url else { return }
        userDetailsModel.requestOrganizations(url) { [weak self] result in
            DispatchQueue.main.async {
                self?.organizationLabel.text = result?.map { $0.name }.joined(separator: ", ")
            }
        }
    }
    
    // MARK: - Fetch user's avatar
    
    private func fetchAvatar(_ url: URL?) {
        guard let url = user?.avatar else { return }
        avatarImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder.png")) {[weak self] (_, _, _, _) in
            self?.aspectConstraint = self?.avatarImageView.aspectConstraint
        }
    }
}
