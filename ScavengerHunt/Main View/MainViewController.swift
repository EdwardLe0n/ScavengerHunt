//
//  MainViewController.swift
//  ScavengerHunt
//
//  Created by Edward Leon on 2/11/25.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    var tasks = [Task]() {
        didSet {
            emptyStateLabel.isHidden = !tasks.isEmpty
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // UI candy: Hide 1st / top cell separator
        tableView.tableHeaderView = UIView()

        // Sets itself as the mid data source
        tableView.dataSource = self

        // Populate mocked data
        // Comment out this line if you want the app to load without any existing tasks.
        tasks = Task.mockedTasks
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // This will reload data in order to reflect any changes made to a task after returning from the detail screen.
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UITableViewDataSource {

    // retuurns the number of tasks
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    // function to set cells up
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // The giuard keyword allows for the protection of some code by stopping it ffrom going forward if there's an error
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else {
            fatalError("Unable to dequeue Task Cell")
        }

        // If the cell is legit, then it'll get configured with any data from the tasks array
        cell.configure(with: tasks[indexPath.row])

        // Once all that is done, the cell is returned
        return cell
    }
}
