#Region FormEvents
Procedure BeforeWrite(Object, Form, Cancel, WriteParameters) Export
	If Not Form.TaxAndOffersCalculated Then

		OffersClient.OpenFormPickupSpecialOffers_ForDocument(Object, Form, "SpecialOffersEditFinish_ForDocument", ,
			True);

	EndIf;
EndProcedure

Procedure OnOpen(Object, Form, Cancel, AddInfo = Undefined) Export
//	DocumentsClient.OnOpenPutServerDataToAddInfo(Object, Form, AddInfo);
//	ServerData = CommonFunctionsClientServer.GetFromAddInfo(AddInfo, "ServerData");
//
//	Settings = New Structure();
//	Settings.Insert("UpdateInfoString");
//	If AddInfo <> Undefined And AddInfo.Property("RemovedActions") Then
//		For Each RemovedAction In AddInfo.RemovedActions Do
//			Settings.Delete(RemovedAction);
//		EndDo;
//	EndIf;
//
//#If Not MobileClient Then
//	Settings.Delete("UpdateInfoString");
//#EndIf
//
//	Form.TaxAndOffersCalculated = True;
//	If Settings.Count() Then
//		CalculationStringsClientServer.CalculateItemsRows(Object, Form, Object.ItemList, Settings, Undefined, AddInfo);
//	EndIf;
//
//	If Not ValueIsFilled(Object.Ref) Then
//		ItemListOnChange(Object, Form, Undefined);
//		If ValueIsFilled(Object.Company) Then
//			DocumentsClient.CompanyOnChange(Object, Form, ThisObject, Undefined);
//		EndIf;
//		If ValueIsFilled(Object.Agreement) Then
//			CommonFunctionsClientServer.DeleteFromAddInfo(AddInfo, "ServerData");
//			AgreementSettings = AgreementSettings(Object, Form);
//			If AgreementSettings.Property("PutServerDataToAddInfo") And AgreementSettings.PutServerDataToAddInfo Then
//				AgreementOnChangePutServerDataToAddInfo(Object, Form, AddInfo);
//			EndIf;
//			AgreementSettings = AgreementSettings(Object, Form, AddInfo);
//			AgreementSettings.Actions = New Structure("ChangePaymentTerm", "ChangePaymentTerm");
//
//			Settings = New Structure("AgreementSettings", AgreementSettings);
//			DocumentsClient.AgreementOnChange(Object, Form, ThisObject, Undefined, Settings, AddInfo);
//
//			CalculateSettings = New Structure("CalculateSpecialOffers, CalculateNetAmount, CalculateTax, CalculateTotalAmount");
//			PriceDate = CalculationStringsClientServer.GetSliceLastDateByRefAndDate(Object.Ref, Object.Date);
//			CalculateSettings.Insert("ChangePriceType", New Structure("Period, PriceType", PriceDate,
//				ServerData.AgreementInfo.PriceType));
//			Rows = Object.ItemList.FindRows(New Structure("Price", 0));
//			CalculationStringsClientServer.CalculateItemsRows(Object, Form, Rows, CalculateSettings,
//				ServerData.ArrayOfTaxInfo, AddInfo);
//		EndIf;
//	EndIf;
//
//	If Not ValueIsFilled(Form.CurrentStore) Then
//		DocumentsClient.SetCurrentStore(Object, Form, ServerData.AgreementInfo.Store);
//	EndIf;
//
//	DocumentsClient.FillDeliveryDates(Object, Form);
//	If Not ValueIsFilled(Form.CurrentDeliveryDate) Then
//		DocumentsClient.SetCurrentDeliveryDate(Form, ServerData.AgreementInfo.DeliveryDate);
//	EndIf;
//
//	If Not ValueIsFilled(Form.CurrentPriceType) Then
//		DocumentsClient.SetCurrentPriceType(Form, ServerData.AgreementInfo.PriceType);
//	EndIf;
//
//#If AtClient Then
//	DocumentsClient.SetTextOfDescriptionAtForm(Object, Form);
//#EndIf
//	DocumentsClient.SetTextOfDescriptionAtForm(Object, Form);
//	SerialLotNumberClient.UpdateSerialLotNumbersPresentation(Object, AddInfo);
//	SerialLotNumberClient.UpdateSerialLotNumbersTree(Object, Form);
//	DocumentsClient.SetLockedRowsForItemListByTradeDocuments(Object, Form, "ShipmentConfirmations");
//	DocumentsClient.UpdateTradeDocumentsTree(Object, Form, "ShipmentConfirmations", "ShipmentConfirmationsTree",
//		"QuantityInShipmentConfirmation");
		
//
ViewClient_V2.OnOpen(Object, Form, "ItemList");
//
EndProcedure

Procedure NotificationProcessing(Object, Form, EventName, Parameter, Source, AddInfo = Undefined) Export
	Return;
//	If EventName = "CalculationStringsComplete" Then
//		DocumentsClient.CalculatePaymentTermDateAndAmount(Object, Form, AddInfo);
//	EndIf;
EndProcedure

Procedure AfterWriteAtClient(Object, Form, WriteParameters, AddInfo = Undefined) Export
	DocumentsClient.AfterWriteAtClientPutServerDataToAddInfo(Object, Form, AddInfo);
	DocumentsClient.FillDeliveryDates(Object, Form);
	SerialLotNumberClient.UpdateSerialLotNumbersPresentation(Object, AddInfo);
	DocumentsClient.SetLockedRowsForItemListByTradeDocuments(Object, Form, "ShipmentConfirmations");
	DocumentsClient.UpdateTradeDocumentsTree(Object, Form, "ShipmentConfirmations", "ShipmentConfirmationsTree",
		"QuantityInShipmentConfirmation");
	RowIDInfoClient.AfterWriteAtClient(Object, Form, WriteParameters, AddInfo);
