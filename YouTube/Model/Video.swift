import UIKit

struct Video {
  let title: String?
  let thumbnailImageUrlString: String?
  let numberOfViews: NSNumber?
  let uploadDate: Date?
  let channel: Channel?
}

struct Channel {
  let name: String?
  let profileImageName: String?
}

extension Video: APIResponse {
  init(json: [String: Any]) throws {
    guard let channelJson = json["channel"] as? [String: Any],
      let title = json["title"] as? String,
      let thumbnailImageUrlString = json["thumbnail_image_name"] as? String,
      let numberOfViews = json["number_of_views"] as? NSNumber else { throw Video.invalidDataError }
      let channel = Channel(name: channelJson["name"] as? String, profileImageName: channelJson["profile_image_name"] as? String)
    self.init(title: title, thumbnailImageUrlString: thumbnailImageUrlString, numberOfViews: numberOfViews, uploadDate: nil, channel: channel)
  }
}
