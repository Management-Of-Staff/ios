//
//  UIControl+Extension.swift
//  App
//
//  Created by Taehwan Kim on 2023/04/05.
//  Copyright © 2023 Ozik. All rights reserved.
//

import UIKit
import Combine

extension UIControl {
    
    func controlPublisher(for event: UIControl.Event) -> UIControl.EventPublisher {
        return UIControl.EventPublisher(control: self, event: event)
      }
    
    // Publisher
    struct EventPublisher: Publisher {
        typealias Output = UIControl
        typealias Failure = Never
        
        let control: UIControl
        let event: UIControl.Event
        
        func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = EventSubscription(control: control, subscrier: subscriber, event: event)
            subscriber.receive(subscription: subscription)
        }
    }
    
    // Subscription
    fileprivate class EventSubscription<EventSubscriber: Subscriber>: Subscription where EventSubscriber.Input == UIControl, EventSubscriber.Failure == Never {

        let control: UIControl
        let event: UIControl.Event
        var subscriber: EventSubscriber?
        
        init(control: UIControl, subscrier: EventSubscriber, event: UIControl.Event) {
            self.control = control
            self.subscriber = subscrier
            self.event = event
            
            control.addTarget(self, action: #selector(eventDidOccur), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
            control.removeTarget(self, action: #selector(eventDidOccur), for: event)
        }
        
        @objc func eventDidOccur() {
            _ = subscriber?.receive(control)
        }
    }
}

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        controlPublisher(for: .editingChanged)
            .map { $0 as! UITextField }
            .map { $0.text! }
            .eraseToAnyPublisher()
    }
}

extension UIButton {
    var tapPublisher: AnyPublisher<Void, Never> {
        controlPublisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}

extension UISwitch {
    var statePublisher: AnyPublisher<Bool, Never> {
        controlPublisher(for: .valueChanged)
            .map { $0 as! UISwitch }
            .map { $0.isOn }
            .eraseToAnyPublisher()
    }
}

extension UIStepper {
    var valuePublisher: AnyPublisher<Double, Never> {
        controlPublisher(for: .valueChanged)
            .map { $0 as! UIStepper }
            .map { $0.value }
            .eraseToAnyPublisher()
    }
}

extension UISegmentedControl {
    var selectionPublisher: AnyPublisher<Int, Never> {
        controlPublisher(for: .valueChanged)
            .map { $0 as! UISegmentedControl }
            .map { $0.selectedSegmentIndex }
            .eraseToAnyPublisher()
    }
}

extension UISlider {
    var valuePublisher: AnyPublisher<Float, Never> {
        controlPublisher(for: .valueChanged)
            .map { $0 as! UISlider }
            .map { $0.value }
            .eraseToAnyPublisher()
    }
}
