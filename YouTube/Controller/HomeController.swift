import UIKit

final class HomeController: UIViewController {

  private let homeDataSource: HomeDataSource
  private let feedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  private let menuBar = MenuBar(frame: .zero)
  private let videoService: VideoService
  private var heightConstraint = NSLayoutConstraint()
  private let settingsView = SettingsView()
  
  let navigationTitleLabel: UILabel = {
    let label = UILabel()
    label.text = NSLocalizedString("Home", comment: "NavigationHome.Title")
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 20)
    return label
  }()
  
  init(videoService: VideoService, homeDataSource: HomeDataSource) {
    self.videoService = videoService
    self.homeDataSource = homeDataSource
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    
    super.viewDidLoad()

    setupViews()
    setupHierarchy()
    setupLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  private func setupViews() {
    setupNavigationBar()
    
    feedCollectionView.contentInsetAdjustmentBehavior = .never

    feedCollectionView.dataSource = self
    feedCollectionView.delegate = self
    feedCollectionView.isPagingEnabled = true
    feedCollectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.cellIdentifier)

    if let flowLayout = feedCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
      flowLayout.scrollDirection = .horizontal
    }
    
    settingsView.delegate = self
    menuBar.delegate = self
    
  }
  
  private func setupHierarchy() {
    view.addSubview(menuBar)
    view.addSubview(feedCollectionView)
  }
  
  private func setupLayout() {
    menuBar.translatesAutoresizingMaskIntoConstraints = false
    feedCollectionView.translatesAutoresizingMaskIntoConstraints = false

    menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    menuBar.pinToSuperview([.left, .right])
    menuBar.heightAnchor.constraint(equalToConstant: MenuBar.height).isActive = true
    
    feedCollectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
    feedCollectionView.pinToSuperview([.left, .bottom, .right])
  }
  
  private func setupNavigationBar() {
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.isTranslucent = false
    
    let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchTapped))
    let moreButton = UIBarButtonItem(image: #imageLiteral(resourceName: "nav_more_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(moreTapped))
    navigationItem.rightBarButtonItems = [moreButton, searchButton]
    let homeButton = UIBarButtonItem(title: NSLocalizedString("Home", comment: ""), style: .plain, target: self, action: nil)
    let titleTextAttributes: [NSAttributedStringKey: Any]? = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
    homeButton.setTitleTextAttributes(titleTextAttributes, for: .normal)
    homeButton.setTitleTextAttributes(titleTextAttributes, for: .highlighted)
    navigationItem.leftBarButtonItem = homeButton
  }
  
  @objc private func searchTapped() { print("search tapped") }
  @objc private func moreTapped() {
    settingsView.show()
  }
}

extension HomeController: SettingsViewDelegate {
  
  func show(_ settingsView: SettingsView, setting: Setting) {
    settingsView.dismiss { [weak self] in
      if setting.name == .cancel { return }
      let settingsController = UIViewController()
      settingsController.title = setting.name.rawValue
      settingsController.view.backgroundColor = .white
      self?.navigationController?.navigationBar.tintColor = .white
      self?.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
      self?.navigationController?.pushViewController(settingsController, animated: true)
    }
  }
  
  func dismiss(completion: @escaping ()->()) {
    settingsView.dismiss {
      completion()
    }
  }
}

extension HomeController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.cellIdentifier, for: indexPath)
    return cell
  }
  
}

extension HomeController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

extension HomeController: UICollectionViewDelegateFlowLayout {}

extension HomeController: UIScrollViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let xPosition = scrollView.contentOffset.x / CGFloat(menuBar.collectionView.numberOfItems(inSection: 0))
    let itemWidth = view.frame.width / CGFloat(menuBar.collectionView.numberOfItems(inSection: 0))
    menuBar.moveUnderlineTo(xPosition)
    
    let midXPosition = xPosition + itemWidth / 2
    let indexPath = menuBar.collectionView.indexPathForItem(at: CGPoint(x: midXPosition, y: menuBar.collectionView.frame.origin.y))
    menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
  }
}

extension HomeController: MenuBarDelegate {
  func scrollTo(item: Int) {
    let indexPath = IndexPath(item: item, section: 0)
    feedCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
  }
}
