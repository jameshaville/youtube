import UIKit

final class HomeController: UIViewController {

  private let homeDataSource: HomeDataSource
  private let videoListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  private let menuBar = MenuBar(frame: .zero)
  private let videoService: VideoService
  
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

    videoService.getVideos { error, videos in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      DispatchQueue.main.async { [weak self] in
        self?.homeDataSource.update(with: videos ?? [])
        self?.videoListCollectionView.reloadData()
      }
    }
    
    setupViews()
    setupHierarchy()
    setupLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  private func setupViews() {
    setupNavigationBar()

    videoListCollectionView.backgroundColor = .white
    videoListCollectionView.alwaysBounceVertical = true
    videoListCollectionView.dataSource = homeDataSource
    videoListCollectionView.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.cellIdentifier)
    
    if let flowLayout = videoListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
    }
  }
  
  private func setupHierarchy() {
    view.addSubview(menuBar)
    view.addSubview(videoListCollectionView)
  }
  
  private func setupLayout() {
    videoListCollectionView.translatesAutoresizingMaskIntoConstraints = false
    menuBar.translatesAutoresizingMaskIntoConstraints = false
    
    menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    menuBar.pinToSuperview([.left, .right])
    menuBar.heightAnchor.constraint(equalToConstant: MenuBar.height).isActive = true
    
    videoListCollectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
    videoListCollectionView.pinToSuperview([.left, .right, .bottom])
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
  @objc private func moreTapped() { print("more tapped") }
}
