Extension { #name : #StringTest }

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
