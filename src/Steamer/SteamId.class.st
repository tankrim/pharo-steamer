"
I represent a potential id of one piece of software from Steam.

I know whether I am well-formed or not.

I collaborate with `String` in determining my well-formedness.

To create an instance of me, do:

```
SteamId newFromString: '10'.
```

Example:

```
| id |
id := SteamId newFromString: '10'.
id identifier.				=> '10'
id isWellFormed.			=> true
```

Internal Representation and Key Implementation Points.

While identifier can hold any object, a *well-formed* identifier can only be of species String.

    Instance Variables
	identifier:		<Object>
"
Class {
	#name : #SteamId,
	#superclass : #Object,
	#instVars : [
		'identifier'
	],
	#category : #Steamer
}

{ #category : #'instance creation' }
SteamId class >> newFromString: aString [

	^ self basicNew
		  setIdentifier: aString;
		  yourself
]

{ #category : #accessing }
SteamId >> identifier [
	^ identifier
]

{ #category : #testing }
SteamId >> isWellFormed [

	identifier isString ifFalse: [ ^ false ].
	^ identifier isWellFormedSteamId
]

{ #category : #initialization }
SteamId >> setIdentifier: aString [ 
	identifier := aString.
]
