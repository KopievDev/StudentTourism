//
//  AlefData.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import Foundation

class Dinamic<T> {
    typealias Listner = (T) -> Void
    private var listner: Listner?
    var value: T {didSet {listner?(value)}}
    init(_ value: T) {self.value = value}
    func bind(_ listner: Listner?) {self.listner = listner}
}


class AlefExpression {
    var k: String?
    var v: String?
    var parent: String?
    var multi = false
    
    init(_ str: String) {
        var expr = str.replacingOccurrences(of: "*", with: "")
        
        if expr.contains("(") && expr.starts(with: ">"){
            expr = String(expr.dropFirst(1))
            let parentComponents = expr.components(separatedBy: "(")
            if parentComponents.count != 2 {
                return
            }
            parent = parentComponents[0].trimmingCharacters(in: .whitespaces)
            expr = parentComponents[1].replacingOccurrences(of: ")", with: "")
        }
        
        let parts = expr.components(separatedBy: "=")
        if parts.count != 2  {
            return
        }
        k = parts[0]
        v = parts[1]
        if str.contains("*") {
            multi = true
        }
    }
}

class AlefExpressionOptional {
    var k: String?
    var v: String?
    var multi = false
    var parent: String?
    
    init(_ str: String) {
        var expr = str.replacingOccurrences(of: "*", with: "")
        
        if expr.contains("(") && expr.starts(with: ">"){
            expr = String(expr.dropFirst(1))
            let parentComponents = expr.components(separatedBy: "(")
            if parentComponents.count != 2 {
                return
            }
            parent = parentComponents[0].trimmingCharacters(in: .whitespaces)
            expr = parentComponents[1].replacingOccurrences(of: ")", with: "")
        }
        
        let parts = expr.components(separatedBy: "=")
        if parts.count != 2  {
            return
        }
        k = parts[0]
        v = parts[1]
        if str.contains("*") {
            multi = true
        }
    }
}

prefix operator ^
prefix func ^ (str: String) -> AlefExpression {
    return AlefExpression(str)
}

prefix operator ^?
prefix func ^? (str: String) -> AlefExpressionOptional {
    return AlefExpressionOptional(str)
}

extension Dictionary {
    
