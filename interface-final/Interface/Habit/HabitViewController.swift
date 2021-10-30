import UIKit

class HabitViewController: UIViewController, UITextFieldDelegate{
	init(habitsIndex: Int?){
		super.init(nibName: nil, bundle: nil)
		self.habitsIndex = habitsIndex
	}
	required init?(coder: NSCoder){
		fatalError("init(coder:) has not been implemented")
	}
	
	var calledHabit: Habit? = nil
	var habitsIndex: Int?
    let habitView = HabitView()

	override func viewWillLayoutSubviews(){
		super.viewWillLayoutSubviews()
		habitView.frame = view.frame
	}
	
	@objc func exitVC(){
        self.presentingViewController!.dismiss(animated: true, completion: nil)
	}
	
	@objc func editHabit(){
		calledHabit!.name = habitView.nameField.text!
		calledHabit!.color = habitView.colorPicker.backgroundColor!
		calledHabit!.date = habitView.timePicker.date
		exitVC()
	}
	
	@objc func deleteHabit(){
		HabitsStore.shared.habits.remove(at: habitsIndex!)
		exitVC()
//		self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//		self.navigationController!.popToRootViewController(animated: true)            //баг 2
	}
	
	@objc func addHabit(){
		let addedHabit = Habit(
			name: habitView.nameField.text!,
			date: habitView.timePicker.date,
			color: habitView.colorPicker.backgroundColor!
		)
		HabitsStore.shared.habits.append(addedHabit)
        self.presentingViewController!.dismiss(animated: true, completion: nil)
	}
	
	@objc func pickColor(_ sender: Any){
		let picker = UIColorPickerViewController()
		picker.selectedColor = habitView.colorPicker.backgroundColor ?? UIColor.black
		picker.supportsAlpha = false
		picker.delegate = self
		self.present(picker, animated: true, completion: nil)
	}
	
	@objc func deleteConfirm(){
		let message: String = "Вы уверены, что хотите удалить привычку \"" + self.calledHabit!.name + "\"?"
		let alertController = UIAlertController(title: "Удалить привычку", message: message, preferredStyle: .alert)
		let cancelAction = UIAlertAction(title: "Отмена", style: .default)
		let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) {_ in
			HabitsStore.shared.habits.remove(at: self.habitsIndex!)
			self.exitVC()
		}
		alertController.addAction(cancelAction)
		alertController.addAction(deleteAction)
		self.present(alertController, animated: true, completion: nil)
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
		let text = (habitView.nameField.text! as NSString).replacingCharacters(in: range, with: string)
		if !text.isEmpty{
			self.navigationItem.leftBarButtonItem?.isEnabled = true
		} else {
			self.navigationItem.leftBarButtonItem?.isEnabled = false
		}
		return true
	}
	
	override func viewDidLoad(){
		super.viewDidLoad()
		self.title = "Добавить"
		view.backgroundColor = .systemBackground
		view.addSubview(habitView)
		
		NSLayoutConstraint.activate([
			habitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			habitView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			habitView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			habitView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
		
		habitView.nameField.delegate = self
		habitView.colorPicker.addTarget(self, action: #selector(pickColor), for: .touchUpInside)
		habitView.deleteButton.addTarget(self, action: #selector(deleteConfirm), for: .touchUpInside)
		self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(exitVC)), animated: true)
		if (habitView.nameField.text=="") {self.navigationItem.leftBarButtonItem?.isEnabled = false}
		
		if (habitsIndex != nil){
			calledHabit = HabitsStore.shared.habits[habitsIndex!]
			habitView.deleteButton.isHidden = false
			habitView.timePicker.date = calledHabit!.date
			habitView.colorPicker.backgroundColor = calledHabit!.color
			habitView.nameField.text = calledHabit!.name
			habitView.dateRefresh()
			self.title = "Править"
			self.navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(editHabit)), animated: true)
		} else {
			self.navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addHabit)), animated: true)
			self.navigationItem.leftBarButtonItem?.isEnabled = false
		}
	}
}

extension HabitViewController: UIColorPickerViewControllerDelegate{
	func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController){
		habitView.colorPicker.backgroundColor = viewController.selectedColor
	}
	func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController){}
}
