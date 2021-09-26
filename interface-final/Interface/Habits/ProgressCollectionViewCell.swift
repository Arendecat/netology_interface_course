import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let motivationLabel: UILabel = {
        let mLabel = UILabel()
        mLabel.translatesAutoresizingMaskIntoConstraints = false
        mLabel.text = "Все получится!"
        mLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        mLabel.textColor = .lightGray
        return mLabel
    }()
    
    let progressPercent: UILabel = {
        let pPercent = UILabel()
        pPercent.translatesAutoresizingMaskIntoConstraints = false
        pPercent.font = .systemFont(ofSize: 13, weight: .semibold)
        pPercent.textColor = .lightGray
        return pPercent
    }()
    
    let progressBar: UIProgressView = {
       let pBar = UIProgressView()
        pBar.translatesAutoresizingMaskIntoConstraints = false
        pBar.progressViewStyle = .bar
        pBar.progress = HabitsStore.shared.todayProgress
        return pBar
    }()
    
    private func viewSetup() {
        contentView.addSubview(motivationLabel)
        contentView.addSubview(progressPercent)
        contentView.addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            motivationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            motivationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            motivationLabel.rightAnchor.constraint(equalTo: progressPercent.leftAnchor, constant: -16),
            
            progressPercent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            progressPercent.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            progressBar.topAnchor.constraint(equalTo: motivationLabel.bottomAnchor, constant: 16),
            progressBar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            progressBar.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
