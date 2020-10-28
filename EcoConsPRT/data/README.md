#README ./data

In the top level of the JSON file there are 3 elements:

1. `Head` - this contains the questions to be asked on the page Header - these questions pertain to the entire study.
2. `Sections` - these are analagous to the model phases in our preregistration template, an correspond to tabsetPanels in the UI.
3. `Answers` - I *think* these contain the default input answers before the user fills them in.

Each element inside `Sections` is a tabsetPanel, and it has 2 elements:
- `Name`
- `Questions`

Where `Name` is the text to be displayed for that tabsetPanel title, i.e. phase name.

Each `Questions` is a list of length infinity, but each `Questions` element must contain 3 elements:

- `Type` corresponds to widget type, i.e. comments, radio
- `Label` corresponds to the text for the question to be displayed in the UI
- `AnswerType` corresponds to the different possible types of inputs requested of user in the third top-level element `Answers`.


Currently, the different `Answers` are:

- `YesNo` Yes, No, NA
- `BeforeExplain` 
- `AlltoNone` All, partially, none
- `YesExplain`
- `Explain`

I *think* the answers get fed into the widget as determined by `Type` in `Questions`