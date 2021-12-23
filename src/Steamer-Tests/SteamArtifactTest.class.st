"
A SteamArtifactTest is a test class for testing the behavior of SteamArtifact
"
Class {
	#name : #SteamArtifactTest,
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
SteamArtifactTest >> setUp [

	super setUp.
	ad1920 := SteamCannedData steamArtifactForAd1920.
	demo2510 := SteamCannedData steamArtifactForDemo2510.
	dlc1237830 := SteamCannedData steamArtifactForDlc1237830.
	game24010 := SteamCannedData steamArtifactForGame24010.
	mod1230 := SteamCannedData steamArtifactForMod1230.
	movie919 := SteamCannedData steamArtifactForMovie919

]

{ #category : #tests }
SteamArtifactTest >> testDiscount [

	self assert: ad1920 discount equals: 0.
	self assert: demo2510 discount equals: 0.
	self assert: dlc1237830 discount equals: 25.
	self assert: game24010 discount equals: 60.
	self assert: mod1230 discount equals: 0.
	self assert: movie919 discount equals: 0
]

{ #category : #tests }
SteamArtifactTest >> testId [

	self assert: ad1920 id equals: '1920'.
	self assert: demo2510 id equals: '2510'.
	self assert: dlc1237830 id equals: '1237830'.
	self assert: game24010 id equals: '24010'.
	self assert: mod1230 id equals: '1230'.
	self assert: movie919 id equals: '919'
]

{ #category : #tests }
SteamArtifactTest >> testPrice [

	self assert: ad1920 price equals: 0.
	self assert: demo2510 price equals: 0.
	self assert: dlc1237830 price equals: 614.
	self assert: game24010 price equals: 1199.
	self assert: mod1230 price equals: 0.
	self assert: movie919 price equals: 0
]

{ #category : #tests }
SteamArtifactTest >> testTitle [

	self assert: ad1920 title equals: 'Two Worlds'.
	self assert: demo2510 title equals: 'Shadowgrounds Demo'.
	self assert: dlc1237830 title equals: 'TWDSS: Tourist Edition Upgrade'.
	self assert: game24010 title equals: 'Train Simulator 2022'.
	self assert: mod1230 title equals: 'Mare Nostrum'.
	self assert: movie919 title equals: 'Dark Messiah: Warrior'
]

{ #category : #tests }
SteamArtifactTest >> testUrl [

	self
		assert: ad1920 url
		equals: 'https://store.steampowered.com/app/1920'.
	self
		assert: demo2510 url
		equals: 'https://store.steampowered.com/app/2510'.
	self
		assert: dlc1237830 url
		equals: 'https://store.steampowered.com/app/1237830'.
	self
		assert: game24010 url
		equals: 'https://store.steampowered.com/app/24010'.
	self
		assert: mod1230 url
		equals: 'https://store.steampowered.com/app/1230'.
	self
		assert: movie919 url
		equals: 'https://store.steampowered.com/app/919'
]
