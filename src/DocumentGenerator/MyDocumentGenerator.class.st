Class {
	#name : #MyDocumentGenerator,
	#superclass : #Object,
	#instVars : [
		'document'
	],
	#category : #DocumentGenerator
}

{ #category : #generating }
MyDocumentGenerator >> generateDocumentForClass: aClass [
	"comment stating purpose of instance-side method"
	"scope: class-variables  &  instance-variables"

	|aStream fileName|

	fileName := aClass name , '.txt'.
	aStream := WriteStream on: String new.

	aStream nextPutAll: aClass name; cr; cr.
	aStream nextPutAll: 'subclasses: '.
	aStream nextPutAll: aClass subclasses asString; cr; cr.
	aStream nextPutAll: 'superclass: '.
	aStream nextPutAll: aClass superclass name; cr; cr.
	aStream nextPutAll: 'instanceVariables: '.
	aStream nextPutAll: aClass instanceVariables asString; cr; cr.
	aStream nextPutAll: (self methods: aClass).

	fileName  asFileReference ensureDelete; 
    	writeStreamDo: [ :stream | stream nextPutAll: aStream contents ].
]

{ #category : #generating }
MyDocumentGenerator >> generateDocumentsForPackage: aPackage [
	|classes|

	classes := (RPackageOrganizer default packageNamed: aPackage asString  ) classes.
	classes do: [ :class | self generateDocumentForClass: class ].
]

{ #category : #'private - utility' }
MyDocumentGenerator >> methods: aClass [
	|methods selectors|
	
	selectors := aClass selectors.
	methods := WriteStream on: String new.

	selectors do: [:selector |
		methods nextPutAll: '- '. 
		methods nextPutAll: selector; cr.
	].
	^ methods.
	
	
]