EndProcedure

#EndRegion

#Region ItemListEvents

Procedure ItemListBeforeAddRow(Object, Form, Item, Cancel, Clone, Parent, IsFolder, Parameter) Export
	ViewClient_V2.ItemListBeforeAddRow(Object, Form, Cancel, Clone);
EndProcedure

Procedure ItemListAfterDeleteRow(Object, Form, Item, AddInfo = Undefined) Export
	ViewClient_V2.ItemListAfterDeleteRow(Object, Form);
	
//	DocumentsClient.ItemListAfterDeleteRow(Object, Form, Item);
//	SerialLotNumberClient.DeleteUnusedSerialLotNumbers(Object);
//	SerialLotNumberClient.UpdateSerialLotNumbersTree(Object, Form);
//	DocumentsClient.ClearTradeDocumentsTable(Object, Form, "ShipmentConfirmations");
//	DocumentsClient.UpdateTradeDocumentsTree(Object, Form, "ShipmentConfirmations", "ShipmentConfirmationsTree",
//		"QuantityInShipmentConfirmation");
//	DocumentsClient.CalculatePaymentTermDateAndAmount(Object, Form, AddInfo);
EndProcedure

Procedure ItemListOnChange(Object, Form, Item = Undefined, CurrentRowData = Undefined) Export
	Return;
//	DocumentsClient.FillRowIDInItemList(Object);
//	DocumentsClient.FillDeliveryDates(Object, Form);
//	RowIDInfoClient.UpdateQuantity(Object, Form);
EndProcedure

Procedure ItemListOnStartEdit(Object, Form, Item, NewRow, Clone, AddInfo = Undefined) Export
	Return;
//	CurrentData = Item.CurrentData;
//	If CurrentData = Undefined Then
//		Return;
//	EndIf;
//	If Clone Then
//		CurrentData.Key = New UUID();
//	EndIf;
//	DocumentsClient.TableOnStartEdit(Object, Form, "Object.ItemList", Item, NewRow, Clone);
//	RowIDInfoClient.ItemListOnStartEdit(Object, Form, Item, NewRow, Clone, AddInfo);
EndProcedure

Procedure ItemListOnActivateRow(Object, Form, Item = Undefined, CurrentRowData = Undefined, AddInfo = Undefined) Export
	Return;
//	CurrentData = DocumentsClient.GetCurrentRowDataList(Form.Items.ItemList, CurrentRowData);
//
//	If CurrentData = Undefined Then
//		Return;
//	EndIf;
//
//	If ValueIsFilled(CurrentData.Store) And CurrentData.Store <> Form.CurrentStore Then
//		DocumentsClient.SetCurrentStore(Object, Form, CurrentData.Store);
//	EndIf;
//
//	If ValueIsFilled(CurrentData.DeliveryDate) And CurrentData.DeliveryDate <> Form.CurrentDeliveryDate Then
//		DocumentsClient.SetCurrentDeliveryDate(Form, CurrentData.DeliveryDate);
//	EndIf;
//
//	If ValueIsFilled(CurrentData.PriceType) And CurrentData.PriceType <> Form.CurrentPriceType Then
//		DocumentsClient.SetCurrentPriceType(Form, CurrentData.PriceType);
//	EndIf;
EndProcedure

Procedure ItemListSelection(Object, Form, Item, RowSelected, Field, StandardProcessing, AddInfo = Undefined) Export
	If Upper(Field.Name) = Upper("ItemListTaxAmount") Then
		CurrentData = Form.Items.ItemList.CurrentData;
		If CurrentData <> Undefined Then
			DocumentsClient.ItemListSelectionPutServerDataToAddInfo(Object, Form, AddInfo);
			Parameters = New Structure();
			Parameters.Insert("CurrentData", CurrentData);
			Parameters.Insert("Item", Item);
			Parameters.Insert("Field", Field);
			TaxesClient.ChangeTaxAmount(Object, Form, Parameters, StandardProcessing, AddInfo);
		EndIf;
	EndIf;
	RowIDInfoClient.ItemListSelection(Object, Form, Item, RowSelected, Field, StandardProcessing, AddInfo);
EndProcedure

Procedure ItemListBeforeDeleteRow(Object, Form, Item, Cancel, AddInfo = Undefined) Export
	RowIDInfoClient.ItemListBeforeDeleteRow(Object, Form, Item, Cancel, AddInfo);	
EndProcedure

#EndRegion

Procedure DeliveryDateOnChange(Object, Form, Item) Export
	ViewClient_V2.DeliveryDateOnChange(Object, Form, "ItemList");
EndProcedure

Procedure ItemListDeliveryDateOnChange(Object, Form, Item) Export
	ViewClient_V2.ItemListDeliveryDateOnChange(Object, Form);
EndProcedure

#Region ItemListItemsEvents

#Region Item

Procedure ItemListItemOnChange(Object, Form, Item, AddInfo = Undefined) Export
	ViewClient_V2.ItemListItemOnChange(Object, Form);
	//DocumentsClient.ItemListItemOnChange(Object, Form, ThisObject, Item, Undefined, AddInfo);
	//SerialLotNumberClient.UpdateUseSerialLotNumber(Object, Form, AddInfo);
