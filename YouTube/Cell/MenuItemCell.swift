import UIKit

final class MenuItemCell: UICollectionViewCell {
  
  static var cellIdentifier: String {
    return "\(self)"
  }
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.tintColor = UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupHierarchy()
    setupLayout()
  }
  
  override var isSelected: Bool {
    didSet {
      imageView.tintColor = isSelected ? .white : UIColor(red: 91/255, green: 14/255, blue: 13/255, alpha: 1)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  private func setupViews() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setupHierarchy() {
    addSubview(imageView)
  }
  
  private func setupLayout() {
    imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
  }
}
