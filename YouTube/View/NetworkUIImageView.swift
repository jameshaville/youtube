import UIKit

final class NetworkUIImageView: UIImageView {
  
  private static let imageCache = NSCache<NSString, UIImage>()
  private var currentUrlString: String?
  
  func loadImage(from urlString: String) {
    image = nil
    
    guard let url = URL(string: urlString) else { return }
    
    self.currentUrlString = urlString

    if let imageFromCache = NetworkUIImageView.imageCache.object(forKey: urlString as NSString) {
      image = imageFromCache
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      guard self.currentUrlString == urlString, let data = data, let image = UIImage(data: data) else { return }
      NetworkUIImageView.imageCache.setObject(image, forKey: urlString as NSString)
      DispatchQueue.main.async {
        self.image = image
      }
    }.resume()
  }
  
}