EndProcedure

Procedure ItemListItemStartChoice(Object, Form, Item, ChoiceData, StandardProcessing) Export
	OpenSettings = DocumentsClient.GetOpenSettingsStructure();

	OpenSettings.ArrayOfFilters = New Array();
	OpenSettings.ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True,
		DataCompositionComparisonType.NotEqual));

	DocumentsClient.ItemStartChoice(Object, Form, Item, ChoiceData, StandardProcessing, OpenSettings);
EndProcedure

Procedure ItemListItemEditTextChange(Object, Form, Item, Text, StandardProcessing) Export
	ArrayOfFilters = New Array();
	ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True, ComparisonType.NotEqual));
	DocumentsClient.ItemEditTextChange(Object, Form, Item, Text, StandardProcessing, ArrayOfFilters);
EndProcedure

//Procedure ItemListItemOnChangePutServerDataToAddInfo(Object, Form, CurrentRow, AddInfo = Undefined) Export
//	DocumentsClient.ItemListItemOnChangePutServerDataToAddInfo(Object, Form, CurrentRow, AddInfo);
//EndProcedure

//Function ItemListItemSettings(Object, Form, AddInfo = Undefined) Export
//	If AddInfo = Undefined Then
//		Return New Structure("PutServerDataToAddInfo", True);
//	EndIf;
//
//	Settings = New Structure("Actions, ObjectAttributes, FormAttributes, AfterActionsCalculateSettings");
//
//	Actions = New Structure();
//	Actions.Insert("UpdateRowPriceType", "UpdateRowPriceType");
//	Actions.Insert("UpdateItemKey", "UpdateItemKey");
//
//	AfterActionsCalculateSettings = New Structure();
//	PriceDate = CalculationStringsClientServer.GetSliceLastDateByRefAndDate(Object.Ref, Object.Date);
//	AfterActionsCalculateSettings.Insert("UpdatePrice", New Structure("Period, PriceType", PriceDate,
//		Form.CurrentPriceType));
//
//	Settings.Actions = Actions;
//	Settings.ObjectAttributes = "ItemKey";
//	Settings.FormAttributes = "";
//	Settings.AfterActionsCalculateSettings = AfterActionsCalculateSettings;
//	Return Settings;
//EndFunction

#EndRegion

#Region ItemKey

Procedure ItemListItemKeyOnChange(Object, Form, Item, AddInfo = Undefined) Export
	ViewClient_V2.ItemListItemKeyOnChange(Object, Form);
	//DocumentsClient.ItemListItemKeyOnChange(Object, Form, ThisObject, Item, Undefined, AddInfo);
	//SerialLotNumberClient.UpdateUseSerialLotNumber(Object, Form, AddInfo);
EndProcedure

//Procedure ItemListItemKeyOnChangePutServerDataToAddInfo(Object, Form, CurrentRow, AddInfo = Undefined) Export
//	DocumentsClient.ItemListItemKeyOnChangePutServerDataToAddInfo(Object, Form, CurrentRow, AddInfo);
//EndProcedure
//
//Function ItemListItemKeySettings(Object, Form, AddInfo = Undefined) Export
//	If AddInfo = Undefined Then
//		Return New Structure("PutServerDataToAddInfo", True);
//	EndIf;
//
//	Settings = New Structure("Actions, ObjectAttributes, FormAttributes, AfterActionsCalculateSettings");
//
//	Actions = New Structure();
//	Actions.Insert("UpdateRowPriceType", "UpdateRowPriceType");
//	Actions.Insert("UpdateRowUnit", "UpdateRowUnit");
//	Actions.Insert("UpdateRowUseShipmentConfirmation", "UpdateRowUseShipmentConfirmation");
//	
//	AfterActionsCalculateSettings = New Structure();
//	PriceDate = CalculationStringsClientServer.GetSliceLastDateByRefAndDate(Object.Ref, Object.Date);
//	AfterActionsCalculateSettings.Insert("UpdatePrice", New Structure("Period, PriceType", PriceDate,
//		Form.CurrentPriceType));
//
//	Settings.Actions = Actions;
//	Settings.ObjectAttributes = "ItemKey";
//	Settings.FormAttributes = "";
//	Settings.AfterActionsCalculateSettings = AfterActionsCalculateSettings;
//	Return Settings;
//EndFunction

#EndRegion

#Region PriceType

Procedure ItemListPriceTypeOnChange(Object, Form, Item, AddInfo = Undefined) Export
	ViewClient_V2.ItemListPriceTypeOnChange(Object, Form);
	//DocumentsClient.ItemListPriceTypeOnChange(Object, Form, ThisObject, Item, Undefined, AddInfo);
EndProcedure

//Procedure ItemListPriceTypeOnChangePutServerDataToAddInfo(Object, Form, AddInfo = Undefined) Export
//	DocumentsClient.ItemListPriceTypeOnChangePutServerDataToAddInfo(Object, Form, AddInfo);
//EndProcedure
//
//Function ItemListPriceTypeSettings(Object, Form, AddInfo = Undefined) Export
//	If AddInfo = Undefined Then
//		Return New Structure("PutServerDataToAddInfo", True);
//	EndIf;
//
//	Settings = New Structure("Actions, ObjectAttributes, FormAttributes");
//	Settings.Actions = New Structure();
//	Settings.ObjectAttributes = "";
//	Settings.FormAttributes = "";
//	Return Settings;
//EndFunction

#EndRegion

#Region Unit

