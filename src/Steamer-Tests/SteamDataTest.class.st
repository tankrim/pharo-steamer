"
A SteamJsonTest is a test class for testing the behavior of SteamJson
"
Class {
	#name : #SteamDataTest,
	#superclass : #TestCase,
	#classVars : [
		'ad1920',
		'demo2510',
		'dlc1237830',
		'game24010',
		'mod1230',
		'movie919'
	],
	#category : #'Steamer-Tests'
}

{ #category : #running }
SteamDataTest >> setUp [

	super setUp.
	ad1920 := SteamData newWithId: '1920'.
	demo2510 := SteamData newWithId: '2510'.
	dlc1237830 := SteamData newWithId: '1237830'.
	game24010 := SteamData newWithId: '24010'.
	mod1230 := SteamData newWithId: '1230'.
	movie919 := SteamData newWithId: '919'
]

{ #category : #tests }
SteamDataTest >> testCreating [

	self should: [ SteamData newWithId: '01' ] raise: MalformedSteamId.
		self should: [ SteamData newWithId: '1' ] raise: UnrecognizedSteamId .
]

{ #category : #tests }
SteamDataTest >> testData [

	self assert: (ad1920  data includesKey: 'name')
]

{ #category : #tests }
SteamDataTest >> testId [

	self assert: ad1920 id equals: '1920'
]

{ #category : #tests }
SteamDataTest >> testJson [

	self
		assert: (ad1920 json copyFrom: 1 to: 15)
		equals: '{"1920":{"succe'
]

{ #category : #tests }
SteamDataTest >> testPriceData [

	self assert: (ad1920  priceData includesKey: 'currency').
	self assert: (game24010  priceData includesKey: 'currency')
]
