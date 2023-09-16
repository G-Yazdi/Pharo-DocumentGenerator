Class {
	#name : #MyClassDocumentGenerator,
	#superclass : #Object,
	#instVars : [
		'document'
	],
	#category : #DocumentGenerator
}

{ #category : #'private - utility' }
MyClassDocumentGenerator >> methods: aClass [
	|methods selectors|
	
	selectors := aClass selectors.
	methods := WriteStream on: String new.

	selectors do: [:selector |
		methods nextPutAll: '- '. 
		methods nextPutAll: selector; cr.
	].
	^ methods.
	
	
]
