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
	ad1920 := SteamArtifact newWithId: '1920'.
	demo2510 := SteamArtifact newWithId: '2510'.
	dlc1237830 := SteamArtifact newWithId: '1237830'.
	game24010 := SteamArtifact newWithId: '24010'.
	mod1230 := SteamArtifact newWithId: '1230'.
	movie919 := SteamArtifact newWithId: '919'
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
