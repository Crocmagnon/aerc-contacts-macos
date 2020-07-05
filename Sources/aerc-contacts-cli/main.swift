import AddressBook

let arguments = CommandLine.arguments.dropFirst()

if arguments.isEmpty {
    fputs("No arguments given\n", stderr)
    exit(EXIT_FAILURE)
}

guard let addressBook = ABAddressBook.shared() else {
    fputs("Failed to create address book (check your Contacts privacy settings)\n", stderr)
    exit(EXIT_FAILURE)
}

private func comparison(forProperty property: String, string: String) -> ABSearchElement {
    let comparison: ABSearchComparison = CFIndex(kABContainsSubStringCaseInsensitive.rawValue)
    return ABPerson.searchElement(forProperty: property, label: nil, key: nil, value: string,
            comparison: comparison)
}

var operands = [ABSearchElement]()
for argument in arguments {
    let firstNameSearch = comparison(forProperty: kABFirstNameProperty, string: argument)
    let lastNameSearch = comparison(forProperty: kABLastNameProperty, string: argument)
    let emailSearch = comparison(forProperty: kABEmailProperty, string: argument)
    let orComparison = ABSearchElement(forConjunction: CFIndex(kABSearchOr.rawValue),
            children: [firstNameSearch, lastNameSearch, emailSearch])
    if orComparison != nil {
        operands.append(orComparison!)
    }
}
let andComparison = ABSearchElement(forConjunction: CFIndex(kABSearchAnd.rawValue), children: operands)


let found = addressBook.records(matching: andComparison) as? [ABRecord] ?? []
if found.count == 0 {
    exit(EXIT_SUCCESS)
}

for person in found {
    let firstName = person.value(forProperty: kABFirstNameProperty) as? String ?? ""
    let lastName = person.value(forProperty: kABLastNameProperty) as? String ?? ""
    let emailsProperty = person.value(forProperty: kABEmailProperty) as? ABMultiValue
    if let emails = emailsProperty {
        for i in 0..<emails.count() {
            let email = emails.value(at: i) as? String ?? ""
            print("\(email)\t\(firstName) \(lastName)")
        }
    }
}
