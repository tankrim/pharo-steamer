Extension { #name : #String }

{ #category : #'*Steamer' }
String >> isWellFormedSteamId [

	| steamIdMaxSize |
	steamIdMaxSize := 8.
	^ self isNotEmpty and: [ 
		  self size <= steamIdMaxSize and: [ 
			  self isAllDigits and: [ self first ~= $0 ] ] ]
]

{ #category : #'*Steamer' }
String >> isWellFormedSteamJson [

	^ '*:{"success":*' match: self
]
