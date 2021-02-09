# aerc-contacts

Search macOS Contacts and output data for aerc email client.

The authoritative source for this repo is at https://git.augendre.info/gaugendre/aerc-contacts-macos

This is a fork of https://github.com/keith/contacts-cli/ which is released under MIT.
This code is also released under the MIT license.

## Installation
```shell script
make install
```

OR

```shell script
brew tap crocmagnon/homebrew-formulae https://git.augendre.info/gaugendre/aerc-contacts-macos.git
brew install aerc-contacts
```

## Usage
```shell script
aerc-contacts John Doe
```

This will output all emails and contact names matching "John" and "Doe"
in either the first name, last name or email fields.

You should use it in your `aerc.conf`:

```
address-book-cmd=aerc-contacts %s
```
