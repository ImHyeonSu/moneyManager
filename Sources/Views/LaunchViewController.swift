//
//  LaunchViewController.swift
//  moneyManager
//
//  Created by h2yn on 2024/11/30.
//

import UIKit

class LaunchViewController: UIViewController {
    
    // MARK: - UI Components
    private let walletImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wallet.pass.fill")
        imageView.tintColor = .systemGreen // アイコンカラーを緑色にする
        imageView.contentMode = .scaleAspectFit // イメージの割合の維持
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dotStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal // 横方向の整列
        stack.spacing = 8 // ドットの間は8のサイズ
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var dots: [UIView] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDots()
        startDotAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigateToMainScreen()
        }
    }
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        // viewの追加
        view.addSubview(walletImageView)
        view.addSubview(dotStackView)
        // 制約事項設定
        NSLayoutConstraint.activate([
            // walletイメージの設定
            walletImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            walletImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            walletImageView.widthAnchor.constraint(equalToConstant: 100),
            walletImageView.heightAnchor.constraint(equalToConstant: 100),
            // 点のstackView位置設定
            dotStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dotStackView.topAnchor.constraint(equalTo: walletImageView.bottomAnchor, constant: 30)
        ])
    }
    
    private func setupDots() {
        for _ in 0..<3 {
            let dot = UIView()
            dot.backgroundColor = .systemGray
            dot.layer.cornerRadius = 4
            dot.translatesAutoresizingMaskIntoConstraints = false
            
            dotStackView.addArrangedSubview(dot)
            
            NSLayoutConstraint.activate([
                dot.widthAnchor.constraint(equalToConstant: 8),
                dot.heightAnchor.constraint(equalToConstant: 8)
            ])
            
            dots.append(dot)
        }
    }
    
    // MARK: - Animations
    private func startDotAnimation() {
        var delay: TimeInterval = 0
        
        func animateDot(_ dot: UIView) {
            UIView.animate(withDuration: 0.3, delay: delay, options: [.repeat, .autoreverse], animations: {
                dot.transform = CGAffineTransform(translationX: 0, y: -10)
            })
            delay += 0.2
        }
        
        dots.forEach { animateDot($0) }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func navigateToMainScreen() {
        let mainVC = MainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
    }



}
