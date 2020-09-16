"use strict";
/**
 * @description A Visual Studio Code extension that opens HTML files in a browser of user's choice.
 * @author Igor Dimitrijević <igor.dvlpr@gmail.com>
 * @copyright Igor Dimitrijević, 2018.
 */
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
class Config {
    // reload the configuration
    static refresh() {
        this.current = vscode_1.workspace.getConfiguration('openInBrowser');
    }
    // check whether the specified key is present in the configuration
    static has(name) {
        return this.current.has(name);
    }
    // get the value of the specified key from the configuration
    static get(name) {
        return this.current.get(name);
    }
    // update the configuration
    static update(name, value, target = vscode_1.ConfigurationTarget.Global) {
        // update the configuration
        this.current.update(name, value, target);
        // force-refresh the configuration
        this.refresh();
    }
}
// configuration keys
Config.PickerLayout = 'pickerLayout';
// configuration values
Config.PickerCompactLayout = 'Compact';
Config.PickerFullLayout = 'Full';
// user configuration for Open in Browser
Config.current = vscode_1.workspace.getConfiguration('openInBrowser');
exports.default = Config;
//# sourceMappingURL=Config.js.map