Procedure ItemListUnitOnChange(Object, Form, Item, AddInfo = Undefined) Export
	ViewClient_V2.ItemListUnitOnChange(Object, Form);
	
	//DocumentsClient.ItemListUnitOnChange(Object, Form, ThisObject, Item, Undefined, AddInfo);
	//DocumentsClient.UpdateTradeDocumentsTree(Object, Form, "ShipmentConfirmations", "ShipmentConfirmationsTree",
	//	"QuantityInShipmentConfirmation");
EndProcedure

//Procedure ItemListUnitOnChangePutServerDataToAddInfo(Object, Form, AddInfo = Undefined) Export
//	DocumentsClient.ItemListUnitOnChangePutServerDataToAddInfo(Object, Form, AddInfo);
//EndProcedure
//
//Function ItemListUnitSettings(Object, Form, AddInfo = Undefined) Export
//	If AddInfo = Undefined Then
//		Return New Structure("PutServerDataToAddInfo", True);
//	EndIf;
//
//	Settings = New Structure("Actions, ObjectAttributes, FormAttributes");
//	Actions = New Structure();
//	Settings.Actions = Actions;
//	Settings.ObjectAttributes = "ItemKey";
//	Settings.FormAttributes = "";
//	Return Settings;
//EndFunction

#EndRegion

#Region Quantity

Procedure ItemListQuantityOnChange(Object, Form, Item = Undefined, CurrentRowData = Undefined, AddInfo = Undefined) Export
	ViewClient_V2.ItemListQuantityOnChange(Object, Form);
	
	//CurrentData = DocumentsClient.GetCurrentRowDataList(Form.Items.ItemList, CurrentRowData);
	//If CurrentData = Undefined Then
	//	Return;
	//EndIf;
	//DocumentsClient.ItemListCalculateRowAmounts_QuantityChange(Object, Form, CurrentData, Item, ThisObject, AddInfo);
	//SerialLotNumberClient.UpdateSerialLotNumbersTree(Object, Form);
	//DocumentsClient.UpdateTradeDocumentsTree(Object, Form, "ShipmentConfirmations", "ShipmentConfirmationsTree", "QuantityInShipmentConfirmation");
EndProcedure

//Procedure ItemListQuantityPutServerDataToAddInfo(Object, Form, CurrentData, AddInfo = Undefined) Export
//	DocumentsClient.ItemListQuantityPutServerDataToAddInfo(Object, Form, CurrentData, AddInfo);
//EndProcedure

#EndRegion

#Region Price

Procedure ItemListPriceOnChange(Object, Form, Item = Undefined, CurrentRowData = Undefined, AddInfo = Undefined) Export
	ViewClient_V2.ItemListPriceOnChange(Object, Form);
//	CurrentData = DocumentsClient.GetCurrentRowDataList(Form.Items.ItemList, CurrentRowData);
//	If CurrentData = Undefined Then
//		Return;
//	EndIf;
//	DocumentsClient.ItemListCalculateRowAmounts_PriceChange(Object, Form, CurrentData, Item, ThisObject, AddInfo);
EndProcedure

//Procedure ItemListPricePutServerDataToAddInfo(Object, Form, CurrentData, AddInfo = Undefined) Export
//	DocumentsClient.ItemListPricePutServerDataToAddInfo(Object, Form, CurrentData, AddInfo);
//EndProcedure

#EndRegion

#Region TotalAmount

Procedure ItemListTotalAmountOnChange(Object, Form, Item = Undefined, CurrentRowData = Undefined, AddInfo = Undefined) Export
	ViewClient_V2.ItemListTotalAmountOnChange(Object, Form);
	
//	CurrentData = DocumentsClient.GetCurrentRowDataList(Form.Items.ItemList, CurrentRowData);
//	If CurrentData = Undefined Then
//		Return;
//	EndIf;
//	If Not CurrentData.DontCalculateRow Then
//		DocumentsClient.ItemListCalculateRowAmounts_TotalAmountChange(Object, Form, CurrentData, Item, ThisObject,
//			AddInfo);
//	EndIf;
EndProcedure

//Procedure ItemListTotalAmountPutServerDataToAddInfo(Object, Form, CurrentData, AddInfo = Undefined) Export
//	DocumentsClient.ItemListTotalAmountPutServerDataToAddInfo(Object, Form, CurrentData, AddInfo);
//EndProcedure

#EndRegion

#Region TaxAmount

Procedure ItemListTaxAmountOnChange(Object, Form, Item = Undefined, CurrentRowData = Undefined, AddInfo = Undefined) Export
	ViewClient_V2.ItemListTaxAmountOnChange(Object, Form);
	
//	CurrentData = DocumentsClient.GetCurrentRowDataList(Form.Items.ItemList, CurrentRowData);
//	If CurrentData = Undefined Then
//		Return;
//	EndIf;
//	DocumentsClient.ItemListCalculateRowAmounts_TaxAmountChange(Object, Form, CurrentData, Item, ThisObject, AddInfo);
EndProcedure

//Procedure ItemListTaxAmountPutServerDataToAddInfo(Object, Form, CurrentData, AddInfo = Undefined) Export
//	DocumentsClient.ItemListTaxAmountPutServerDataToAddInfo(Object, Form, CurrentData, AddInfo);
//EndProcedure

#EndRegion

#Region DontCalculateRow

Procedure ItemListDontCalculateRowOnChange(Object, Form, Item = Undefined, CurrentRowData = Undefined, AddInfo = Undefined) Export
	ViewClient_V2.ItemListDontCalculateRowOnChange(Object, Form);
	
