import UIKit

class HabitViewController: UIViewController {
    
	
    
    let habitView = HabitView()

        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            habitView.frame = view.frame
        }
	
	@objc func exitVC() {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
	}
	
	@objc func habitAdded() {
		let addedHabit = Habit(
			name: habitView.nameField.text!,
			date: habitView.timePicker.date,
			color: habitView.colorPicker.backgroundColor!
		)
		addedHabit.trackDates.append(Date(timeIntervalSinceNow: 0))
		HabitsStore.shared.habits.append(addedHabit)
		HabitsStore.shared.habits.last?.trackDates.append(Date(timeIntervalSinceNow: 0))
        self.presentingViewController!.dismiss(animated: true, completion: nil)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Добавить"
        view.addSubview(habitView)
		
		habitView.colorPicker.addTarget(self, action: #selector(pickColor), for: .touchUpInside)
		
		self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(exitVC)), animated: true)
		self.navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(habitAdded)), animated: true)
		
		
//		if (habitView.nameField.text=="") {self.navigationItem.leftBarButtonItem?.isEnabled = false}  как сделать блокировку кнопки при отсутствии названия привычки?
    }
	
	@objc func pickColor(_ sender: Any) {
		let picker = UIColorPickerViewController()
		picker.selectedColor = habitView.colorPicker.backgroundColor ?? UIColor.black
		picker.supportsAlpha = false
		picker.delegate = self
		self.present(picker, animated: true, completion: nil)
	}
	
	

}

extension HabitViewController: UIColorPickerViewControllerDelegate {
	func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
		habitView.colorPicker.backgroundColor = viewController.selectedColor
	}
	
	
	func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {

	}
}
