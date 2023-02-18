//
//  Date.swift
//  Festa
//
//  Created by Ivan Kopiev on 18.10.2022.
//

import Foundation

extension Date {
    var timeHasPassed: String { String(format: "[%.3f]", Date().timeIntervalSince(self)) }
    var hours: Int { Calendar.current.component(.hour, from: self) }
    var minuts: Int { Calendar.current.component(.minute, from: self) }
    func formatToString(using formatter: DateFormatter) -> String { formatter.string(from: self) }
    static func date(string: String, formatter: DateFormatter) -> Date? { formatter.date(from: string) }
    
    func hours(passsed date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: self, to: date)
        return components.hour ?? 0
    }
    
    func days(passsed date: Date) -> Int {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day ?? 0
    }
    
    func leftDaysAndHours() -> String {
        guard self > Date() else  { return "" }
        let date = Date()
        let days = abs(date.days(passsed: self))
        let hours = abs(date.hours(passsed: self) % 24)
        guard days != 0 else { return "\(hours) \(hours == 1 ? "hour":"hours")" }
        return "\(days) \(days == 1 ? "day":"days") \(hours) \(hours == 1 ? "hour":"hours left")"
    }
    
    func check(startString: String, endString: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startTime = formatter.date(from: startString)
        let endTime = formatter.date(from: endString)
        let calendar = Calendar.current

        var startComponents = calendar.dateComponents([.hour, .minute], from: startTime!)
        var endComponents = calendar.dateComponents([.hour, .minute], from: endTime!)
        let nowComponents = calendar.dateComponents([.month, .day, .year], from: self)
        startComponents.year  = nowComponents.year
        startComponents.month = nowComponents.month
        startComponents.day   = nowComponents.day

        endComponents.year  = nowComponents.year
        endComponents.month = nowComponents.month
        endComponents.day   = nowComponents.day
        guard
            let startDate = calendar.date(from: startComponents),
            let endDate = calendar.date(from: endComponents)
        else {
            print("unable to create dates")
            return false
        }

        return startDate < self && self < endDate
    }
    
    func getIntervals() -> [String] {
        var intersvals = ["Morning", "Afternoon", "Evening", "Night"]
        if !check(startString: "05:00", endString: "12:00") { intersvals.removeFirst() } else { return intersvals }
        if !check(startString: "12:00", endString: "17:00") { intersvals.removeFirst() } else { return intersvals }
        if !check(startString: "17:00", endString: "21:00") { intersvals.removeFirst() } else { return intersvals }
        return intersvals
    }
    
    var dayString: String {
        switch true {
        case Calendar.current.isDateInToday(self): return "today"
        case Calendar.current.isDateInTomorrow(self): return "tomorrow"
        default: return formatToString(using: .yyyyMMdd)
        }
    }
    
    func moveOf(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
    
    func moveOf(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func moveOf(minuts: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minuts, to: self)!
    }
    
    func moveOf(months: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: months, to: self)!
    }
    
    func moveOf(years: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: years, to: self)!
    }
    
    func getDates(from endDate: Date) -> [Date] {
        guard let days = Calendar.current.dateComponents([.day], from: self, to: endDate).day, days > 0 else { return [self] }
        return (0...days).map { moveOf(days: $0) }
    }

}

extension DateFormatter {
	static let yyyyMMddHHmmss: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd HH:mm:ss" //2022-12-16 20:00:00
		return df
	}()
	
	static let yyyyMMdd: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd" //2022-12-16 20:00:00
		return df
	}()
	
	static let ddMMyyyy: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "dd.MM.yyyy" //2022-12-16 20:00:00
		return df
	}()
	
	static let HHmmss: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "HH:mm:ss" //2022-12-16 20:00:00
		return df
	}()
	
	static let HHmm: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "HH:mm" //2022-12-16 20:00:00
		return df
	}()
	
	static let ddMMyyyyHHmmDotted: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "dd.MM.yyyy HH:mm" //11.20.2022 20:00
		return df
	}()
	
	static let ddMMMM: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "dd MMMM"
		return df
	}()
	
	static let dMMM: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "d MMM"
		return df
	}()
	
	static let hmma: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "h:mm a"
		return df
	}()
	static let ddMMMMyyyy: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "dd MMMM yyyy"
		return df
	}()
	static let MMMMyyyy: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "MMMM yyyy" // "June 2023"
		return df
	}()
}

extension Calendar {
	private var currentDate: Date { return Date() }
	
	func isDateInCurrentMonth(_ date: Date) -> Bool {
		return isDate(date, equalTo: currentDate, toGranularity: .month)
	}
}