//	CurrentData = DocumentsClient.GetCurrentRowDataList(Form.Items.ItemList, CurrentRowData);
//	If CurrentData = Undefined Then
//		Return;
//	EndIf;
//	If Not CurrentData.DontCalculateRow Then
//		DocumentsClient.ItemListCalculateRowAmounts_DontCalculateRowChange(Object, Form, CurrentData, Item, ThisObject,
//			AddInfo);
//	EndIf;
EndProcedure

//Procedure ItemListDontCalculateRowPutServerDataToAddInfo(Object, Form, CurrentData, AddInfo = Undefined) Export
//	DocumentsClient.ItemListDontCalculateRowPutServerDataToAddInfo(Object, Form, CurrentData, AddInfo);
//EndProcedure

#EndRegion

#Region TaxValue

Procedure ItemListTaxValueOnChange(Object, Form, Item = Undefined, CurrentRowData = Undefined, AddInfo = Undefined) Export
	ViewClient_V2.ItemListTaxRateOnChange(Object, Form);

	
//	CurrentData = DocumentsClient.GetCurrentRowDataList(Form.Items.ItemList, CurrentRowData);
//	If CurrentData = Undefined Then
//		Return;
//	EndIf;
//	DocumentsClient.ItemListCalculateRowAmounts_TaxValueChange(Object, Form, CurrentData, Item, ThisObject, AddInfo);
EndProcedure

//Procedure ItemListTaxValuePutServerDataToAddInfo(Object, Form, CurrentData, AddInfo = Undefined) Export
//	DocumentsClient.ItemListTaxValuePutServerDataToAddInfo(Object, Form, CurrentData, AddInfo);
//EndProcedure

#EndRegion

#Region Store

Procedure ItemListStoreOnChange(Object, Form, Item, AddInfo = Undefined) Export
	ViewClient_V2.ItemListStoreOnChange(Object, Form);
	//DocumentsClient.ItemListStoreOnChange(Object, Form, ThisObject, Item);
EndProcedure

#EndRegion

#Region RevenueType

Procedure ItemListRevenueTypeStartChoice(Object, Form, Item, ChoiceData, StandardProcessing) Export
	DocumentsClient.RevenueTypeStartChoice(Object, Form, Item, ChoiceData, StandardProcessing);
EndProcedure

Procedure ItemListRevenueTypeEditTextChange(Object, Form, Item, Text, StandardProcessing) Export
	DocumentsClient.RevenueTypeEditTextChange(Object, Form, Item, Text, StandardProcessing);
EndProcedure

#EndRegion

#Region SerialLotNumbers

Procedure ItemListSerialLotNumbersPresentationStartChoice(Object, Form, Item, ChoiceData, StandardProcessing,
	AddInfo = Undefined) Export
	DocumentsClient.ItemListSerialLotNumbersPutServerDataToAddInfo(Object, Form, AddInfo);
	SerialLotNumberClient.PresentationStartChoice(Object, Form, Item, ChoiceData, StandardProcessing, AddInfo);
EndProcedure

Procedure ItemListSerialLotNumbersPresentationClearing(Object, Form, Item, StandardProcessing, AddInfo = Undefined) Export
	SerialLotNumberClient.PresentationClearing(Object, Form, Item, AddInfo);
EndProcedure

#EndRegion

#EndRegion

#Region PaymentTermsItemsEvents

Procedure PaymentTermsDateOnChange(Object, Form, Item, AddInfo = Undefined) Export
	DocumentsClient.CalculatePaymentTermDuePeriod(Object, Form, Item, AddInfo);
EndProcedure

Procedure PaymentTermsOnChange(Object, Form, Item, AddInfo = Undefined) Export
	DocumentsClient.CalculatePaymentTermDateAndAmount(Object, Form, AddInfo);
EndProcedure

#EndRegion

#Region ItemPartner

Procedure PartnerOnChange(Object, Form, Item, AddInfo = Undefined) Export
	ViewClient_V2.PartnerOnChange(Object, Form, "ItemList");
	//DocumentsClient.PartnerOnChange(Object, Form, ThisObject, Item, Undefined, AddInfo);
EndProcedure

//Procedure PartnerOnChangePutServerDataToAddInfo(Object, Form, AddInfo = Undefined) Export
//	DocumentsClient.PartnerOnChangePutServerDataToAddInfo(Object, Form, AddInfo);
//EndProcedure
//
//Function PartnerSettings(Object, Form, AddInfo = Undefined) Export
//	If AddInfo = Undefined Then
//		Return New Structure("PutServerDataToAddInfo", True);
//	EndIf;
//	ServerData = CommonFunctionsClientServer.GetFromAddInfo(AddInfo, "ServerData");
//
//	Settings = New Structure("Actions, ObjectAttributes, FormAttributes, AgreementType");
//
//	Actions = New Structure();
//	Actions.Insert("ChangeManagerSegment", "ChangeManagerSegment");
//	Actions.Insert("ChangeLegalName", "ChangeLegalName");
//	Actions.Insert("ChangeAgreement", "ChangeAgreement");
//	Settings.Actions = Actions;
//
//	Settings.ObjectAttributes 	= "Company, Currency, PriceIncludeTax, Agreement, LegalName, ManagerSegment";
//	Settings.FormAttributes		= "CurrentPriceType";
//	Settings.AgreementType      = ServerData.AgreementTypes_Customer;
//	Return Settings;
//EndFunction

