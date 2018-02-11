import UIKit

final class FeedCell: UICollectionViewCell {
  
  let videoService = VideoServiceImpl()
  private var videos = [Video]()
  
  static var cellIdentifier: String {
    return "\(self)"
  }
  
  lazy var videoListCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.dataSource = self
    collectionView.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.cellIdentifier)
    collectionView.backgroundColor = .white
    if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
    }
    return collectionView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    
    videoService.getVideos { error, videos in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      self.videos = videos ?? []
      DispatchQueue.main.async { [weak self] in
        self?.videoListCollectionView.reloadData()
      }
    }
    videoListCollectionView.contentInsetAdjustmentBehavior = .never
    
    translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - MenuBar.height - 44 - 44).isActive = true
    contentView.addSubview(videoListCollectionView)
    videoListCollectionView.pinToSuperview([.left, .right, .top])
    videoListCollectionView.pinToSuperview([.bottom], constant: -35)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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


