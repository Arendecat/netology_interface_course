import UIKit

class HabitView: UIView{
    override init(frame: CGRect){
        super.init(frame: frame)
        viewSetup()
    }
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

    var pickedDate: Date = Date()
    
    let nameFieldLabel: UILabel = {
        let nameFieldLabel = UILabel()
        nameFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        nameFieldLabel.text = "НАЗВАНИЕ"
        nameFieldLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        return nameFieldLabel
    }()
    
    let nameField: UITextField = {
        let nameField = UITextField()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholder = "Бегать по утрам, спать 8 часов, и т.п."
        return nameField
    }()
    
    let colorPickerLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.text = "ЦВЕТ"
        colorLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        return colorLabel
    }()
    
    let colorPicker: UIButton = {
        let colorPicker = UIButton()
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        colorPicker.backgroundColor = .systemBlue
        colorPicker.layer.cornerRadius = 16
        colorPicker.heightAnchor.constraint(equalToConstant: colorPicker.layer.cornerRadius*2).isActive = true
        colorPicker.widthAnchor.constraint(equalTo: colorPicker.heightAnchor).isActive = true
        colorPicker.layer.masksToBounds = true
        return colorPicker
    }()
    
    let timePickerLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = "ВРЕМЯ"
        timeLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        return timeLabel
    }()
    
    let timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        return timePicker
    }()
    
    let deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.isHidden = true
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.setTitle("Удалить привычку", for: .normal)
        return deleteButton
    }()
    
    @objc func datePickerChanged(picker: UIDatePicker){
        dateRefresh()
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        return formatter
    }()
    
    let setTimeLabel: UILabel = {
        let setLabel = UILabel()
        setLabel.translatesAutoresizingMaskIntoConstraints = false
        setLabel.font = .systemFont(ofSize: 13, weight: .regular)
        return setLabel
    }()
    
    func dateRefresh(){
        pickedDate = timePicker.date
        let fullString = "Каждый день в " + dateFormatter.string(from: pickedDate)
        let attSetTime = NSMutableAttributedString(string: fullString)
        let range: NSRange = attSetTime.mutableString.range(of: dateFormatter.string(from: pickedDate), options: .caseInsensitive)
        attSetTime.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: range)
        setTimeLabel.attributedText = attSetTime
    }
    
    private func viewSetup() {
        self.backgroundColor = .systemBackground
        self.addSubview(nameFieldLabel)
        self.addSubview(nameField)
        self.addSubview(colorPickerLabel)
        self.addSubview(colorPicker)
        self.addSubview(timePickerLabel)
        self.addSubview(setTimeLabel)
        self.addSubview(timePicker)
        self.addSubview(deleteButton)
        dateRefresh()

        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameFieldLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            nameFieldLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            nameFieldLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            nameField.topAnchor.constraint(equalTo: nameFieldLabel.bottomAnchor, constant: 16),
            nameField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            nameField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            colorPickerLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 32),
            colorPickerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            colorPickerLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            colorPicker.topAnchor.constraint(equalTo: colorPickerLabel.bottomAnchor, constant: 16),
            colorPicker.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            timePickerLabel.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 32),
            timePickerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            timePickerLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            setTimeLabel.topAnchor.constraint(equalTo: timePickerLabel.bottomAnchor, constant: 16),
            setTimeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            setTimeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
            timePicker.topAnchor.constraint(equalTo: setTimeLabel.bottomAnchor, constant: 16),
            timePicker.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            timePicker.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -16),
            
            deleteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            deleteButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            deleteButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
    }
}
