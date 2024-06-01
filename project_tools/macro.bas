REM  *****  BASIC  *****
' tested on Libreoffice Calc 7.5.1.2 (x86_64)  build:fcbaee479e84c6cd81291587d2ee68cba099e129 on Windows 10;
' It saves the current document and exports a csv copy to the same folder as the saved document;
' CSV delimters are ';' and text as "; on line: Propval(1).Value ="59,34,0,1,1"   'ASCII  59 = ;  34 = ";
' Name of file is the sheet name, this macro also exports all sheets you have on  the ods file.
'
' This macro is now Version 1.2! It exports to a parent folder + the given data folder name.
' See below where you can change the folder it exports to.
 
' This is the function which will return the parent folder of the document
Function GetParentFolder
    sUrl = ThisComponent.getURL()
    sParts = Split(sUrl, "/")
    'ReDim will preserve the array parts, so -2 means
    '-1 the document path, and -1 the document folder,
    'by that we get the parent folder.
    ReDim Preserve sParts(0 to UBound(sParts) - 2)
    GetParentFolder = Join(sParts, "/")
End Function
 
 
Sub Save_and_Export_CSV
    document = ThisComponent
    ThisComponent.Store
    GlobalScope.BasicLibraries.loadLibrary("Tools")
 
    FileDirectoryParent = GetParentFolder()
    DataFolder = "data/" 'This is the name of your data folder!
    ' If the folder doesn't exist it is going to create a new one.
 
    Sheets = document.Sheets
    NumSheets = Sheets.Count - 1
    Dim Propval(1) as New com.sun.star.beans.PropertyValue
    Propval(0).Name = "FilterName"
    Propval(0).Value = "Text - txt - csv (StarCalc)"
    Propval(1).Name = "FilterOptions"
    Propval(1).Value ="59,0,0,1,1"   'ASCII  59 = ;  34 = ";
    For I = 0 to NumSheets
        document.getCurrentController.setActiveSheet(Sheets(I))
        Filename = FileDirectoryParent + "/" + DataFolder + Sheets(I).Name + ".txt" 
        FileURL = convertToURL(Filename)
        document.StoreToURL(FileURL, Propval())
    Next I
End Sub
