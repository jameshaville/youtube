import UIKit

class FeedCell: UICollectionViewCell {

  let videoService = VideoServiceImpl()
  var videos = [Video]()
  let refreshControl = UIRefreshControl()

  lazy var videoListCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.dataSource = self
    collectionView.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.cellIdentifier)
    collectionView.backgroundColor = .white
    collectionView.alwaysBounceVertical = true
    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
    }
    
    refreshControl.addTarget(self, action: #selector(getVideos), for: .valueChanged)
    collectionView.backgroundView = refreshControl
    
    return collectionView
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .white
    
    videoListCollectionView.contentInsetAdjustmentBehavior = .never
    
    translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - MenuBar.height - 44 - 44).isActive = true
    contentView.addSubview(videoListCollectionView)
    videoListCollectionView.pinToSuperview([.left, .right, .top])
    videoListCollectionView.pinToSuperview([.bottom], constant: -35)
    
    getVideos()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func getVideos() {}
}

extension FeedCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.cellIdentifier, for: indexPath) as! VideoCell
    cell.video = videos[indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}


