import UIKit

protocol SettingsViewDelegate: class {
  func show(_ settingsView: SettingsView, setting: Setting)
  func dismiss(completion: @escaping ()->())
}

final class SettingsView: UIView {
  
  private static let height: CGFloat = 300
  private var heightConstraint = NSLayoutConstraint()
  private var hasSetup = false
  weak var delegate: SettingsViewDelegate?

  private let settings = [
    Setting(name: .settings, iconImageName: SettingImageNames.settings),
    Setting(name: .terms, iconImageName: SettingImageNames.terms),
    Setting(name: .feedback, iconImageName: SettingImageNames.feedback),
    Setting(name: .help, iconImageName: SettingImageNames.help),
    Setting(name: .accountSwitch, iconImageName: SettingImageNames.account),
    Setting(name: .cancel, iconImageName: SettingImageNames.cancel)
  ]
  
  let settingsMenu: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .white
    tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.cellIdentifier)
    tableView.estimatedRowHeight = 40
    tableView.rowHeight = UITableViewAutomaticDimension
    return tableView
  }()
  
  let dimmedView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor(white: 0, alpha: 0.5)
    view.isHidden = true
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    
    guard let keyWindow = UIApplication.shared.keyWindow else { return }
    keyWindow.addSubview(dimmedView)
    keyWindow.addSubview(settingsMenu)
    
    dimmedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissByTap)))

    settingsMenu.dataSource = self
    settingsMenu.delegate = self
    
    setupLayout()
    hasSetup = true
  }
  
  private func setupLayout() {
    dimmedView.pinToSuperview()
    settingsMenu.pinToSuperview([.left, .bottom, .right])
    heightConstraint = settingsMenu.heightAnchor.constraint(equalToConstant: 0)
    heightConstraint.isActive = true
    UIApplication.shared.keyWindow?.layoutIfNeeded()
  }
  
  func show() {
    if !hasSetup { setup() }
    performShow()
  }
  
  @objc func dismissByTap() {
    performDismissal()
  }
  
  func dismiss(completion: @escaping () -> ()) {
    performDismissal {
      completion()
    }
  }
  
  private func performDismissal(_ completion: (()->())? = nil) {
    UIView.animate(withDuration: 0.5) {
      self.dimmedView.alpha = 0
      self.heightConstraint.constant = 0
      UIApplication.shared.keyWindow?.layoutIfNeeded()
      completion?()
    }
  }
  
  private func performShow() {
    dimmedView.alpha = 0
    dimmedView.isHidden = false
    UIView.animate(withDuration: 0.5) {
      self.dimmedView.alpha = 1
      self.heightConstraint.constant = SettingsView.height
      UIApplication.shared.keyWindow?.layoutIfNeeded()
    }
  }
  
}

extension SettingsView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.cellIdentifier) as! SettingsCell
    cell.update(with: settings[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return settings.count
  }
}

extension SettingsView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let setting = settings[indexPath.row]
    self.delegate?.show(self, setting: setting)
  }
}
