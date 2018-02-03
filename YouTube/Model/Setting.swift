import Foundation

struct Setting {
  let name: SettingName
  let iconImageName: String
}

enum SettingName: String {
  case settings = "Settings"
  case terms = "Terms & privacy policy"
  case feedback = "Send Feedback"
  case help = "Help"
  case accountSwitch = "Switch Account"
  case cancel = "Cancel"
}

struct SettingImageNames {
  static let settings = "settings"
  static let terms = "privacy"
  static let feedback = "feedback"
  static let help = "help"
  static let account = "switch_account"
  static let cancel = "cancel"
}
