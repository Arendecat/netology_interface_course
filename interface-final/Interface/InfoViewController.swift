import UIKit

class InfoViewController: UIViewController{
    let mainView = UIScrollView()
    let supView = UIView()
    
    let titleView: UILabel = {
        let title = UILabel()
        title.text = "Привычка за 21 день"
        title.font = .boldSystemFont(ofSize: 20)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let textView: UILabel = {
        let text = UILabel()
        text.text = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:\n\n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.\n\n2. Выдержать 2 дня в прежнем состоянии самоконтроля.\n\n3. Отметить в дневнике первую неделю изменений и подвести первые итоги – что оказалось тяжело, что – легче, с чем еще предстоит серьезно бороться.\n\n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.\n\n5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.\n\n6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.\n\nИсточник:  psychbook.ru"
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.title = "Информация"
        view.addSubview(mainView)
        mainView.addSubview(supView)
        supView.addSubview(textView)
        supView.addSubview(titleView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        supView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
            supView.topAnchor.constraint(equalTo: mainView.topAnchor),
            supView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            supView.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            supView.rightAnchor.constraint(equalTo: mainView.rightAnchor),
            supView.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            
            titleView.topAnchor.constraint(equalTo: supView.topAnchor, constant: 16),
            titleView.heightAnchor.constraint(equalToConstant: 32),
            titleView.leftAnchor.constraint(equalTo: supView.leftAnchor, constant: 16),
            titleView.rightAnchor.constraint(equalTo: supView.rightAnchor, constant: -16),
            
            textView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16),
            textView.bottomAnchor.constraint(equalTo: supView.bottomAnchor, constant: -16),
            textView.leftAnchor.constraint(equalTo: supView.leftAnchor, constant: 16),
            textView.rightAnchor.constraint(equalTo: supView.rightAnchor, constant: -16)
        ])
    }
}
