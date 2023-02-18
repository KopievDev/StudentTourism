//
//  String.swift
//  Festa
//
//  Created by Ivan Kopiev on 04.10.2022.
//

import UIKit

typealias IndexBlock = (Int) -> Void
typealias StringBlock = (String) -> Void
typealias ArrayBlock = ([[String:Any?]]) -> Void
typealias CellsBlock = (Cells) -> Void
typealias VoidBlock = () -> Void


extension String {
    static let success = "success";
    static let code = "code"
    static let pin = "pin"
    static let reuseId = "reuseId"
    static let data = "data"
    static let selected = "selected"
    static let image = "image"
    static let stories = "stories"
    static let time = "time"
    static let animated = "animated"
    static let counter = "counter"
    static let isPin = "isPin"
    static let file_name = "file_name"
    static let profile_pic = "profile_pic"
    static let counters = "counters"
    static let isReady = "isReady"
    static let file_size = "file_size"
    static let directChats = "directChats"
    static let groupsChats = "groupsChats"
    static let archiveChats = "archiveChats"
    static let currentDropButton = "currentDropButton"
    static let days = "days"
    static let times = "times"
    static let selectedContacts = "selectedContacts"
    static let isSelected = "isSelected"
    static let contactsFull = "contactsFull"
    static let contactsIsEmpty = "contactsIsEmpty"
    static let oldContacts = "old_contacts"
    static let imgUrl = "imgUrl"
	static let profile_state = "profile_state"
    static let userIds = "userIds"
    static let moderationOpen = "moderationOpen"
    static let device = "device"
	static let isTabBarInitiated = "isTabBarInitiated"
	static let screenType = "screenType"
	static let purchased = "purchased"
	static let subscribes = "subscribes"
	static let paywallMode = "paywallMode"
	static let productTitle = "productTitle"
	static let searchQuery = "searchQuery"
    static let mode = "mode"
    static let isCreator = "isCreator"
    static let moreSettingIsHidden = "moreSettingIsHidden"
    static let row = "row"
    static let isEditing = "isEditing"
    static let mapIsHidden = "mapIsHidden"
	static let eventColours = "eventColours"
	static let colourThemes = "colourThemes"
	static let index = "index"
	static let chosenIndex = "chosenIndex"
	static let isInSendSMSListMode = "isInSendSMSListMode"
	static let acceptOrDenyMode = "acceptOrDenyMode"
	static let isAddingGuestsToGuestList = "isAddingGuestsToGuestList"
	static let isInEdittingMode = "isInEdittingMode"
	static let screenInitiationMode = "screenInitiationMode"
    static let isPopular = "isPopular"
    static let isWriteAnswer = "isWriteAnswer"
    static let maxWidth = "maxWidth"
    static let pollIndex = "pollIndex"
    static let questionIndex = "questionIndex"
    static let answerIndex = "answerIndex"
    static let subquestionIndex = "subquestionIndex"
    static let subanswerIndex = "subanswerIndex"
    static let deadlineMode = "deadlineMode"
	static let eventsIHost = "eventsIHost"
	static let eventsIGuest = "eventsIGuest"
	static let isLocalUpdate = "isLocalUpdate"
	static let isCommonEventsInitiated = "isCommonEventsInitiated"
    static let dateServer = "dateServer"
    static let timeServer = "timeServer"
    static let isOwner = "isOwner"
    static let question = "question"
    static let show = "show"
    static let vote = "vote"
    static let currentAnswers = "currentAnswers"
    static let questionCount = "questionCount"
    static let keyboardHeight = "keyboardHeight"
    static let currentIndex = "currentIndex"
	static let isUpcomingEventGuestList = "isUpcomingEventGuestList"
	static let isSearchInitiated = "isSearchInitiated"
	static let hideAlreadyInvitedGuests = "hideAlreadyInvitedGuests"
	static let shouldDeleteContact = "shouldDeleteContact"
	static let date_starts = "date_starts"
	static let date_starts_server = "date_starts_server"
	static let time_starts = "time_starts"
	static let time_starts_server = "time_starts_server"
	static let date_ends = "date_ends"
	static let date_ends_server = "date_ends_server"
	static let time_ends = "time_ends"
	static let time_ends_server = "time_ends_server"
    static let fonts = "fonts"
    static let isCaptured = "isCaptured"
}

extension String {
    func withAttr(font: UIFont? = UIFont.systemFont(ofSize: 16), color: UIColor = .fDarkGray, withUnderline: Bool = false) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        
            attributedString.append(
                NSMutableAttributedString(string: self,
                                          attributes:
                                            [NSAttributedString.Key.font :font ?? UIFont.systemFont(ofSize: 16),
                                             NSAttributedString.Key.foregroundColor : color]))
        if withUnderline {
            attributedString.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue ], range: NSRange(location: 0, length: attributedString.length))
        }
        return attributedString
    }
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
	
	func getInitialLetters() -> String {
		let names = self.components(separatedBy: " ")
		if names.count > 2 {
			let numberOfNamesToDrop = names.count - 2
			let firstTwo = names.dropLast(numberOfNamesToDrop)
			let initials = firstTwo.map({$0.prefix(1)}).joined()
			return initials
		}
		let initials = names.map({$0.prefix(1)}).joined()
		return initials
	}
    
	func avatar(color: UIColor = .fCloudBlue,
				textColor: UIColor = .fLightPurple,
				font: UIFont = UIFont(name: "SFProDisplay-Heavy", size: 40) ?? .boldSystemFont(ofSize: 40)) -> UIImage {
        let label = UILabel(frame: CGRect(x:0, y:0, width: 100, height: 100))
        label.text = shortName
        label.textAlignment = .center
        label.backgroundColor = color
        label.textColor = textColor
        label.font = font
        label.layer.cornerRadius = 50
        label.clipsToBounds = true
        return label.asImage()
    }
    
    var shortName: String {
        self.split(separator: " ")
        .enumerated()
        .filter { $0.offset <= 1 }
        .map { $0.element.capitalized }
        .compactMap { $0.first }
        .map { String($0) }
        .joined()
    }
	
}

extension NSMutableAttributedString {
    static func + (lhs:NSMutableAttributedString, rhs:NSMutableAttributedString ) -> NSMutableAttributedString {
        lhs.append(rhs)
        return lhs
    }
}

extension Character {
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    var isSingleEmoji: Bool { count == 1 && containsEmoji }

    var containsEmoji: Bool { contains { $0.isEmoji } }

    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }

    var emojiString: String { emojis.map { String($0) }.reduce("", +) }

    var emojis: [Character] { filter { $0.isEmoji } }

    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
    
    var withoutEmoji: String { unicodeScalars.filter { !$0.properties.isEmojiPresentation }.reduce("") { $0 + String($1) } }
    
    var onlyNumbers: String { filter {$0.isNumber } }
    
    func date(formatter: DateFormatter) -> Date? {
		return formatter.date(from: self)
	}
}
