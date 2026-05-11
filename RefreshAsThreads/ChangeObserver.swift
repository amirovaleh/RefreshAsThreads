//
//  ChangeObserver.swift
//  RefreshAsThreads
//
//  Created by Valeh Amirov on 11.05.26.
//


import SwiftUI

private struct OnChangeObserver<Value: Equatable>: ViewModifier {
    private let value: Value
    private let action: (Value, Value) -> Void
    
    @State private var oldValue: Value
    
    init(value: Value, action: @escaping (Value, Value) -> Void) {
        self.value = value
        self.action = action
        
        _oldValue = State(initialValue: value)
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: value) { newValue in
                action(oldValue, newValue)
                oldValue = newValue
            }
    }
}

extension View {
    
    func onValueChange<Value: Equatable>(
        of value: Value,
        perform action: @escaping (_ oldValue: Value, _ newValue: Value) -> Void
    ) -> some View {
        if #available(iOS 17.0, *) {
            return self.onChange(of: value) { oldValue, newValue in
                action(oldValue, newValue)
            }
        } else {
            return self.modifier(OnChangeObserver(value: value, action: action))
        }
    }
}
