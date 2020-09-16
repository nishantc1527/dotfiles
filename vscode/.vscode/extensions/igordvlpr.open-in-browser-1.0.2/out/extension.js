"use strict";
/**
 * @description A Visual Studio Code extension that opens HTML files in a browser of user's choice.
 * @author Igor Dimitrijević <igor.dvlpr@gmail.com>
 * @copyright Igor Dimitrijević, 2018.
 */
Object.defineProperty(exports, "__esModule", { value: true });
const Config_1 = require("./Config");
const vscode_1 = require("vscode");
const browsers = require("./browsers");
const Utils_1 = require("./Utils");
// status bar item
let status;
// creates and displays the status bar item
function setUpStatusBar(context) {
    // create the status bar item aligned to the right
    status = vscode_1.window.createStatusBarItem(vscode_1.StatusBarAlignment.Right, 100);
    // add to the extension's subscriptions
    context.subscriptions.push(status);
}
// launches the file in the selected browser
function launchBrowser(browserName) {
    // get the active editor
    const editor = vscode_1.window.activeTextEditor;
    // if no editor is active, exit
    if (!editor) {
        return;
    }
    // get the filepath of the active file
    const filePath = editor.document.uri.fsPath;
    // if the filepath is an empty string, exit
    if (filePath.length === 0) {
        vscode_1.window.showInformationMessage('No active file.');
        return;
    }
    // get the extension of the active file
    const extension = Utils_1.default.getExtension(filePath);
    // check if the file/extension is a valid HTML file extension,
    // if not, exit
    if (extension !== 'html' && extension !== 'xhtml' && extension !== 'htm') {
        vscode_1.window.showInformationMessage('No active HTML file.');
        return;
    }
    // set the message that will be shown in the status bar
    status.text = 'Opening...';
    // show the message in the status bar
    status.show();
    // open the file in the selected browser
    browsers.openInBrowser(filePath, browserName);
    // hide the message in the status bar after 2s
    const timer = setTimeout(() => {
        status.hide();
        clearTimeout(timer);
    }, 2000);
}
//
function showBrowserPicker(callback) {
    // browser selection picker,
    // can be either string[] (compact layout),
    // or QuickPickItem[] (full layout)
    let picker;
    // force-refresh the config file to get the latest user preferences
    Config_1.default.refresh();
    // check the config for the layout of the picker
    if (Config_1.default.get(Config_1.default.PickerLayout) === Config_1.default.PickerCompactLayout) {
        picker = browsers.getCompactPicker();
    }
    else {
        picker = browsers.getFullPicker();
    }
    // show the browser selection picker
    vscode_1.window.showQuickPick(picker).then((option) => {
        let selected = '';
        // when the layout is compact, the type of the "option" argument is "string",
        if (typeof option === 'string') {
            // if the selected browser is an empty string,
            // or if the user selected "Cancel", exit
            selected = option;
        }
        else {
            // when the layout is full, the type of the "option" argument is "object"
            if (option['label']) {
                selected = option['label'];
            }
            else {
                selected = '';
            }
        }
        if (selected === '' || selected === 'Cancel') {
            callback(null);
        }
        else {
            callback(selected);
        }
    });
}
// show the UI for browser selection and launch the selected browser
function openFileCommand() {
    showBrowserPicker((selected) => {
        if (selected) {
            // launch the selected browser
            launchBrowser(selected);
        }
    });
}
// handles URL opening in the extension
function openUrlCommand() {
    vscode_1.window.showInputBox({
        value: 'http://',
        ignoreFocusOut: true,
        prompt: 'Enter a URL to open in a browser',
        placeHolder: 'Enter a URL...'
    }).then((value) => {
        showBrowserPicker((selected) => {
            if (selected) {
                browsers.openInBrowser(value, selected);
            }
        });
    });
}
// extension entry point
function activate(context) {
    // set up the status bar item,
    // for showing messages
    setUpStatusBar(context);
    let commandOpenFile = vscode_1.commands.registerCommand('extension.openFile', openFileCommand);
    let commandOpenUrl = vscode_1.commands.registerCommand('extension.openUrl', openUrlCommand);
    context.subscriptions.push(commandOpenFile);
    context.subscriptions.push(commandOpenUrl);
}
exports.activate = activate;
//# sourceMappingURL=extension.js.map