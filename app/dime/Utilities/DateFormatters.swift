//
//  DateFormatters.swift
//  dime
//
//  DateFormatter is expensive to allocate (~100µs each). These static
//  instances are created once per process lifetime and reused everywhere.
//
//  Modified by Habib Allawati, 2026.
//

import Foundation

extension DateFormatter {
    static let dayMonth: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "d MMM"; return f
    }()

    static let dayMonthYear: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "d MMM yyyy"; return f
    }()

    static let dayMonthYearShort: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "d MMM yy"; return f
    }()

    static let weekdayDayMonth: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "EEE, d MMM"; return f
    }()

    static let weekdayDayMonthYearShort: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "EEE, d MMM yy"; return f
    }()

    static let weekdayDayMonthYear: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "EEE, d MMM yyyy"; return f
    }()

    static let weekdayDayMonthAlt: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "E, d MMM"; return f
    }()

    static let monthYear: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "MMM yyyy"; return f
    }()

    static let monthYearShort: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "MMM yy"; return f
    }()

    static let time12h: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "h:mm a"; return f
    }()

    static let time24h: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "HH:mm"; return f
    }()

    static let weekdayShort: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "EEE"; return f
    }()

    static let year: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "yyyy"; return f
    }()

    static let monthNumber: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "M"; return f
    }()

    static let dayNumber: DateFormatter = {
        let f = DateFormatter(); f.dateFormat = "d"; return f
    }()
}
