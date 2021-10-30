import UIKit

class HabitDetailsViewController: UIViewController{
    
    private let habit: Habit
    private let index: Int
    
    init(habit: Habit, index: Int){
        self.habit = habit
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    let table = UITableView(frame: .zero, style: .plain)
    
    @objc func editHabit(){
        let controller = UINavigationController(rootViewController: HabitViewController(habitsIndex: index))
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.navigationBar.prefersLargeTitles = false
        controller.navigationBar.backgroundColor = .systemBackground
        self.present(controller, animated: true, completion: nil)
        print("details")
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
        cell.textLabel?.text = df.string(from: habit.trackDates[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return habit.trackDates.count
    }
}
