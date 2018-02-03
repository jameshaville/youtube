import UIKit

final class SettingsCell: UITableViewCell {
  
  static var cellIdentifier: String {
    return "\(self)"
  }
  
  let iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 13)
    return label
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    translatesAutoresizingMaskIntoConstraints = false
    selectionStyle = .none
    setupHierarcy()
    setupLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  private func setupHierarcy() {
    contentView.addSubview(iconImageView)
    contentView.addSubview(nameLabel)
  }
  
  private func setupLayout() {
    iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    iconImageView.pinToSuperview([.left], constant: ViewConstants.defaultMargin)
    nameLabel.pinToSuperview([.top], constant: ViewConstants.defaultMargin * 2)
    nameLabel.pinToSuperview([.bottom], constant: -ViewConstants.defaultMargin * 2)
    nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: ViewConstants.defaultMargin).isActive = true
    iconImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
  }
  
  func update(with setting: Setting) {
    nameLabel.text = setting.name.rawValue
    iconImageView.image = UIImage(named: setting.iconImageName)?.withRenderingMode(.alwaysTemplate)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    backgroundColor = selected ? .darkGray : .white
    nameLabel.textColor = selected ? .white : .black
    iconImageView.tintColor = selected ? .white : .darkGray
  }
  
  override func setHighlighted(_ hightlighted: Bool, animated: Bool) {
    super.setHighlighted(hightlighted, animated: animated)
    backgroundColor = hightlighted ? .darkGray : .white
    nameLabel.textColor = hightlighted ? .white : .black
    iconImageView.tintColor = hightlighted ? .white : .darkGray
  }
}
