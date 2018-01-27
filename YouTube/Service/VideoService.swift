import Foundation

protocol VideoService {
  func getVideos(completion: @escaping (Error?, [Video]?) -> ())
}

final class VideoServiceImpl: VideoService {
  
  let videoJsonUrlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
  
  func getVideos(completion: @escaping (Error?, [Video]?) -> ()) {
    var videos = [Video]()
    guard let videoJsonUrl = URL(string: videoJsonUrlString) else { completion(nil, nil); return }
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
