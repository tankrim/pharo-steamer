"
A SteamIdTest is a test class for testing the behavior of SteamId
"
Class {
	#name : #SteamIdTest,
	#superclass : #TestCase,
	#category : #'Steamer-Tests'
}

{ #category : #tests }
SteamIdTest >> testIdentifier [

	| instance |
	instance := SteamId newFromString: '10'.
	self assert: instance identifier equals: '10'
]

{ #category : #tests }
SteamIdTest >> testIsWellFormed [

	| good bad |
	good := SteamId newFromString: '10'.
	self assert: good isWellFormed.

	bad := SteamId newFromString: '01'.
	self deny: bad isWellFormed.
]
