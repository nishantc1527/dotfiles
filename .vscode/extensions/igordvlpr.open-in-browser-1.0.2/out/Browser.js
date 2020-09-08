"use strict";
/**
 * @description A Visual Studio Code extension that opens HTML files in a browser of user's choice.
 * @author Igor Dimitrijević <igor.dvlpr@gmail.com>
 * @copyright Igor Dimitrijević, 2018.
 */
Object.defineProperty(exports, "__esModule", { value: true });
class Browser {
    constructor(options) {
        // browser name
        this.name = '';
        // browser description, shown as details in the browser picker
        // available only when the LayoutPicker == Full
        this.detail = '';
        // command to launch the browser on Windows
        this.windowsCommand = '';
        // command to launch the browser on Linux
        this.linuxCommand = '';
        // command to launch the browser on MacOS
        this.macOsCommand = '';
        this.name = options.name || '';
        this.detail = options.detail || '';
        this.windowsCommand = options.windowsCommand || '';
        this.linuxCommand = options.linuxCommand || '';
        this.macOsCommand = options.macOsCommand || '';
    }
}
exports.default = Browser;
//# sourceMappingURL=Browser.js.map