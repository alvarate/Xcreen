
1. Unpack TntUnicodeControls.v2.2.8.rar to C:\Program Files\TntUnicodeControls.v2.2.8

2. Open "C:\Program Files\TntUnicodeControls.v2.2.8\Delphi\d7\TntUnicodeVcl_R70.dpk". Click the "Compile" button in the Package view, then click the "Install" button

3. Open ""C:\Program Files\TntUnicodeControls.v2.2.8\Delphi\d7\TntUnicodeVcl_D70.dpk". Click the "Compile" button in the Package view, then click the "Install" button

4. Open Delphi 7 IDE. Click "Project"->"Options" ->"Directories/Conditionals", add the following item to the "Search path":
       C:\Program Files\TntUnicodeControls.v2.2.8\Source

5. Open Delphi 7  IDE. Click "Project"->"Options" ->"Directories/Conditionals", add UNICODE in the "Conditional defines" textbox

6. Define strings in your application using TCHAR and TEXT, for sample: TCHAR   szText[]=TEXT("Unicode   String");   




   