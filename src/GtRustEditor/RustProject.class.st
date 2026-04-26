Class {
	#name : 'RustProject',
	#superclass : 'Object',
	#instVars : [
		'folder'
	],
	#category : 'GtRustEditor',
	#package : 'GtRustEditor'
}

{ #category : 'accessing' }
RustProject class >> fromPath [
]

{ #category : 'accessing' }
RustProject >> folder [
	^ folder
]

{ #category : 'accessing' }
RustProject >> fromPath: aPathLikeObject [
	folder := aPathLikeObject asFileReference
]

{ #category : 'as yet unclassified' }
RustProject >> gtASTTreeFor: aView [
	<gtView>
	(self sourceFolder isDirectory)
		ifFalse: [ ^ aView empty ].
		^ aView columnedTree
			title: 'AST Tree';
			priority: 20;
			items: [ 
				self sourceFolder children collect: [:each | 
					each isFile 
						ifTrue: [RustParser parseWithErrors: each contents] 
						ifFalse: [each] 
				] 
			];
			children: #children
		
]

{ #category : 'as yet unclassified' }
RustProject >> gtFileStructureFor: aView [
    <gtView>
    | src |
    src := folder / 'src'.
    src isDirectory ifFalse: [ ^ aView empty ].
    ^ aView mondrian
        title: 'File Structure';
        painting: [ :aMondrian |	
            aMondrian nodes
                stencil: [ :each |
												    | label box |
												    label := BlTextElement new
												        text: each basename asRopedText;
												        padding: (BlInsets all: 5).
													    box := BlElement new
													        layout: BlLinearLayout horizontal;
													        border: (each isDirectory 
													        	ifTrue: [ BlBorder paint: Color red width: 1 ]
													        	ifFalse: [ BlBorder paint: Color gray width: 1 ]
												        	);		
													        constraintsDo: [ :c | c horizontal fitContent. c vertical fitContent ];
													        addChild: label;
													        yourself.
												    box ];
                with: (src allChildren).
            aMondrian edges
                fromRightCenter;
                toLeftCenter;
                connectToAll: [ :each | 
                    each isDirectory 
                        ifTrue: [ each children ]
                        ifFalse: [ #() ] ].
            aMondrian layout horizontalTree];	
        yourself
]

{ #category : 'as yet unclassified' }
RustProject >> gtSrcTreeFor: aView [
	<gtView>
	^ aView forward
			title: 'Source Folder';
			object: folder / 'src';
			view: #gtTreeFor:;
			priority: 20;
			yourself
]

{ #category : 'as yet unclassified' }
RustProject >> gtTreeFor: aView [
	<gtView>
	^ aView forward
			title: 'Folder';
			object: folder;
			view: #gtTreeFor:;
			yourself
]

{ #category : 'accessing' }
RustProject >> sourceFolder [
	^ folder / 'src'
]
