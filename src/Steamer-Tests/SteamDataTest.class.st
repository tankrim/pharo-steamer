"
A SteamJsonTest is a test class for testing the behavior of SteamJson
"
Class {
	#name : #SteamDataTest,
	#superclass : #TestCase,
	#category : #'Steamer-Tests'
}

{ #category : #tests }
SteamDataTest >> testCreating [

	self should: [ SteamData newWithId: '01' ] raise: Error
]

{ #category : #tests }
SteamDataTest >> testData [

	| instance |
	instance := SteamData newWithId: '10'.
	self assert: (instance data includesKey: 'name')
]

{ #category : #tests }
SteamDataTest >> testId [

	| instance |
	instance := SteamData newWithId: '10'.
	self assert: instance id equals: '10'.
]

{ #category : #tests }
SteamDataTest >> testJson [

	| instance |
	instance := (SteamData newWithId: '10').
	self
		assert: (instance json copyFrom: 1 to: 15)
		equals: '{"10":{"success'
]
