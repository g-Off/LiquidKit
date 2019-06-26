//
//  STRFTimeFormatter.swift
//  Liquid
//
//  Created by Geoffrey Foster on 2019-06-24.
//

import Foundation

public final class STRFTimeFormatter {
	public var format: String = "%Y-%m-%dT%H:%M:%S%z"
	public var useUniversalTimeLocale: Bool = false
	
	public init() {
		
	}

	public func string(from date: Date) -> String {
		var timeInterval = time_t(date.timeIntervalSince1970)
		let time = useUniversalTimeLocale ? gmtime(&timeInterval) : localtime(&timeInterval)
		var buffer = Array<Int8>(repeating: 0, count: 80)

		return format.withCString { (formatCString) -> String in
			strftime_l(&buffer, buffer.count, formatCString, time, nil)
			return String(cString: buffer, encoding: .ascii)!
		}
	}

	public func date(from string: String) -> Date? {
		let timeInterval = string.withCString { (dateCString) -> TimeInterval in
			return format.withCString { (formatCString) -> TimeInterval in
				var time = tm()
				strptime_l(dateCString, formatCString, &time, nil)
				return TimeInterval(useUniversalTimeLocale ? timegm(&time) : mktime(&time))
			}
		}
		return Date(timeIntervalSince1970: timeInterval)
	}
}
