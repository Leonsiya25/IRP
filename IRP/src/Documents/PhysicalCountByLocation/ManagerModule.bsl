
Procedure GeneratePhysicalCountByLocation(Parameters, AddInfo = Undefined) Export
	
	BeginTransaction();
	HaveError = False;
	Try
		
		For Each Instance In Parameters.ArrayOfInstance Do
			
			PhysicalCountByLocationObject = Documents.PhysicalCountByLocation.CreateDocument();

			// try lock for modify
			PhysicalCountByLocationObject.Lock();
			PhysicalCountByLocationObject.Fill(Undefined);
			PhysicalCountByLocationObject.Date = CurrentSessionDate();
			PhysicalCountByLocationObject.PhysicalInventory = Parameters.PhysicalInventory;
			PhysicalCountByLocationObject.Store = Parameters.Store;
			PhysicalCountByLocationObject.ResponsiblePerson = Instance.ResponsiblePerson;
			PhysicalCountByLocationObject.ItemList.Clear();
			For Each ItemListRow In Instance.ItemList Do
				NewRow = PhysicalCountByLocationObject.ItemList.Add();
				NewRow.Key = ItemListRow.Key;
				NewRow.ItemKey = ItemListRow.ItemKey;
				NewRow.Unit = ItemListRow.Unit;
				NewRow.ExpCount = ItemListRow.ExpCount;
				NewRow.PhysCount = ItemListRow.PhysCount;
				NewRow.Difference = ItemListRow.Difference;
			EndDo;
			PhysicalCountByLocationObject.Write();
		EndDo;
	
	Except
		HaveError = True;
		CommonFunctionsClientServer.ShowUsersMessage(StrTemplate(R().Exc_009, ErrorDescription()));
	EndTry;
	
	If TransactionActive() Then
		If HaveError Then
			RollbackTransaction();
		Else
			CommitTransaction();
		EndIf;
	EndIf;
EndProcedure

Function GetLinkedPhysicalCountByLocation(PhysicalInventoryRef, AddInfo = Undefined) Export
	Query = New Query();
	Query.Text = 
	"SELECT
	|	PhysicalCountByLocationItemList.Key,
	|	PhysicalCountByLocationItemList.Ref,
	|	PhysicalCountByLocationItemList.Ref.Number AS Number,
	|	PhysicalCountByLocationItemList.Ref.Date AS Date,
	|	PhysicalCountByLocationItemList.Ref.ResponsiblePerson AS ResponsiblePerson
	|FROM
	|	Document.PhysicalCountByLocation.ItemList AS PhysicalCountByLocationItemList
	|WHERE
	|	PhysicalCountByLocationItemList.Ref.PhysicalInventory = &PhysicalInventoryRef
	|	AND
	|	NOT PhysicalCountByLocationItemList.Ref.DeletionMark";
	Query.SetParameter("PhysicalInventoryRef", PhysicalInventoryRef);
	QueryResult = Query.Execute();
	QuerySelection = QueryResult.Select();
	Result = New Array();
	While QuerySelection.Next() Do
		Row = New Structure("Key, Ref, Number, Date, ResponsiblePerson");
		FillPropertyValues(Row, QuerySelection);
		
		Result.Add(Row);
	EndDo;
	Return Result;
EndFunction

// The procedure for filling a spreadsheet document for printing.
//
// Parameters:
//	Spreadsheet - SpreadsheetDocument - spreadsheet document to fill out and print.
//	Ref - Arbitrary - contains a reference to the object for which the print command was executed.
Procedure PrintQR(Spreadsheet, Ref) Export
	Template = Documents.PhysicalCountByLocation.GetTemplate("PrintQR");
	Query = New Query;
	Query.Text =
		"SELECT
		|	PhysicalCountByLocation.Number
		|FROM
		|	Document.PhysicalCountByLocation AS PhysicalCountByLocation
		|WHERE
		|	PhysicalCountByLocation.Ref IN (&Ref)";
	Query.Parameters.Insert("Ref", Ref);
	Selection = Query.Execute().Select();

	Header = Template.GetArea("Header");

	Spreadsheet.Clear();
	
	InsertPageBreak = False;
	While Selection.Next() Do
		Header.Drawings.QR = BarcodeServer.GetQRPicture(New Structure("Barcode", Selection.Number));
		Header.Parameters.Fill(Selection);
		Spreadsheet.Put(Header, Selection.Level());
		
		InsertPageBreak = True;
	EndDo;
EndProcedure
