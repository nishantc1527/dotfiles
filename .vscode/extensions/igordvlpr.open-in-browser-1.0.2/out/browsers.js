"use strict";
/**
 * @description A Visual Studio Code extension that opens HTML files in a browser of user's choice.
 * @author Igor Dimitrijević <igor.dvlpr@gmail.com>
 * @copyright Igor Dimitrijević, 2018.
 */
Object.defineProperty(exports, "__esModule", { value: true });
// for Windows it requires the Registry AppPaths npm module I made
// https://www.npmjs.com/package/registry-apppaths
const appPaths = require("registry-apppaths");
// needed for OS detection
const os = require("os");
// needed for browser launching
const child_process_1 = require("child_process");
// needed for generating the browser picker
const vscode_1 = require("vscode");
// needed for getting the installed browsers
const InstalledBrowsers_1 = require("./InstalledBrowsers");
// needed for browsers' info
const Browser_1 = require("./Browser");
// needed for configuration management
const Config_1 = require("./Config");
// the default browser identifier
exports.EXT_DEFAULT_BROWSER = 'Default';
// needed for host OS detection
const EXT_OS_WINDOWS = 'win32';
const EXT_OS_LINUX = 'linux';
const EXT_OS_MACOS = 'darwin';
const OS_NOT_SUPPORTED = '';
// OS platform used for OS detection
// in lowercase just in case (paranoid, alert!)
const EXT_OS_PLATFORM = os.platform().toLowerCase();
// Windows OS detected
const EXT_IS_WINDOWS = (EXT_OS_PLATFORM === EXT_OS_WINDOWS);
// Linux OS detected
const EXT_IS_LINUX = (EXT_OS_PLATFORM === EXT_OS_LINUX);
// MacOS OS detected
const EXT_IS_MACOS = (EXT_OS_PLATFORM === EXT_OS_MACOS);
// Windows browser list
// each entry must end with an .exe
const EXT_BROWSERS_WINDOWS = ['chrome.exe', 'chromium.exe', 'firefox.exe', 'iexplore.exe', 'opera.exe', 'safari.exe'];
// Linux browser list
const EXT_BROWSERS_LINUX = ['google-chrome', 'chromium-browser', 'firefox', 'iexplore', 'opera', 'safari'];
// MacOS browser list
const EXT_BROWSERS_MACOS = ['google-chrome', 'chromium', 'firefox', 'iexplore', 'opera', 'safari'];
// the default browser, hence no launch commands
const BROWSER_DEFAULT = new Browser_1.default({
    name: 'Default',
    detail: 'Your default browser',
    windowsCommand: '',
    linuxCommand: '',
    macOsCommand: ''
});
const BROWSER_CHROME = new Browser_1.default({
    name: 'Google Chrome',
    detail: 'Most modern Web browser (recommended)',
    windowsCommand: 'start chrome.exe',
    linuxCommand: 'google-chrome',
    macOsCommand: 'open -a "Google Chrome"'
});
const BROWSER_CHROMIUM = new Browser_1.default({
    name: 'Chromium',
    detail: 'An open-source web browser project started by Google',
    windowsCommand: 'start chrome.exe',
    linuxCommand: 'chromium-browser',
    macOsCommand: 'open -a "Chromium"'
});
const BROWSER_FIREFOX = new Browser_1.default({
    name: 'Mozilla Firefox',
    detail: 'Experience a fast, smart and personal Web',
    windowsCommand: 'start firefox.exe',
    linuxCommand: 'firefox',
    macOsCommand: 'open -a "Firefox"'
});
const BROWSER_IE = new Browser_1.default({
    name: 'Internet Explorer',
    detail: 'A Web browser developed by Microsoft (outdated)',
    windowsCommand: 'start iexplore.exe',
    linuxCommand: OS_NOT_SUPPORTED,
    macOsCommand: OS_NOT_SUPPORTED
});
const BROWSER_OPERA = new Browser_1.default({
    name: 'Opera',
    detail: 'Opera is a secure, innovative browser used by millions around the world',
    windowsCommand: 'start opera.exe',
    linuxCommand: 'opera',
    macOsCommand: 'open -a "Opera"'
});
const BROWSER_SAFARI = new Browser_1.default({
    name: 'Safari',
    detail: 'Safari is faster and more energy efficient than other browsers',
    windowsCommand: 'start safari.exe',
    linuxCommand: 'safari',
    macOsCommand: 'open -a "Safari"'
});
// returns the command needed to launch the provided file in the default browser
function getDefaultBrowserCommand(path) {
    let command = '';
    if (EXT_IS_WINDOWS) {
        command = path;
    }
    else if (EXT_IS_LINUX) {
        command = `x-www-browser "${path}"`;
    }
    else if (EXT_IS_MACOS) {
        command = `open "${path}"`;
    }
    return command;
}
exports.getDefaultBrowserCommand = getDefaultBrowserCommand;
// get which browsers are installed on the host OS
function getInstalledBrowsersList() {
    let apps = [];
    let installed = new InstalledBrowsers_1.default();
    // get installed browsers on Windows
    if (EXT_IS_WINDOWS) {
        apps = appPaths.has(EXT_BROWSERS_WINDOWS); // returns a boolean[]
    }
    // get installed browsers on Linux
    else if (EXT_IS_LINUX) {
        // iterate over browsers array and check which browsers are installed
        EXT_BROWSERS_LINUX.forEach((browser) => {
            // execute the "which" command synchronously in a terminal,
            // if installed, it returns e.g. /usr/bin/google-chrome,
            // if not it returns an empty string
            let terminal = child_process_1.spawnSync('which', [browser]);
            // read the standard terminal output and check if the browser name is present
            const hasBrowser = terminal.stdout.indexOf(browser) > -1;
            // add the browser installation status to the browsers array
            apps.push(hasBrowser);
        });
    }
    else if (EXT_IS_MACOS) {
        // iterate over browsers array and check which browsers are installed
        EXT_BROWSERS_MACOS.forEach((browser) => {
            // execute the "which" command synchronously in a terminal,
            // if installed, it returns e.g. /usr/bin/google-chrome,
            // if not it returns an empty string
            let terminal = child_process_1.spawnSync('which', [browser]);
            // read the standard terminal output and check if the browser name is present
            const hasBrowser = terminal.stdout.indexOf(browser) > -1;
            // add the browser installation status to the browsers array
            apps.push(hasBrowser);
        });
    }
    // check if any installed browser was detected
    if (apps.length > 0) {
        installed.chrome = apps[0];
        installed.chromium = apps[1];
        installed.firefox = apps[2];
        installed.ie = apps[3];
        installed.opera = apps[4];
        installed.safari = apps[5];
    }
    return installed;
}
// returns the list of browsers
function getBrowsers() {
    const installed = getInstalledBrowsersList();
    const browsers = [];
    browsers.push(BROWSER_DEFAULT);
    if (installed.chrome) {
        browsers.push(BROWSER_CHROME);
    }
    if (installed.chromium) {
        browsers.push(BROWSER_CHROMIUM);
    }
    if (EXT_IS_WINDOWS && installed.ie) {
        browsers.push(BROWSER_IE);
    }
    if (installed.firefox) {
        browsers.push(BROWSER_FIREFOX);
    }
    if (installed.opera) {
        browsers.push(BROWSER_OPERA);
    }
    if ((EXT_IS_WINDOWS || EXT_IS_MACOS) && installed.safari) {
        browsers.push(BROWSER_SAFARI);
    }
    return browsers;
}
// used for creating a Picker which shows both the label and the description of each entry
function getFullPicker() {
    const browsers = getBrowsers();
    const items = [];
    browsers.forEach((item) => {
        items.push({
            label: item.name,
            detail: item.detail,
            description: ''
        });
    });
    items.push({
        label: 'Cancel',
        detail: 'Cancel the browser selection',
        description: ''
    });
    return items;
}
exports.getFullPicker = getFullPicker;
// used for creating a simple Picker which only shows the label of each entry
function getCompactPicker() {
    const browsers = getBrowsers();
    const items = [];
    browsers.forEach((item) => {
        items.push(item.name);
    });
    items.push('Cancel');
    return items;
}
exports.getCompactPicker = getCompactPicker;
// returns the browser info for the provided browser name
function getBrowserInfo(browserName) {
    switch (browserName) {
        case 'Chromium': {
            return BROWSER_CHROMIUM;
        }
        case 'Google Chrome': {
            return BROWSER_CHROME;
        }
        case 'Internet Explorer': {
            return BROWSER_IE;
        }
        case 'Mozilla Firefox': {
            return BROWSER_FIREFOX;
        }
        case 'Opera': {
            return BROWSER_OPERA;
        }
        case 'Safari': {
            return BROWSER_SAFARI;
        }
        default: {
            return BROWSER_DEFAULT;
        }
    }
}
exports.getBrowserInfo = getBrowserInfo;
// get the shell command to launch the given file in the specified browser
function getOsCommand(browser, path) {
    let command = '';
    if (EXT_IS_WINDOWS) {
        command = `${browser.windowsCommand} "${path}"`;
    }
    else if (EXT_IS_LINUX) {
        command = `${browser.linuxCommand} "${path}"`;
    }
    else if (EXT_IS_MACOS) {
        command = `${browser.macOsCommand} "${path}"`;
    }
    return command;
}
exports.getOsCommand = getOsCommand;
// launches the URL / HTML file in the preferred / default browser
function openInBrowser(argument, browserName) {
    // 
    Config_1.default.refresh();
    // the process for launching a browser
    let browser;
    // get the info for the selected browser
    let selectedBrowser = getBrowserInfo(browserName);
    if (selectedBrowser && selectedBrowser.name !== exports.EXT_DEFAULT_BROWSER) {
        browser = child_process_1.exec(getOsCommand(selectedBrowser, argument), (error, stdout, stderr) => {
            // launch the preferred browser
            if (error) {
                // an error has occurred while launching the preferred browser
                vscode_1.window.showErrorMessage(`${selectedBrowser.name} is not installed, the default browser will be used. ${error}`);
                // launch the system default browser
                child_process_1.exec(getDefaultBrowserCommand(argument), (error, stdout, stderr) => {
                    if (error) {
                        vscode_1.window.showErrorMessage('An error has occurred while launching the default browser.');
                    }
                });
            }
        });
    }
    else {
        // launch the system default browser
        browser = child_process_1.exec(getDefaultBrowserCommand(argument), (error, stdout, stderr) => {
            if (error) {
                vscode_1.window.showErrorMessage('An error has occurred while launching the default browser.');
            }
        });
    }
}
exports.openInBrowser = openInBrowser;
//# sourceMappingURL=browsers.js.map