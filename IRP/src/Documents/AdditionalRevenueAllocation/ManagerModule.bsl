
#Region Posting

Function PostingGetDocumentDataTables(Ref, Cancel, PostingMode, Parameters, AddInfo = Undefined) Export
	Tables = New Structure();
	QueryArray = GetQueryTextsSecondaryTables();
	PostingServer.ExecuteQuery(Ref, QueryArray, Parameters);
	Parameters.IsReposting = False;
	Return Tables;
EndFunction

Function PostingGetLockDataSource(Ref, Cancel, PostingMode, Parameters, AddInfo = Undefined) Export
	DataMapWithLockFields = New Map();
	Return DataMapWithLockFields;
EndFunction

Procedure PostingCheckBeforeWrite(Ref, Cancel, PostingMode, Parameters, AddInfo = Undefined) Export
	Tables = Parameters.DocumentDataTables;	
	QueryArray = GetQueryTextsMasterTables();
	PostingServer.SetRegisters(Tables, Ref);
	
	Tables.R6080T_OtherPeriodsRevenues.Columns.Add("Key"           , Metadata.DefinedTypes.typeRowID.Type);
	Tables.T6070S_BatchRevenueAllocationInfo.Columns.Add("Key"        , Metadata.DefinedTypes.typeRowID.Type);
	Tables.T6070S_BatchRevenueAllocationInfo.Columns.Add("RowID"      , Metadata.DefinedTypes.typeRowID.Type);
	Tables.T6070S_BatchRevenueAllocationInfo.Columns.Add("BasisRowID" , Metadata.DefinedTypes.typeRowID.Type);
	Tables.T6070S_BatchRevenueAllocationInfo.Columns.Add("Basis"      ,
		Metadata.AccumulationRegisters.R6080T_OtherPeriodsRevenues.Dimensions.Basis.Type);
	
	PostingServer.FillPostingTables(Tables, Ref, QueryArray, Parameters);
	
	// OtherPeriodsRevenues
	TableOtherPeriodsRevenues = Tables.R6080T_OtherPeriodsRevenues.Copy();
	TableOtherPeriodsRevenues.GroupBy("Basis");
	ArrayOfBasises = TableOtherPeriodsRevenues.UnloadColumn("Basis");
	
	TableOtherPeriodsRevenuesRecalculated = Tables.R6080T_OtherPeriodsRevenues.CopyColumns();
	For Each Basis In ArrayOfBasises Do
		
		CurrencyTable = Basis.Currencies.Unload();
		
		OtherPeriodsRevenuesByBasis = Tables.R6080T_OtherPeriodsRevenues.Copy(New Structure("Basis", Basis));
		If TypeOf(Basis) = Type("DocumentRef.SalesInvoice") Then
			If CurrencyTable.Count() Then
				OtherPeriodsRevenuesByBasis.FillValues(CurrencyTable[0].Key, "Key");
			EndIf;	
		EndIf;
		
		PostingDataTables = New Map();
		PostingDataTables.Insert(Parameters.Object.RegisterRecords.R6080T_OtherPeriodsRevenues,
			New Structure("RecordSet, WriteInTransaction", OtherPeriodsRevenuesByBasis, Parameters.IsReposting));
		Parameters.Insert("PostingDataTables", PostingDataTables);
		
		RevenueAllocationObject = Parameters.Object;
		Parameters.Object = Basis;
		CurrenciesServer.PreparePostingDataTables(Parameters, CurrencyTable, AddInfo);
		Parameters.Object = RevenueAllocationObject;
		
		For Each RowRecordSet In Parameters.PostingDataTables.Get(Parameters.Object.RegisterRecords.R6080T_OtherPeriodsRevenues).RecordSet Do
			FillPropertyValues(TableOtherPeriodsRevenuesRecalculated.Add(), RowRecordSet);
		EndDo;
	EndDo;
	Tables.R6080T_OtherPeriodsRevenues = TableOtherPeriodsRevenuesRecalculated;
	
	// BatchRevenueAllocationInfo
	CurrencyMovementType = Ref.Company.LandedCostCurrencyMovementType;
	BatchRevenueAllocationInfoRecalculated = Tables.T6070S_BatchRevenueAllocationInfo.CopyColumns();
	For Each Row In Tables.T6070S_BatchRevenueAllocationInfo Do
		CurrencyTable = Row.Basis.Currencies.Unload();
		
		BatchRevenueAllocationInfoByBasis = 
		Tables.T6070S_BatchRevenueAllocationInfo.Copy(New Structure("RowID, BasisRowID", Row.RowID, Row.BasisRowID));
		If TypeOf(Row.Basis) = Type("DocumentRef.SalesInvoice") Then
			If CurrencyTable.Count() Then
				BatchRevenueAllocationInfoByBasis.FillValues(CurrencyTable[0].Key, "Key");
			EndIf;	
		EndIf;
	
		PostingDataTables = New Map();
		PostingDataTables.Insert(Parameters.Object.RegisterRecords.T6070S_BatchRevenueAllocationInfo,
			New Structure("RecordSet, WriteInTransaction", BatchRevenueAllocationInfoByBasis, Parameters.IsReposting));
		Parameters.Insert("PostingDataTables", PostingDataTables);
		
		RevenueAllocationObject = Parameters.Object;
		Parameters.Object = Row.Basis;
		CurrenciesServer.PreparePostingDataTables(Parameters, CurrencyTable, AddInfo);
		Parameters.Object = RevenueAllocationObject;
		
		For Each RowRecordSet In Parameters
		                .PostingDataTables
		                .Get(Parameters.Object.RegisterRecords.T6070S_BatchRevenueAllocationInfo)
		                .RecordSet Do
			FillPropertyValues(BatchRevenueAllocationInfoRecalculated.Add(), RowRecordSet);
		EndDo;	
	EndDo;
	
	BatchRevenueAllocationInfoRecalculated = BatchRevenueAllocationInfoRecalculated.Copy(New Structure("CurrencyMovementType", CurrencyMovementType));
	BatchRevenueAllocationInfoRecalculated.GroupBy("Period, Company, Document, Store, ItemKey, Currency, CurrencyMovementType", 
	"Amount");	
	Tables.T6070S_BatchRevenueAllocationInfo = BatchRevenueAllocationInfoRecalculated;
	
	OtherPeriodsRevenuesMetadata    = Parameters.Object.RegisterRecords.R6080T_OtherPeriodsRevenues.Metadata();
	BatchRevenueAllocationInfoMetadata = Parameters.Object.RegisterRecords.T6070S_BatchRevenueAllocationInfo.Metadata();
	If Parameters.Property("MultiCurrencyExcludePostingDataTables") Then
		Parameters.MultiCurrencyExcludePostingDataTables.Add(OtherPeriodsRevenuesMetadata);
		Parameters.MultiCurrencyExcludePostingDataTables.Add(BatchRevenueAllocationInfoMetadata);
	Else
		ArrayOfMultiCurrencyExcludePostingDataTables = New Array();
		ArrayOfMultiCurrencyExcludePostingDataTables.Add(OtherPeriodsRevenuesMetadata);
		ArrayOfMultiCurrencyExcludePostingDataTables.Add(BatchRevenueAllocationInfoMetadata);
		Parameters.Insert("MultiCurrencyExcludePostingDataTables", ArrayOfMultiCurrencyExcludePostingDataTables);
	EndIf;
