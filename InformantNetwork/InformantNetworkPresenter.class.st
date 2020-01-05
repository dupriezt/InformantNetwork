Class {
	#name : #InformantNetworkPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'informationTable',
		'refreshInformationTableButton',
		'listOfFiltersByInformationName'
	],
	#category : #InformantNetwork
}

{ #category : #specs }
InformantNetworkPresenter class >> defaultSpec [

	^ SpBoxLayout newHorizontal "Show collected information"
		add: (SpBoxLayout newVertical
			add: 'Collected Information' withConstraints: [:cstr | cstr height: 20];
			add: #informationTable;
			add: #refreshInformationTableButton  withConstraints: [:cstr | cstr height: 30];
			yourself) withConstraints: [:cstr | cstr width: 500];
		add: (SpBoxLayout newVertical
			add: 'Filters / Sorters' withConstraints: [:cstr | cstr height: 20];
			add: #listOfFiltersByInformationName;
			yourself
		);
		yourself
]

{ #category : #'instance creation' }
InformantNetworkPresenter class >> initialExtent [
	^ 700@300
]

{ #category : #'instance creation' }
InformantNetworkPresenter class >> open [
	<script>
	| a |
	a := self new openWithSpec.
	a window extent: self initialExtent.
	^ a
]

{ #category : #specs }
InformantNetworkPresenter class >> title [
	^ 'Informant Network'
]

{ #category : #initialization }
InformantNetworkPresenter >> initializeWidgets [ 
	informationTable := self newTable
		addColumn: (SpIndexTableColumn new
			title: 'Index';
			evaluated: [:item | item index]);
		addColumn: (SpStringTableColumn new
			title: 'Informant Name';
			evaluated: [:item | item informantName]);
		addColumn: (SpStringTableColumn new
			title: 'Information Name';
			evaluated: [:item | item informationName]);
		addColumn: (SpStringTableColumn new
			title: 'Information';
			evaluated: [:item | item information]);
		addColumn: (SpStringTableColumn new
			title: 'Success';
			evaluated: [:item | item informationCollectedSuccessfully]);
		yourself.
	refreshInformationTableButton := self newButton
		action: [ self refreshInformationTable ];
		label: 'Refresh';
		yourself.
	 listOfFiltersByInformationName := self newTable.
	
	self refreshInformationTable
]

{ #category : #initialization }
InformantNetworkPresenter >> refreshInformationTable [
	informationTable items: InformantNetwork currentNetwork informationCollected.
]
