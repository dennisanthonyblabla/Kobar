//
//  CountdownLabelView.swift
//  Macro Challenge Team2
//
//  Created by Mohammad Alfarisi on 10/11/22.
//

import UIKit

final class CountdownLabelView: UILabel {
    var onCountdownFinished: (() -> Void)?
    
    private var endDate: Date?
    
    init(endDate: Date?) {
        super.init(frame: .zero)
        self.endDate = endDate
        
        setupTimer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupTimer() {
        guard let date = endDate else { return }
        
        guard Date.now < date else { return }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self, date] timer in
            if Date.now >= date {
                timer.invalidate()
                self?.onCountdownFinished?()
            }
            
            DispatchQueue.main.async {
                self?.updateCountdown(date: date)
            }
        }
    }
    
    private func updateCountdown(date: Date) {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        
        let string = formatter.string(from: .now, to: date)
        
        text = string
    }
}
