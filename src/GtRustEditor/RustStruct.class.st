Class {
	#name : 'RustStruct',
	#superclass : 'Object',
	#instVars : [
		'node'
	],
	#category : 'GtRustEditor',
	#package : 'GtRustEditor'
}

{ #category : 'accessing' }
RustStruct >> fromNode: aRustStructNode [ 
	node := aRustStructNode
]

{ #category : 'as yet unclassified' }
RustStruct >> gtDisplayText [
	^ 'struct ', node name value asString
]

{ #category : 'as yet unclassified' }
RustStruct >> gtNameFor: aView [
	<gtView>
	^ aView text
		title: 'Name';
		text: node name value
]