EndProcedure

Function PostingGetPostingDataTables(Ref, Cancel, PostingMode, Parameters, AddInfo = Undefined) Export
	PostingDataTables = New Map();
	PostingServer.SetPostingDataTables(PostingDataTables, Parameters);
	Return PostingDataTables;
EndFunction

Procedure PostingCheckAfterWrite(Ref, Cancel, PostingMode, Parameters, AddInfo = Undefined) Export
	CheckAfterWrite(Ref, Cancel, Parameters, AddInfo);
EndProcedure

#EndRegion

#Region Undoposting

Function UndopostingGetDocumentDataTables(Ref, Cancel, Parameters, AddInfo = Undefined) Export
	Return PostingGetDocumentDataTables(Ref, Cancel, Undefined, Parameters, AddInfo);
EndFunction

Function UndopostingGetLockDataSource(Ref, Cancel, Parameters, AddInfo = Undefined) Export
	DataMapWithLockFields = New Map();
	Return DataMapWithLockFields;
EndFunction

Procedure UndopostingCheckBeforeWrite(Ref, Cancel, Parameters, AddInfo = Undefined) Export
	QueryArray = GetQueryTextsMasterTables();
	PostingServer.ExecuteQuery(Ref, QueryArray, Parameters);
EndProcedure

Procedure UndopostingCheckAfterWrite(Ref, Cancel, Parameters, AddInfo = Undefined) Export
	Parameters.Insert("Unposting", True);
	CheckAfterWrite(Ref, Cancel, Parameters, AddInfo);
EndProcedure

#EndRegion

#Region CheckAfterWrite

Procedure CheckAfterWrite(Ref, Cancel, Parameters, AddInfo = Undefined)
	Parameters.Insert("RecordType", AccumulationRecordType.Receipt);
EndProcedure

#EndRegion

