import UIKit

class SubscriptionsCell: FeedCell {
  
  override func getVideos() {
    videoService.getVideos(for: .subscriptions) { error, videos in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      self.videos = videos ?? []
      DispatchQueue.main.async { [weak self] in
        self?.videoListCollectionView.reloadData()
        self?.refreshControl.endRefreshing()
      }
    }
  }
}