    var json: String {
        if JSONSerialization.isValidJSONObject(self) {
            if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: []) {
                return String(data: theJSONData, encoding: .utf8) ?? "failed to get json"
            } else {
                return "failed to get json"
            }
        } else {
            return "{bad json with image}"
        }
    }
    
    subscript(a idx: Key) -> [Any?] {
        get {
            return self[idx] as? [Any?] ?? []
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(a0 idx: Key) -> [Any?]? {
        get {
            return self[idx] as? [Any?]
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(ad idx: Key) -> [[String: Any?]] {
        get {
            return self[idx] as? [[String: Any?]] ?? []
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(ad0 idx: Key) -> [[String: Any?]]? {
        get {
            return self[idx] as? [[String: Any?]]
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(i idx: Key) -> Int {
        get {
            return self[idx] as? Int ?? 0
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(i0 idx: Key) -> Int? {
        get {
            return self[idx] as? Int
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    /// force int
    subscript(fi idx: Key) -> Int {
        get {
            if let id = self[idx] as? Int {
                return id
            } else if let float = self[idx] as? Double {
                return Int(float)
            } else if let str = self[idx] as? String, let id = Int(str) {
                return id
            } else {
                return 0
            }
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    
    subscript(b idx: Key) -> Bool {
        get {
            return self[idx] as? Bool ?? false
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(b0 idx: Key) -> Bool? {
        get {
            return self[idx] as? Bool
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(f idx: Key) -> Float {
        get {
            return self[idx] as? Float ?? Float(self[idx] as? Double ?? 0.0)
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(f0 idx: Key) -> Float? {
        get {
            if let res = self[idx] as? Float {
                return res
            }
            
            if let res = self[idx] as? Double {
                return Float(res)
            }
            return nil
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(s idx: Key) -> String {
        get {
            return self[idx] as? String ?? ""
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(s0 idx: Key) -> String? {
        get {
            return self[idx] as? String
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    /// force string
    subscript(fs idx: Key) -> String {
        get {
             if let str = self[idx] as? String {
                return str
            } else if let id = self[idx] as? Int {
                return "\(id)"
            } else if let float = self[idx] as? Double {
                return "\(float)"
            }  else {
                return ""
            }
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(gf idx: Key) -> CGFloat {
        get {
            if let value = self[idx] as? CGFloat { return value }
            if let value = self[idx] as? Double { return  CGFloat(value) }
            if let value = self[idx] as? Int { return  CGFloat(value) }
            if let value = (self[idx] as? NSString)?.floatValue { return CGFloat(value) }
            return 0
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(gf0 idx: Key) -> CGFloat? {
        get {
            if let value = self[idx] as? CGFloat { return value }
            if let value = self[idx] as? Double { return  CGFloat(value) }
            if let value = self[idx] as? Int { return  CGFloat(value) }
            if let value = (self[idx] as? NSString)?.floatValue { return CGFloat(value) }
            return nil
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(d idx: Key) -> [String: Any?] {
        get {
            return self[idx] as? [String: Any?] ?? [:]
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(d0 idx: Key) -> [String: Any?]? {
        get {
            return self[idx] as? [String: Any?]
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(as idx: Key) -> [String] {
        get {
            return self[idx] as? [String] ?? []
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
    
    subscript(as0 idx: Key) -> [String]? {
        get {
            return self[idx] as? [String] 
        }
        set {
            if let v = newValue as? Value {
                self[idx] = v
            }
        }
    }
}

extension Array {
    func all(where predicate: (Element) -> Bool) -> [Element]  {
        return self.compactMap { predicate($0) ? $0 : nil }
    }
    
    subscript(a idx: Int) -> [Any?] {
        get {
            if idx >= count {
                return []
            }
            return self[idx] as? [Any?] ?? []
        }
        set {
            if idx >= count {
                return
            }
            
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    subscript(a0 idx: Int) -> [Any?]? {
        get {
            if idx >= count {
                return nil
            }
            
            return self[idx] as? [Any?]
        }
        set {
            if idx >= count {
                return
            }
            
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    subscript(ad idx: Int) -> [[String: Any?]] {
        get {
            if idx >= count {
                return []
            }
            return self[idx] as? [[String: Any?]] ?? []
        }
        set {
            if idx >= count {
                return
            }
            
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    subscript(ad0 idx: Int) -> [[String: Any?]]? {
        get {
            if idx >= count {
                return nil
            }
            
            return self[idx] as? [[String: Any?]]
        }
        set {
            if idx >= count {
                return
            }
            
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    subscript(i idx: Int) -> Int {
        get {
            if idx >= count {
                return 0
            }
            
            return self[idx] as? Int ?? 0
        }
        set {
            if idx >= count {
                return
            }
            
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    subscript(i0 idx: Int) -> Int? {
        get {
            if idx >= count {
                return nil
            }
            return self[idx] as? Int
        }
        set {
            if idx >= count {
                return
            }
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    subscript(b idx: Int) -> Bool {
        get {
            if idx >= count {
                return false
            }
            
            return self[idx] as? Bool ?? false
        }
        set {
            if idx >= count {
                return
            }
            
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    subscript(b0 idx: Int) -> Bool? {
        get {
            if idx >= count {
                return nil
            }
            return self[idx] as? Bool
        }
        set {
            if idx >= count {
                return
            }
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    
    subscript(f idx: Int) -> Float {
        get {
            if idx >= count {
                return 0.0
            }
            return self[idx] as? Float ?? Float(self[idx] as? Double ?? 0.0)
        }
        set {
            if idx >= count {
                return
            }
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    subscript(f0 idx: Int) -> Float? {
        get {
            if idx >= count {
                return nil
            }
            if let res = self[idx] as? Float {
                return res
            }
            
            if let res = self[idx] as? Double {
                return Float(res)
            }
            
            return nil
        }
        set {
            if idx >= count {
                return
            }
            
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    subscript(s idx: Int) -> String {
        get {
            if idx >= count {
                return ""
            }
            
            return self[idx] as? String ?? ""
        }
        set {
            if idx >= count {
                return
            }
            
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    subscript(s0 idx: Int) -> String? {
        get {
            if idx >= count {
                return nil
            }
            
            return self[idx] as? String
        }
        set {
            if idx >= count {
                return
            }
            
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    subscript(d idx: Int) -> [String: Any?] {
        get {
            if idx >= count {
                return [:]
            }
            return self[idx] as? [String: Any?] ?? [:]
        }
        set {
            if idx >= count {
                return
            }
            
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    subscript(d0 idx: Int) -> [String: Any?]? {
        get {
            if idx >= count {
                return [:]
            }
            return self[idx] as? [String: Any?]
        }
        set {
            if idx >= count {
                return
            }
            if let n = newValue as? Element {
                self[idx] = n
            }
        }
    }
    
    
    func lastStringIn(stack: [Any], equalsTo key: String) -> Bool {
        if key == "" {
            return true
        }
        
        let stringStack = stack.filter { $0 is String }
        
        return (stringStack.last as? String ?? "") == key
    }
    
    func recursivelyContains(expr: AlefExpressionOptional, inObject obj: Any? = nil, indexStack:[Any] = []) -> Bool {
        
        let o = obj ?? self
        
        if let o = o as? [String: Any?] {
            var contains = false
            for k in o.keys {
                var newStack = indexStack
                newStack.append(k)
                
                if let v = o[k] as? String {
                    if k == expr.k && v == expr.v {
                        if lastStringIn(stack: indexStack, equalsTo: expr.parent ?? "") {
                            contains = true
                        }
                    }
                }
                
                if let v = o[k] as? Int {
                    if k == expr.k && String(v) == expr.v {
                        if lastStringIn(stack: indexStack, equalsTo: expr.parent ?? "") {
                            contains = true
                        }
                    }
                }
                
                if let v = o[k] as? Float {
                    if k == expr.k && String(v) == expr.v {
                        if lastStringIn(stack: indexStack, equalsTo: expr.parent ?? "")  {
                            contains = true
                        }
                    }
                }
                
                if let v = o[k] as? [Any?] {
                    if recursivelyContains(expr: expr, inObject: v, indexStack: newStack) {
                        contains = true
                    }
                }
                
                if let v = o[k] as? [String: Any?] {
                    if recursivelyContains(expr: expr, inObject: v, indexStack: newStack) {
                        contains = true
                    }
                }
            }
            return contains
        }
        
        if let o = o as? [Any?] {
            var contains = false
            for i in 0..<o.count {
                let k = String(i)
                var newStack = indexStack
                newStack.append(i)
                
                if let v = o[i] as? String {
                    if k == expr.k && v == expr.v {
                        if lastStringIn(stack: indexStack, equalsTo: expr.parent ?? "")  {
                            contains = true
                        }
                    }
                }
                
                if let v = o[i] as? Int {
                    if k == expr.k && String(v) == expr.v {
                        if lastStringIn(stack: indexStack, equalsTo: expr.parent ?? "") {
                            contains = true
                        }
                    }
                }
                
                if let v = o[i] as? Float {
                    if k == expr.k && String(v) == expr.v {
                        if lastStringIn(stack: indexStack, equalsTo: expr.parent ?? "") {
                            contains = true
                        }
                    }
                }
                
                if let v = o[i] as? [Any?] {
                    if recursivelyContains(expr: expr, inObject: v, indexStack: newStack) {
                        contains = true
                    }
                }
                
                if let v = o[i] as? [String: Any?] {
                    if recursivelyContains(expr: expr, inObject: v, indexStack: newStack) {
                        contains = true
                    }
                }
            }
            
            return contains
        }
        
        return false
    }
    
    subscript(_ expr: AlefExpressionOptional) -> [String: Any?]? {
        get {
            guard let k = expr.k, let v = expr.v else {
                return nil
            }
            if expr.parent == nil {
                return self.first { (e) -> Bool in
                    (e as? [String: Any?] ?? [:])[s: k] == v ||
                        (e as? [String: Any?] ?? [:])[f: k].description == v ||
                        (e as? [String: Any?] ?? [:])[i: k].description == v
                } as? [String : Any?]
            } else {
                return self.first { (e) -> Bool in
                    return self.recursivelyContains(expr: expr, inObject: e)
                } as? [String : Any?]
            }
        }
        
        set {
            guard let k = expr.k, let v = expr.v else {
                return
            }
            
            if expr.parent != nil {
                let targetIndex = self.firstIndex { (e) -> Bool in
                    return self.recursivelyContains(expr: expr, inObject: e)
                }
                if let targetIndex = targetIndex {
                    if let n = newValue as? Element {
                        self[targetIndex] = n
                    }
                }
            } else {
                if !expr.multi {
                    let targetIndex = self.firstIndex { (e) -> Bool in
                        (e as? [String: Any?] ?? [:])[s: k] == v ||
                            (e as? [String: Any?] ?? [:])[f: k].description == v ||
                            (e as? [String: Any?] ?? [:])[i: k].description == v
                    }
                    
                    if let targetIndex = targetIndex {
                        if let n = newValue as? Element {
                            self[targetIndex] = n
                        }
                    }
                } else {
                    self = self.map({
                        var res = $0
                        if ($0 as? [String: Any?] ?? [:])[s: k] == v ||
                            ($0 as? [String: Any?] ?? [:])[f: k].description == v ||
                            ($0 as? [String: Any?] ?? [:])[i: k].description == v {
                            if let n = newValue as? Element {
                                res = n
                            }
                        }
                        
                        return res
                    })
                }
            }
        }
    }
    
    subscript(_ expr: AlefExpression) -> [String: Any?] {
        get {
            let o = AlefExpressionOptional("")
            o.k = expr.k
            o.v = expr.v
            o.parent = expr.parent
            o.multi = expr.multi
            return self[o] ?? [:]
        }
        
        set {
            guard let k = expr.k, let v = expr.v else {
                return
            }
            
            if expr.parent != nil {
                let targetIndex = self.firstIndex { (e) -> Bool in
                    let o = AlefExpressionOptional("")
                    o.k = expr.k
                    o.v = expr.v
                    o.parent = expr.parent
                    o.multi = expr.multi
                    return self.recursivelyContains(expr: o, inObject: e)
                }
                if let targetIndex = targetIndex {
                    if let n = newValue as? Element {
                        self[targetIndex] = n
                    }
                }
            } else {
                if !expr.multi {
                    let targetIndex = self.firstIndex { (e) -> Bool in
                        (e as? [String: Any?] ?? [:])[s: k] == v ||
                            (e as? [String: Any?] ?? [:])[f: k].description == v ||
                            (e as? [String: Any?] ?? [:])[i: k].description == v
                    }
                    
                    if let targetIndex = targetIndex {
                        if let n = newValue as? Element {
                            self[targetIndex] = n
                        }
                    }
                } else {
                    self = self.map({
                        var res = $0
                        if ($0 as? [String: Any?] ?? [:])[s: k] == v ||
                            ($0 as? [String: Any?] ?? [:])[f: k].description == v ||
                            ($0 as? [String: Any?] ?? [:])[i: k].description == v {
                            if let n = newValue as? Element {
                                res = n
                            }
                        }
                        
                        return res
                    })
                }
            }
        }
    }
}
