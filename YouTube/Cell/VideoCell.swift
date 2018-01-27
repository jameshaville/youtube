import UIKit

final class VideoCell: UICollectionViewCell {

  static var cellIdentifier: String {
    return "\(self)"
  }
  
  let thumbnailImageView: NetworkUIImageView = {
    let imageView = NetworkUIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  let separatorView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let userImageProfileView: NetworkUIImageView = {
    let imageView = NetworkUIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 22
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()
  
  let subtitleTextView: UITextView = {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.textColor = .lightGray
    textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
    return textView
  }()
  
  var video: Video? {
    didSet {
      titleLabel.text = video?.title
      thumbnailImageView.loadImage(from: video?.thumbnailImageUrlString ?? "")
      let numberFormatter = NumberFormatter()
      numberFormatter.numberStyle = .decimal
      if let channel = video?.channel, let profileImageName = channel.profileImageName, let channelName = channel.name, let numberOfViews = video?.numberOfViews, let numberOfViewsString = numberFormatter.string(from: numberOfViews) {
        userImageProfileView.loadImage(from: profileImageName)
        subtitleTextView.text = channelName + " " + numberOfViewsString  + " • 2 years ago"
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setupViews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - ViewConstants.defaultMargin * 2).isActive = true
    contentView.addSubviews(thumbnailImageView,
                            separatorView,
                            userImageProfileView,
                            titleLabel,
                            subtitleTextView)
    
    thumbnailImageView.pinToSuperview([.top, .left], constant: ViewConstants.defaultMargin)
    thumbnailImageView.pinToSuperview([.right], constant: -ViewConstants.defaultMargin)
    thumbnailImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    
    userImageProfileView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: ViewConstants.defaultMargin).isActive = true
    userImageProfileView.pinToSuperview([.left], constant: ViewConstants.defaultMargin)
    userImageProfileView.pinToSuperview([.bottom], constant: -ViewConstants.defaultMargin)
    userImageProfileView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    userImageProfileView.widthAnchor.constraint(equalToConstant: 44).isActive = true
    
    titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: ViewConstants.defaultMargin).isActive = true
    titleLabel.leftAnchor.constraint(equalTo: userImageProfileView.rightAnchor, constant: ViewConstants.defaultMargin).isActive = true
    titleLabel.pinToSuperview([.right], constant: -ViewConstants.defaultMargin)
    
    subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ViewConstants.defaultMargin/2).isActive = true
    subtitleTextView.leftAnchor.constraint(equalTo: userImageProfileView.rightAnchor, constant: ViewConstants.defaultMargin).isActive = true
    subtitleTextView.pinToSuperview([.right], constant: -ViewConstants.defaultMargin)
    subtitleTextView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: ViewConstants.defaultMargin).isActive = true

    separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    separatorView.pinToSuperview([.left, .bottom, .right])
  }
}
