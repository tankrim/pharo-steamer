"
A SteamIdTest is a test class for testing the behavior of SteamId
"
Class {
	#name : #SteamIdTest,
	#superclass : #TestCase,
	#classVars : [
		'bad',
		'good'
	],
	#category : #'Steamer-Tests'
}

{ #category : #running }
SteamIdTest >> setUp [

	super setUp.
	good := SteamId newFromString: '10'.
	bad := SteamId newFromString: '01'.
]

{ #category : #tests }
SteamIdTest >> testIdentifier [

	self assert: good identifier equals: '10'
]

{ #category : #tests }
SteamIdTest >> testIsWellFormed [

	self assert: good isWellFormed.
	self deny: bad isWellFormed
]
