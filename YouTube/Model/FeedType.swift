enum FeedType: String {
  case home
  case trending
  case subscriptions
  case account
  
  func cellIdentifier() -> String {
    switch self {
    case .home:  return "HomeCell"
    case .trending: return "TrendingCell"
    case .subscriptions: return "SubscriptionsCell"
    case .account: return "AccountCell"
    }
    
  }
}
