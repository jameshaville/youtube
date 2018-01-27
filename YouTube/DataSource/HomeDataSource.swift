import UIKit

final class HomeDataSource: NSObject {
  private var videos = [Video]()
  
  func update(with videos: [Video]) {
    self.videos = videos
  }
}

extension HomeDataSource: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.cellIdentifier, for: indexPath) as! VideoCell
    cell.video = videos[indexPath.item]
    return cell
  }
}
