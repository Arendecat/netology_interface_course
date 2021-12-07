import UIKit

class HabitDetailsViewController: UIViewController, UINavigationControllerDelegate{
    
    private let habit: Habit
    private let index: Int
    
    init(habit: Habit, index: Int){
        self.habit = habit
        self.index = index
        if (!habit.trackDates.isEmpty) {var date = habit.trackDates[0]
            while (date <= Date()) {
                arrayOfDates.append(date)
                date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            }
        } else {arrayOfDates.append(Date())}
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    var arrayOfDates: [Date] = []
    
    let table = UITableView(frame: .zero, style: .plain)
    
    @objc func editHabit(){
        let habitVC = HabitViewController(habitsIndex: index)
        habitVC.delegate = self
        let controller = UINavigationController(rootViewController: habitVC)
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.navigationBar.prefersLargeTitles = false
        controller.navigationBar.backgroundColor = .systemBackground
        self.present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editHabit)), animated: true)
        self.title = habit.name
        view.addSubview(table)
        table.dataSource = self
        
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            table.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HabitDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        let df = DateFormatter()
        df.dateStyle = .long
        df.locale = Locale(identifier: "ru_RU")
        df.doesRelativeDateFormatting = true
        cell.textLabel?.text = df.string(from: arrayOfDates[indexPath.row])
        habit.trackDates.forEach { date in
            if (date.onlyDate == arrayOfDates[indexPath.row].onlyDate) {
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrayOfDates.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
}

protocol HabitDelegate: AnyObject {
    func exitDetails()
}

extension HabitDetailsViewController: HabitDelegate {
    func exitDetails() {
        self.navigationController!.popToRootViewController(animated: true)
    }
}

extension Date {
    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            dateComponents.timeZone = NSTimeZone.system
            return calender.date(from: dateComponents)
        }
    }
}
