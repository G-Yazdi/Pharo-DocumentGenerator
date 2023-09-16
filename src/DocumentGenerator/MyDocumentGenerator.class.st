"
Class: MyDocumentGenerator
                                                                                                    
I am a class for generating document file(s). Given a package name or a class object, I generate document file(s) for each class with the class name in the directory of your created image, which contains the class name, its subclasses, its superclass, its instance variables and its methods.


Public API and Key Messages

•	generateDocumentForClass: aClass
•	generateDocumentForPackage: aPackageName


I have used reflection provided by Pharo.
"
Class {
	#name : #MyDocumentGenerator,
	#superclass : #Object,
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
	aStream nextPutAll: 'methods: '; cr.
	aStream nextPutAll: (self methods: aClass).

	fileName  asFileReference ensureDelete; 
    	writeStreamDo: [ :stream | stream nextPutAll: aStream contents ].
]

{ #category : #generating }
MyDocumentGenerator >> generateDocumentsForPackage: aPackageName [

	|classes|
	classes := (RPackageOrganizer default packageNamed: aPackageName  ) classes.
	classes do: [ :class | self generateDocumentForClass: class ].
]

{ #category : #'private - utility' }
MyDocumentGenerator >> methods: aClass [
	|methods selectors|
	
	selectors := aClass selectors.
	methods := String new writeStream.

	selectors do: [:selector |
		methods nextPutAll: '- '. 
		methods nextPutAll: selector; cr.
	].
	^ methods contents.
	

]
