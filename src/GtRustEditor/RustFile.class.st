Class {
	#name : 'RustFile',
	#superclass : 'Object',
	#instVars : [
		'fileReference',
		'ast'
	],
	#category : 'GtRustEditor',
	#package : 'GtRustEditor'
}

{ #category : 'accessing' }
RustFile >> ast [
	ast ifNil: [
		ast := RustParser parseWithErrors: fileReference contents
	].
	^ ast
]

{ #category : 'accessing' }
RustFile >> fromFileReference: aFileReference [ 
	fileReference := aFileReference
]

{ #category : 'accessing' }
RustFile >> getAllStructs [
	| aRustStructNodeCollection |
	aRustStructNodeCollection := self ast items
			select: [ :node | node isKindOf: RustStructNode ].
	^ aRustStructNodeCollection
			collect: [ :node | RustStruct new fromNode: node ]
]

{ #category : 'as yet unclassified' }
RustFile >> gtStyledCodeFor: aView [
	<gtView>
	^ aView forward
		title: 'Code';
		object: [ fileReference ];
		view: #gtStyledCodeFor:;
		priority: 10
]
