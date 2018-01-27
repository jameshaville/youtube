import Foundation

public let APIResponseErrorDomain = "APIResponseErrorDomain"

protocol APIResponse {
  init(json: [String: Any]) throws
  static var invalidDataError: Error { get }
}

extension APIResponse {
  static var invalidDataError: Error {
    return NSError(domain: APIResponseErrorDomain, code: -1, userInfo: [NSLocalizedDescriptionKey: "Cannot parse json for object \(self)"])
  }
}
