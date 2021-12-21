Extension { #name : #StringTest }

{ #category : #'*Steamer-Tests' }
StringTest >> testIsRecognizedSteamJson [

	self assert: '{"10":{"success":true,"data"' isRecognizedSteamJson .
	self deny: '{"1":{"success":false}}' isRecognizedSteamJson 
]

{ #category : #'*Steamer-Tests' }
StringTest >> testIsWellFormedSteamId [

self assert: '1' isWellFormedSteamId.
self assert: '10' isWellFormedSteamId .
self assert: '12345678' isWellFormedSteamId .
self deny: '123456789' isWellFormedSteamId .
self deny: '0' isWellFormedSteamId.
self deny: '023' isWellFormedSteamId .
self deny: 'a' isWellFormedSteamId .
self deny: '1a' isWellFormedSteamId .
self deny: '' isWellFormedSteamId 
]

{ #category : #'*Steamer-Tests' }
StringTest >> testIsWellFormedSteamJson [

self assert: '{"1":{"success":false}}' isWellFormedSteamJson.
self assert: '{"10":{"success":true,"data"' isWellFormedSteamJson.
self deny: '{}' isWellFormedSteamJson 
]
