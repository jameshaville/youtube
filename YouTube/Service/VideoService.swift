import Foundation

protocol VideoService {
  func getVideos(for type: FeedType, completion: @escaping (Error?, [Video]?) -> ())
}

final class VideoServiceImpl: VideoService {
  
  private func videoJSONUrlString(for type: FeedType) -> String {
    let urlSuffix = ".json"
    return "https://s3-us-west-2.amazonaws.com/youtubeassets/" + type.rawValue + urlSuffix
  }
  
  func getVideos(for type: FeedType = .home, completion: @escaping (Error?, [Video]?) -> ()) {
    var videos = [Video]()
    let urlString = videoJSONUrlString(for: type)
    print(urlString)
    guard let videoJsonUrl = URL(string: urlString) else { completion(nil, nil); return }
    URLSession.shared.dataTask(with: videoJsonUrl) { data, response, error in
      if let error = error {
        completion(error, nil)
        return
      }
      guard let data = data else { return }
      
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        if let jsonDictionary = json as? [[String: Any]] {
          for videoJson in jsonDictionary {
            let video = try Video(json: videoJson)
            videos.append(video)
          }
        }
      } catch {
        completion(error, nil)
      }
      
      completion(nil, videos)
    }.resume()
  }
}
