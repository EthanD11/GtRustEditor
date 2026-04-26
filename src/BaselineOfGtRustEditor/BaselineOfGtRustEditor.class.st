Class {
	#name : 'BaselineOfGtRustEditor',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGtRustEditor',
	#package : 'BaselineOfGtRustEditor'
}

{ #category : 'loading' }
BaselineOfGtRustEditor class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'GtRustEditor' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : 'baseline' }
BaselineOfGtRustEditor >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'GtRustEditor'
		]
]
