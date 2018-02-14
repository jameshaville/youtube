import UIKit

class AccountCell: FeedCell {

  override func getVideos() {
    videoService.getVideos() { error, videos in
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
