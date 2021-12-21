"
A SteamJsonTest is a test class for testing the behavior of SteamJson
"
Class {
	#name : #SteamJsonTest,
	#superclass : #TestCase,
	#category : #'Steamer-Tests'
}

{ #category : #tests }
SteamJsonTest >> testCreating [

	self should: [ SteamJson newWithId: '01' ] raise: Error
]

{ #category : #tests }
SteamJsonTest >> testId [

	| instance |
	instance := SteamJson newWithId: '10'.
	self assert: instance id equals: '10'.
]

{ #category : #tests }
SteamJsonTest >> testJson [

	| instance |
	instance := (SteamJson newWithId: '10') fetchYourself.
	self assert: (instance json copyFrom: 1 to: 15) equals: '{"10":{"success'
]
