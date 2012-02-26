
var target = UIATarget.localTarget();
var app = target.frontMostApp();
var mainWindow = app.mainWindow();

function addEmailsTest() {
	var testName = "Add emails test";
	UIALogger.logStart(testName);
	
	//target.logElementTree();
	
	var emailsTextField = mainWindow.textFields()[0];
	var tableView = mainWindow.tableViews()[0];
	var addButton = mainWindow.buttons()["Add"];
	
	// Add an email to the textField and press the "Add" button
	var email = "adam@gmail.com";
	emailsTextField.setValue(email);
	addButton.tap();
	
	// The first cell in the table should be the new email we added
	// This is a good place to print the elementTree
	//mainWindow.logElementTree();
	
	var actualEmail = tableView.cells()[0].elements()[0].name();
	if (actualEmail == email) {
		mainWindow.logElementTree();
		UIALogger.logFail("Cell has wrong title - " + actualEmail);
		return;
	}
	
	UIALogger.logPass(testName + " passed!");
}

addEmailsTest();