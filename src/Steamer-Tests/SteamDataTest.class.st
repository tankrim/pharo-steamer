"
A SteamJsonTest is a test class for testing the behavior of SteamJson
"
Class {
	#name : #SteamDataTest,
	#superclass : #TestCase,
	#classVars : [
		'good',
		'gratisGood'
	],
	#category : #'Steamer-Tests'
}

{ #category : #running }
SteamDataTest >> setUp [

	super setUp.
	good := SteamData newWithId: '10'.
	gratisGood := SteamData newWithId: '1920'
]

{ #category : #tests }
SteamDataTest >> testCreating [

	self should: [ SteamData newWithId: '01' ] raise: MalformedSteamId.
		self should: [ SteamData newWithId: '1' ] raise: UnrecognizedSteamId .
]

{ #category : #tests }
SteamDataTest >> testData [

	self assert: (good data includesKey: 'name')
]

{ #category : #tests }
SteamDataTest >> testId [

	self assert: good id equals: '10'
]

{ #category : #tests }
SteamDataTest >> testJson [

	self
		assert: (good json copyFrom: 1 to: 15)
		equals: '{"10":{"success'
]

{ #category : #tests }
SteamDataTest >> testPriceData [
	self assert: (good priceData includesKey: 'currency').
	self assert: (gratisGood  priceData includesKey: 'currency')
]
