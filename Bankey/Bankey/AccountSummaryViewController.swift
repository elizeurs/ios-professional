//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Elizeu RS on 30/04/22.
//

import UIKit

class AccountSummaryViewController: UIViewController {
  
//  let games = [
//    "Pacman",
//    "Space Invaders",
//    "Space Patrol",
//  ]
  
  // Request Models
  var profile: Profile?
  var accounts: [Account] = []
  
  // View Models
  var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "welcome", name: "", date: Date())
  var accountCellViewModels: [AccountSummaryCell.ViewModel] = []
  
  var tableView = UITableView()
  var headerView = AccountSummaryHeaderView(frame: .zero)
  
  lazy var logoutBarButtonItem: UIBarButtonItem =  {
    let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
    barButtonItem.tintColor = .label
    return barButtonItem
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupNavigationBar()
  }
  
  func setupNavigationBar() {
    navigationItem.rightBarButtonItem = logoutBarButtonItem
  }
}

extension AccountSummaryViewController {
  private func setup() {
    setupTableView()
    setupTableHeaderView()
//    fetchAccounts()
    fetchDataAndLoadViews()
  }
  
  private func setupTableView() {
    tableView.backgroundColor = appColor
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
    tableView.rowHeight = AccountSummaryCell.rowHeight
    tableView.tableFooterView = UIView()
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  private func setupTableHeaderView() {
    
    var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    size.width  = UIScreen.main.bounds.width
    headerView.frame.size = size
    
    tableView.tableHeaderView = headerView
  }
}

extension AccountSummaryViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
    let account = accountCellViewModels[indexPath.row]
    cell.configure(with: account)
    
//    let cell = UITableViewCell()
//    cell.textLabel?.text = games[indexPath.row]
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return games.count
    return accountCellViewModels.count
  }
}

extension AccountSummaryViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}

//extension AccountSummaryViewController {
//  private func fetchAccounts() {
//    let savings = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "Basic Savings", balance: 929466.23)
//    let chequing = AccountSummaryCell.ViewModel(accountType: .Banking, accountName: "No-Fee All-In Chequing", balance: 17562.44)
//    let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Visa Avion Card", balance: 412.83)
//    let masterCard = AccountSummaryCell.ViewModel(accountType: .CreditCard, accountName: "Student Mastercard", balance: 50.83)
//    let investment = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: "Tax-Free Saver", balance: 2000.00)
//    let investiment2 = AccountSummaryCell.ViewModel(accountType: .Investment, accountName: " Growth Fund", balance: 15000.00)
//
//    accounts.append(savings)
//    accounts.append(chequing)
//    accounts.append(visa)
//    accounts.append(masterCard)
//    accounts.append(investment)
//    accounts.append(investiment2)
//  }
//}

//  MARK: Actions
extension AccountSummaryViewController {
  @objc func logoutTapped(sender: UIButton) {
    NotificationCenter.default.post(name: .logout, object: nil)
  }
}

// MARK: - Networking
extension AccountSummaryViewController {
  private func fetchDataAndLoadViews() {
    
    fetchProfile(forUserId: "1") { result in
      switch result {
      case .success(let profile):
        self.profile = profile
        self.configureTableHeaderView(with: profile)
        self.tableView.reloadData()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
    
    fetchAccounts(forUserId: "1") { result in
      switch result {
      case .success(let accounts):
        self.accounts = accounts
        self.configureTableCells(with: accounts)
        self.tableView.reloadData()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  private func configureTableHeaderView(with profile: Profile) {
    let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                name: profile.firstName,
                                                date: Date())
    headerView.configure(viewModel: vm)
  }
  
  private func  configureTableCells(with accounts: [Account]) {
    accountCellViewModels = accounts.map {
      AccountSummaryCell.ViewModel(accountType: $0.type,
                                   accountName: $0.name,
                                   balance: $0.amount)
    }
  }
}
