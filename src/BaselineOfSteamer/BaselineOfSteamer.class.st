Class {
	#name : #BaselineOfSteamer,
	#superclass : #BaselineOf,
	#category : #BaselineOfSteamer
}

{ #category : #baselines }
BaselineOfSteamer >> baseline: spec [
    <baseline>
    spec for: #common do: [	
				
        "Packages"
        spec
            package: 'Steamer';
            package: 'Steamer-Tests' with: [ spec requires: #('Steamer') ] ].
]
