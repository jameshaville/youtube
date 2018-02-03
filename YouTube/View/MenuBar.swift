import UIKit

final class MenuBar: UIView {
  
  static let height: CGFloat = 44

  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: MenuItemCell.cellIdentifier)
    collectionView.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
    return collectionView
  }()
  
  let imageNames = ["home", "trending", "subscriptions", "account"]
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
    let indexPath = IndexPath(item: 0, section: 0)
    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
    addSubview(collectionView)
    collectionView.pinToSuperview()
  }
}

extension MenuBar: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageNames.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.cellIdentifier, for: indexPath) as! MenuItemCell
    guard let image = UIImage(named: imageNames[indexPath.item]) else { return UICollectionViewCell() }
    cell.imageView.image = image.withRenderingMode(.alwaysTemplate)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

extension MenuBar: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard imageNames.count > 0 else { return CGSize(width: 0, height: 0) }
    return CGSize(width: frame.width / CGFloat(imageNames.count), height: MenuBar.height)
  }
}