Procedure PartnerStartChoice(Object, Form, Item, ChoiceData, StandardProcessing) Export
	OpenSettings = DocumentsClient.GetOpenSettingsStructure();

	OpenSettings.ArrayOfFilters = New Array();
	OpenSettings.ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True,
		DataCompositionComparisonType.NotEqual));
	OpenSettings.ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("Customer", True,
		DataCompositionComparisonType.Equal));
	OpenSettings.FormParameters = New Structure();
	OpenSettings.FormParameters.Insert("Filter", New Structure("Customer", True));
	OpenSettings.FillingData = New Structure("Customer", True);

	DocumentsClient.PartnerStartChoice(Object, Form, Item, ChoiceData, StandardProcessing, OpenSettings);
EndProcedure

Procedure PartnerTextChange(Object, Form, Item, Text, StandardProcessing) Export
	ArrayOfFilters = New Array();
	ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True, ComparisonType.NotEqual));
	ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("Customer", True, ComparisonType.Equal));
	AdditionalParameters = New Structure();
	DocumentsClient.PartnerEditTextChange(Object, Form, Item, Text, StandardProcessing, ArrayOfFilters,
		AdditionalParameters);
EndProcedure

#EndRegion

#Region ItemAgreement

Procedure AgreementOnChange(Object, Form, Item, AddInfo = Undefined) Export
	ViewClient_V2.AgreementOnChange(Object, Form, "ItemList");
	//DocumentsClient.AgreementOnChange(Object, Form, ThisObject, Item, Undefined, AddInfo);
EndProcedure

//Procedure AgreementOnChangePutServerDataToAddInfo(Object, Form, AddInfo = Undefined) Export
//	DocumentsClient.AgreementOnChangePutServerDataToAddInfo(Object, Form, AddInfo);
//EndProcedure
//
//Function AgreementSettings(Object, Form, AddInfo = Undefined) Export
//	If AddInfo = Undefined Then
//		Return New Structure("PutServerDataToAddInfo", True);
//	EndIf;
//
//	Settings = New Structure("Actions, ObjectAttributes, FormAttributes");
//	Actions = New Structure();
//	Actions.Insert("ChangeCompany", "ChangeCompany");
//	Actions.Insert("ChangePriceType", "ChangePriceType");
//	Actions.Insert("ChangeCurrency", "ChangeCurrency");
//	Actions.Insert("ChangePriceIncludeTax", "ChangePriceIncludeTax");
//	Actions.Insert("ChangeStore", "ChangeStore");
//	Actions.Insert("ChangeDeliveryDate", "ChangeDeliveryDate");
//	Actions.Insert("ChangePaymentTerm", "ChangePaymentTerm");
//	Actions.Insert("ChangeTaxRates", "ChangeTaxRates");
//
//	Settings.Actions = Actions;
//	Settings.ObjectAttributes = "Company, Currency, PriceIncludeTax, ManagerSegment";
//	Settings.FormAttributes = "Store, DeliveryDate, CurrentPriceType";
//	Return Settings;
//EndFunction

Procedure AgreementStartChoice(Object, Form, Item, ChoiceData, StandardProcessing) Export
	OpenSettings = DocumentsClient.GetOpenSettingsStructure();

	OpenSettings.ArrayOfFilters = New Array();
	OpenSettings.ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True,
		DataCompositionComparisonType.NotEqual));
	OpenSettings.ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("Type", PredefinedValue(
		"Enum.AgreementTypes.Customer"), DataCompositionComparisonType.Equal));
	OpenSettings.ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("Kind", PredefinedValue(
		"Enum.AgreementKinds.Standard"), DataCompositionComparisonType.NotEqual));
	OpenSettings.FormParameters = New Structure();
	OpenSettings.FormParameters.Insert("Partner", Object.Partner);
	OpenSettings.FormParameters.Insert("IncludeFilterByPartner", True);
	OpenSettings.FormParameters.Insert("IncludePartnerSegments", True);
	OpenSettings.FormParameters.Insert("EndOfUseDate", Object.Date);
	OpenSettings.FormParameters.Insert("IncludeFilterByEndOfUseDate", True);

	OpenSettings.FillingData = New Structure();
	OpenSettings.FillingData.Insert("Partner", Object.Partner);
	OpenSettings.FillingData.Insert("LegalName", Object.LegalName);
	OpenSettings.FillingData.Insert("Company", Object.Company);
	OpenSettings.FillingData.Insert("Type", PredefinedValue("Enum.AgreementTypes.Customer"));

	DocumentsClient.AgreementStartChoice(Object, Form, Item, ChoiceData, StandardProcessing, OpenSettings);
EndProcedure

Procedure AgreementTextChange(Object, Form, Item, Text, StandardProcessing) Export
	ArrayOfFilters = New Array();
	ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True, ComparisonType.NotEqual));
	ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("Type", PredefinedValue("Enum.AgreementTypes.Customer"),
		ComparisonType.Equal));
	ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("Kind", PredefinedValue("Enum.AgreementKinds.Standard"),
		ComparisonType.NotEqual));
	AdditionalParameters = New Structure();
	AdditionalParameters.Insert("IncludeFilterByEndOfUseDate", True);
	AdditionalParameters.Insert("IncludeFilterByPartner", True);
	AdditionalParameters.Insert("IncludePartnerSegments", True);
	AdditionalParameters.Insert("EndOfUseDate", Object.Date);
	AdditionalParameters.Insert("Partner", Object.Partner);
	DocumentsClient.AgreementEditTextChange(Object, Form, Item, Text, StandardProcessing, ArrayOfFilters,
		AdditionalParameters);
EndProcedure

