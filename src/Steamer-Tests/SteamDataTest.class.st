"
A SteamJsonTest is a test class for testing the behavior of SteamJson
"
Class {
	#name : #SteamDataTest,
	#superclass : #TestCase,
	#instVars : [
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
	ad1920 := SteamCannedData steamDataForAd1920.
	demo2510 := SteamCannedData steamDataForDemo2510.
	dlc1237830 := SteamCannedData steamDataForDlc1237830.
	game24010 := SteamCannedData steamDataForGame24010.
	mod1230 := SteamCannedData steamDataForMod1230.
	movie919 := SteamCannedData steamDataForMovie919

]

{ #category : #tests }
SteamDataTest >> testCreating [

	self should: [ SteamData newWithId: '01' ] raise: MalformedSteamId.
		self should: [ SteamData newWithId: '1' ] raise: UnrecognizedSteamId .
]

{ #category : #tests }
SteamDataTest >> testCurrency [

	self assert: ad1920 currency equals: ''.
	self assert: demo2510 currency equals: ''.
	self assert: dlc1237830 currency equals: 'EUR'.
	self assert: game24010 currency equals: 'EUR'.
	self assert: mod1230 currency equals: ''.
	self assert: movie919 currency equals: ''
]

{ #category : #tests }
SteamDataTest >> testData [

	self assert: (ad1920 data includesKey: 'name').
	self assert: (demo2510 data includesKey: 'name').
	self assert: (dlc1237830 data includesKey: 'name').
	self assert: (game24010 data includesKey: 'name').
	self assert: (mod1230 data includesKey: 'name').
	self assert: (movie919 data includesKey: 'name')
]

{ #category : #tests }
SteamDataTest >> testDiscount [

	self assert: ad1920 discount equals: 0.
	self assert: demo2510 discount equals: 0.
	self assert: dlc1237830 discount equals: 25.
	self assert: game24010 discount equals: 60.
	self assert: mod1230 discount equals: 0.
	self assert: movie919 discount equals: 0
]

{ #category : #tests }
SteamDataTest >> testId [

	self assert: ad1920 id equals: '1920'.
	self assert: demo2510 id equals: '2510'.
	self assert: dlc1237830 id equals: '1237830'.
	self assert: game24010 id equals: '24010'.
	self assert: mod1230 id equals: '1230'.
	self assert: movie919 id equals: '919'
]

{ #category : #tests }
SteamDataTest >> testJson [

	self
		assert: (ad1920 json copyFrom: 1 to: 15)
		equals: '{"1920":{"succe'
]

{ #category : #tests }
SteamDataTest >> testPrice [

	self assert: ad1920 price equals: 0.
	self assert: demo2510 price equals: 0.
	self assert: dlc1237830 price equals: 614.
	self assert: game24010 price equals: 1199.
	self assert: mod1230 price equals: 0.
	self assert: movie919 price equals: 0
]

{ #category : #tests }
SteamDataTest >> testPriceData [

	self assert: (ad1920 priceData includesKey: 'currency').
	self assert: (demo2510  priceData includesKey: 'currency').
		self assert: (dlc1237830  priceData includesKey: 'currency').
	self assert: (game24010 priceData includesKey: 'currency').
	self assert: (mod1230  priceData includesKey: 'currency').
		self assert: (movie919  priceData includesKey: 'currency').

]

{ #category : #tests }
SteamDataTest >> testTimestamp [

	self assert: ad1920 timestamp printString equals: '2021-12-25T20:03:27.086436+01:00'.
	self assert: demo2510 timestamp printString equals: '2021-12-25T20:03:27.086436+01:00'.
	self
		assert: dlc1237830 timestamp printString
		equals: '2021-12-25T20:03:27.086436+01:00'.
	self
		assert: game24010 timestamp printString
		equals: '2021-12-25T20:03:27.086436+01:00'.
	self assert: mod1230 timestamp printString equals: '2021-12-25T20:03:27.086436+01:00'.
	self assert: movie919 timestamp printString equals: '2021-12-25T20:03:27.086436+01:00'
]

{ #category : #tests }
SteamDataTest >> testTitle [

	self assert: ad1920 title equals: 'Two Worlds'.
	self assert: demo2510 title equals: 'Shadowgrounds Demo'.
	self assert: dlc1237830 title equals: 'TWDSS: Tourist Edition Upgrade'.
	self assert: game24010 title equals: 'Train Simulator 2022'.
	self assert: mod1230 title equals: 'Mare Nostrum'.
	self assert: movie919 title equals: 'Dark Messiah: Warrior'
]

{ #category : #tests }
SteamDataTest >> testType [

	self assert: ad1920 type equals: #Ad.
	self assert: demo2510 type equals: #Demo.
	self
		assert: dlc1237830 type
		equals: #Dlc.
	self
		assert: game24010 type
		equals: #Game.
	self assert: mod1230 type equals: #Mod.
	self assert: movie919 type equals: #Movie
]