Function GetInformationAboutMovements(Ref) Export
	Str = New Structure;
	Str.Insert("QueryParameters", GetAdditionalQueryParameters(Ref));
	Str.Insert("QueryTextsMasterTables", GetQueryTextsMasterTables());
	Str.Insert("QueryTextsSecondaryTables", GetQueryTextsSecondaryTables());
	Return Str;
EndFunction

Function GetAdditionalQueryParameters(Ref)
	StrParams = New Structure();
	StrParams.Insert("Ref", Ref);
	Return StrParams;
EndFunction

Function GetQueryTextsSecondaryTables()
	QueryArray = New Array;
	QueryArray.Add(RevenueList());
	QueryArray.Add(AllocationList());
	Return QueryArray;
EndFunction

Function GetQueryTextsMasterTables()
	QueryArray = New Array;
	QueryArray.Add(R6080T_OtherPeriodsRevenues());
	QueryArray.Add(T6070S_BatchRevenueAllocationInfo());
	Return QueryArray;
EndFunction

Function RevenueList()
	Return
	"SELECT
	|	RevenueList.Ref.Date AS Period,
	|	RevenueList.Ref.Company AS Company,
	|	RevenueList.Ref.Branch AS Branch,
	|	RevenueList.Basis AS Basis,
	|	RevenueList.ItemKey AS ItemKey,
	|	RevenueList.RowID AS RowID,
	|	RevenueList.Basis.Currency AS Currency,
	|	RevenueList.RowID AS Key,
	|	SUM(ISNULL(AllocationList.Amount, 0)) AS Amount,
	|	AllocationList.RowID
	|INTO RevenueList
	|FROM
	|	Document.AdditionalRevenueAllocation.RevenueList AS RevenueList
	|		LEFT JOIN Document.AdditionalRevenueAllocation.AllocationList AS AllocationList
	|		ON RevenueList.RowID = AllocationList.BasisRowID
	|		AND RevenueList.Ref = &Ref
	|		AND AllocationList.Ref = &Ref
	|WHERE
	|	RevenueList.Ref = &Ref
	|	AND NOT AllocationList.RowID IS NULL
	|GROUP BY
	|	AllocationList.RowID,
	|	RevenueList.Basis,
	|	RevenueList.Basis.Currency,
	|	RevenueList.ItemKey,
	|	RevenueList.Ref.Branch,
	|	RevenueList.Ref.Company,
	|	RevenueList.Ref.Date,
	|	RevenueList.RowID";
EndFunction

Function AllocationList()
	Return
	"SELECT
	|	AllocationList.Ref.Date AS Period,
	|	AllocationList.Ref.Company AS Company,
	|	AllocationList.Document AS Document,
	|	AllocationList.Store AS Store,
	|	AllocationList.ItemKey AS ItemKey,
	|	SUM(AllocationList.Amount) AS Amount,
	|	RevenueList.Currency AS Currency,
	|	RevenueList.Basis AS Basis,
	|	AllocationList.RowID AS Key,
	|	AllocationList.RowID AS RowID,
	|	AllocationList.BasisRowID AS BasisRowID
	|INTO AllocationList
	|FROM
	|	Document.AdditionalRevenueAllocation.AllocationList AS AllocationList
	|		LEFT JOIN Document.AdditionalRevenueAllocation.RevenueList AS RevenueList
	|		ON AllocationList.BasisRowID = RevenueList.RowID
	|		AND AllocationList.Ref = &Ref
	|		AND RevenueList.Ref = &Ref
	|WHERE
	|	AllocationList.Ref = &Ref
	|GROUP BY
	|	RevenueList.Currency,
	|	RevenueList.Basis,
	|	AllocationList.ItemKey,
	|	AllocationList.Document,
	|	AllocationList.Ref.Company,
	|	AllocationList.Ref.Company.LandedCostCurrencyMovementType,
	|	AllocationList.Ref.Date,
	|	AllocationList.Store,
	|	AllocationList.RowID,
	|	AllocationList.BasisRowID";	
EndFunction

Function R6080T_OtherPeriodsRevenues()
	Return
	"SELECT
	|	*,
	|	VALUE(AccumulationRecordType.Expense) AS RecordType
	|INTO R6080T_OtherPeriodsRevenues
	|FROM
	|	RevenueList AS RevenueList
	|WHERE
	|	TRUE";
EndFunction

Function T6070S_BatchRevenueAllocationInfo()
	Return
	"SELECT
	|	*
	|INTO T6070S_BatchRevenueAllocationInfo
	|FROM
	|	AllocationList AS AllocationList
	|WHERE
	|	TRUE";
EndFunction