#EndRegion

#Region ItemCurrency

Procedure CurrencyOnChange(Object, Form, Item, AddInfo = Undefined) Export
	ViewClient_V2.CurrencyOnChange(Object, Form, "ItemList");
	
	//DocumentsClient.CurrencyOnChange2(Object, Form, ThisObject, Item, Undefined, AddInfo);
EndProcedure

//Procedure CurrencyOnChangePutServerDataToAddInfo(Object, Form, AddInfo = Undefined) Export
//	DocumentsClient.CurrencyOnChangePutServerDataToAddInfo(Object, Form, AddInfo);
//EndProcedure
//
//Function CurrencySettings(Object, Form, AddInfo = Undefined) Export
//	If AddInfo = Undefined Then
//		Return New Structure("PutServerDataToAddInfo", True);
//	EndIf;
//
//	Return New Structure();
//EndFunction

#EndRegion

#Region ItemLegalName

Procedure LegalNameOnChange(Object, Form, Item) Export
	ViewClient_V2.LegalNameOnChange(Object, Form, "ItemList");
	//DocumentsClientServer.ChangeTitleGroupTitle(Object, Form);
EndProcedure

Procedure LegalNameContractOnChange(Object, Form, Item) Export
	DocumentsClientServer.ChangeTitleGroupTitle(Object, Form);
EndProcedure

Procedure LegalNameStartChoice(Object, Form, Item, ChoiceData, StandardProcessing) Export
	OpenSettings = DocumentsClient.GetOpenSettingsStructure();

	OpenSettings.ArrayOfFilters = New Array();
	OpenSettings.ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True,
		DataCompositionComparisonType.NotEqual));
	OpenSettings.FormParameters = New Structure();
	If ValueIsFilled(Object.Partner) Then
		OpenSettings.FormParameters.Insert("Partner", Object.Partner);
		OpenSettings.FormParameters.Insert("FilterByPartnerHierarchy", True);
	EndIf;
	OpenSettings.FillingData = New Structure("Partner", Object.Partner);

	DocumentsClient.CompanyStartChoice(Object, Form, Item, ChoiceData, StandardProcessing, OpenSettings);
EndProcedure

Procedure LegalNameTextChange(Object, Form, Item, Text, StandardProcessing) Export
	ArrayOfFilters = New Array();
	ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True, ComparisonType.NotEqual));
	AdditionalParameters = New Structure();
	If ValueIsFilled(Object.Partner) Then
		AdditionalParameters.Insert("Partner", Object.Partner);
		AdditionalParameters.Insert("FilterByPartnerHierarchy", True);
	EndIf;
	DocumentsClient.CompanyEditTextChange(Object, Form, Item, Text, StandardProcessing, ArrayOfFilters,
		AdditionalParameters);
EndProcedure

#EndRegion

#Region ItemCompany

Procedure CompanyOnChange(Object, Form, Item, AddInfo = Undefined) Export
	ViewClient_V2.CompanyOnChange(Object, Form, "ItemList");
	
	//DocumentsClient.CompanyOnChange(Object, Form, ThisObject, Item, Undefined, AddInfo);
EndProcedure

//Procedure CompanyOnChangePutServerDataToAddInfo(Object, Form, AddInfo = Undefined) Export
//	DocumentsClient.CompanyOnChangePutServerDataToAddInfo(Object, Form, AddInfo);
//EndProcedure
//
//Function CompanySettings(Object, Form, AddInfo = Undefined) Export
//	If AddInfo = Undefined Then
//		Return New Structure("PutServerDataToAddInfo", True);
//	EndIf;
//
//	Settings = New Structure("Actions, ObjectAttributes, FormAttributes");
//	Actions = New Structure();
//	Actions.Insert("ChangeCurrency", "ChangeCurrency");
//	Settings.Insert("TableName", "ItemList");
//	Settings.Actions = Actions;
//	Settings.ObjectAttributes = "Company, Currency, PriceIncludeTax, Agreement";
//	Settings.FormAttributes = "Store, DeliveryDate, CurrentPriceType";
//	Return Settings;
//EndFunction

Procedure CompanyStartChoice(Object, Form, Item, ChoiceData, StandardProcessing) Export
	OpenSettings = DocumentsClient.GetOpenSettingsStructure();

	OpenSettings.ArrayOfFilters = New Array();
	OpenSettings.ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True,
		DataCompositionComparisonType.NotEqual));
	OpenSettings.ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("OurCompany", True,
		DataCompositionComparisonType.Equal));
	OpenSettings.FillingData = New Structure("OurCompany", True);

	DocumentsClient.CompanyStartChoice(Object, Form, Item, ChoiceData, StandardProcessing, OpenSettings);
EndProcedure

Procedure CompanyEditTextChange(Object, Form, Item, Text, StandardProcessing) Export
	ArrayOfFilters = New Array();
	ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True, ComparisonType.NotEqual));
	ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("OurCompany", True, ComparisonType.Equal));
	DocumentsClient.CompanyEditTextChange(Object, Form, Item, Text, StandardProcessing, ArrayOfFilters);
EndProcedure

#EndRegion

#Region StoreEvents

Procedure StoreOnChange(Object, Form, Item, AddInfo = Undefined) Export
	ViewClient_V2.StoreOnChange(Object, Form, "ItemList");
	//DocumentsClient.StoreOnChange(Object, Form, ThisObject, Item, Undefined, AddInfo);
EndProcedure

