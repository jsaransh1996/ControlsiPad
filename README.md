# ControlsiPad
1. Open Controls.xcodeproj
2. Select any iPad Simulator
3. Run the application

## Scenarios Completed
- Loading sample.txt from Bundle and coypying in Document Directory
- JSON to model and model to JSON conversion
- Edit and Read mode for Detail Screen
- UI as per given images
- Master Row Selection => Detail Scrolls to same section
- Duplicate Keys not allowed
- Displaying error message
- Save JSON to document Directory for future retrivals
- Tested for multiple sample.txt

## Scenarios Not Handled
- Non pressable keys handling

## Best view
iPad with Landscape Mode

## 3rd Parties Used
- none

## Usage
To Edit Buttons: Press on Edit button on top right corner. Then click on any of the text field, and try to enter any key. Keyboard will dismiss either by updating or by showing you error.

## Techincals
- Step 1: sample.txt is copied to document directory, if not found in document directory.
- Step 2: content is loaded from document directory.
- Step 3: JSON is parsed and converted to Models
- Step 3: UI is rendered according to this Models
- Step 4: On Editing, validation check is implemented to check for Duplicates.
- Step 5: On Done, model is converted back to JSON and saved in the Document Directory
- Step 6: On new launch of application, content are now loaded from last saved document directory file.
