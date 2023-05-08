//
//  DispatchQueue+DispatchProtocol.swift
//  BAZProject
//
//  Created by gescarcega on 03/05/23.
//

import Foundation


public protocol DispatchProtocol {
    
    func async(executable: @escaping () -> Void)
    
    func asyncAfter(deadline: DispatchTime, executable: @escaping () -> Void)
    
}

extension DispatchQueue: DispatchProtocol {

    public func async(executable: @escaping () -> Void) {
        async(execute: executable)
    }
    
    public func asyncAfter(deadline: DispatchTime, executable: @escaping () -> Void) {
        asyncAfter(deadline: deadline, execute: executable)
    }
    
}