//Procedure StoreOnChangePutServerDataToAddInfo(Object, Form, AddInfo = Undefined) Export
//	DocumentsClient.StoreOnChangePutServerDataToAddInfo(Object, Form, AddInfo);
//EndProcedure
//
//Function StoreSettings(Object, Form, AddInfo = Undefined) Export
//	If AddInfo = Undefined Then
//		Return New Structure("PutServerDataToAddInfo", True);
//	EndIf;
//
//	Settings = New Structure("Actions, ObjectAttributes, FormAttributes");
//
//	Actions = New Structure();
//	Actions.Insert("UpdateStore", "UpdateStore");
//	Settings.Actions = Actions;
//	Settings.ObjectAttributes = "Company";
//	Settings.FormAttributes = "Store, CurrentPriceType";
//	Return Settings;
//EndFunction

#EndRegion

#Region PriceIncludeTaxEvents

Procedure PriceIncludeTaxOnChange(Object, Form, Item, AddInfo = Undefined) Export
	ViewClient_V2.PriceIncludeTaxOnChange(Object, Form);
	
	//DocumentsClient.PriceIncludeTaxOnChange(Object, Form, ThisObject, Item, Undefined, AddInfo);
EndProcedure

//Procedure PriceIncludeTaxOnChangePutServerDataToAddInfo(Object, Form, AddInfo = Undefined) Export
//	DocumentsClient.PriceIncludeTaxOnChangePutServerDataToAddInfo(Object, Form, AddInfo);
//EndProcedure
//
//Function PriceIncludeTaxSettings(Object, Form, AddInfo = Undefined) Export
//	If AddInfo = Undefined Then
//		Return New Structure("PutServerDataToAddInfo", True);
//	EndIf;
//
//	Return New Structure();
//EndFunction

#EndRegion

#Region ItemDate

Procedure DateOnChange(Object, Form, Item, AddInfo = Undefined) Export
	ViewClient_V2.DateOnChange(Object, Form, "ItemList");
	
	//DocumentsClient.DateOnChange(Object, Form, Thisobject, Item, Undefined, AddInfo);
EndProcedure

//Procedure DateOnChangePutServerDataToAddInfo(Object, Form, AddInfo = Undefined) Export
//	//DocumentsClient.DateOnChangePutServerDataToAddInfo(Object, Form, AddInfo);
//EndProcedure

//Function DateSettings(Object, Form, AddInfo = Undefined) Export
//	If AddInfo = Undefined Then
//		Return New Structure("PutServerDataToAddInfo", True);
//	EndIf;
//	ServerData = CommonFunctionsClientServer.GetFromAddInfo(AddInfo, "ServerData");
//
//	Settings = New Structure("Actions, ObjectAttributes, FormAttributes, AgreementType, AfterActionsCalculateSettings");
//
//	Actions = New Structure();
//	Actions.Insert("ChangeAgreement", "ChangeAgreement");
//	Actions.Insert("ChangeDeliveryDate", "ChangeDeliveryDate");
//	Actions.Insert("UpdatePaymentTerm", "UpdatePaymentTerm");
//
//	AfterActionsCalculateSettings = New Structure();
//	PriceDate = CalculationStringsClientServer.GetSliceLastDateByRefAndDate(Object.Ref, Object.Date);
//	AfterActionsCalculateSettings.Insert("UpdatePrice", New Structure("Period, PriceType", PriceDate,
//		Form.CurrentPriceType));
//
//	Settings.Insert("EmptyBasisDocument", New Structure("SalesOrder", ServerData.SalesOrder_EmptyRef));
//	Settings.Insert("TableName", "ItemList");
//	Settings.Actions = Actions;
//	Settings.ObjectAttributes = "Company, Currency, PriceIncludeTax, Agreement, LegalName, ManagerSegment";
//	Settings.FormAttributes   = "CurrentPriceType";
//	Settings.AgreementType    = ServerData.AgreementTypes_Customer;
//	Settings.AfterActionsCalculateSettings = AfterActionsCalculateSettings;
//
//	Return Settings;
//EndFunction

#EndRegion

#Region GroupTitleDecorationsEvents

Procedure DecorationGroupTitleCollapsedPictureClick(Object, Form, Item) Export
	DocumentsClientServer.ChangeTitleCollapse(Object, Form, True);
EndProcedure

Procedure DecorationGroupTitleCollapsedLabelClick(Object, Form, Item) Export
	DocumentsClientServer.ChangeTitleCollapse(Object, Form, True);
EndProcedure

Procedure DecorationGroupTitleUncollapsedPictureClick(Object, Form, Item) Export
	DocumentsClientServer.ChangeTitleCollapse(Object, Form, False);
EndProcedure

Procedure DecorationGroupTitleUncollapsedLabelClick(Object, Form, Item) Export
	DocumentsClientServer.ChangeTitleCollapse(Object, Form, False);
EndProcedure

#EndRegion

#Region PickUpItems
Procedure OpenPickupItems(Object, Form, Command) Export
	DocumentsClient.OpenPickupItems(Object, Form, Command);
EndProcedure

Procedure SearchByBarcode(Barcode, Object, Form) Export
	PriceType = Undefined;
	If ValueIsFilled(Object.Agreement) Then
		AgreementInfo = CatAgreementsServer.GetAgreementInfo(Object.Agreement);
		PriceType = AgreementInfo.PriceType;
	EndIf;
	DocumentsClient.SearchByBarcode(Barcode, Object, Form, , PriceType);
	//DocumentsClient.SearchByBarcode(Barcode, Object, Form, , Form.CurrentPriceType);
EndProcedure

#EndRegion