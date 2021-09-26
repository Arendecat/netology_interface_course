import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var habit: Habit? {
        didSet {
            habitTitleLabel.text = habit?.name
            let df = DateFormatter()
            habitTimeLabel.text = "Каждый день в " + df.string(from: habit!.date)
            completionCounter.text = "Счетчик: \(habit!.trackDates.count)"
            habitTitleLabel.textColor = habit?.color
            completionCheck.layer.borderColor = habit!.color.cgColor
        }
    }
    
    let habitTitleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 16, weight: .semibold)
        title.numberOfLines = 2
        return title
    }()
    
    let habitTimeLabel: UILabel = {
        let time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.textColor = .lightGray
        time.font = .systemFont(ofSize: 12, weight: .light)
        return time
    }()
    
    let completionCounter: UILabel = {
        let counter = UILabel()
        counter.translatesAutoresizingMaskIntoConstraints = false
        counter.textColor = .lightGray
        counter.font = .systemFont(ofSize: 13, weight: .medium)
        return counter
    }()
    
    let completionCheck: UIButton = {
        let check = UIButton()
        check.translatesAutoresizingMaskIntoConstraints = false
        check.layer.cornerRadius = 16
        check.heightAnchor.constraint(equalToConstant: check.layer.cornerRadius*2).isActive = true
        check.widthAnchor.constraint(equalTo: check.heightAnchor).isActive = true
        check.layer.borderWidth = 2
        check.backgroundColor = .white
        check.addTarget(self, action: #selector(checked), for: .touchUpInside) // почему не работает?
        return check
    }()
    
    @objc func checked(){
        if (!habit!.isAlreadyTakenToday) {
            print("checked")
            completionCheck.backgroundColor = habit?.color
            completionCheck.setImage(UIImage(systemName: "checkmark"), for: .normal)
            completionCheck.tintColor = .white
            HabitsStore.shared.track(habit!)
        }
        
    }
    
    private func viewSetup() {
        contentView.addSubview(habitTitleLabel)
        contentView.addSubview(habitTimeLabel)
        contentView.addSubview(completionCounter)
        contentView.addSubview(completionCheck)
        
        contentView.layer.cornerRadius = 10
        
        contentView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 128),
            
            habitTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            habitTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 28),
            habitTitleLabel.rightAnchor.constraint(equalTo: completionCheck.leftAnchor, constant: -32),
            
            habitTimeLabel.topAnchor.constraint(equalTo: habitTitleLabel.bottomAnchor, constant: 16),
            habitTimeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 28),
            habitTimeLabel.rightAnchor.constraint(equalTo: completionCheck.leftAnchor, constant: -32),
            
            completionCounter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            completionCounter.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 28),
            completionCounter.rightAnchor.constraint(equalTo: completionCheck.leftAnchor, constant: -32),
            
            completionCheck.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            completionCheck.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32)
        ])
    }
}
