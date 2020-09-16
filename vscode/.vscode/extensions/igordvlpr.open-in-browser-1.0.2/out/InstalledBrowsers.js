"use strict";
/**
 * @description A Visual Studio Code extension that opens HTML files in a browser of user's choice.
 * @author Igor Dimitrijević <igor.dvlpr@gmail.com>
 * @copyright Igor Dimitrijević, 2018.
 */
Object.defineProperty(exports, "__esModule", { value: true });
class InstalledBrowsers {
    get length() {
        const browsers = [
            this.chrome,
            this.chromium,
            this.firefox,
            this.ie,
            this.opera,
            this.safari
        ];
        return browsers.filter(Boolean).length;
    }
    hasAnyBrowser() {
        return this.length > 0;
    }
    constructor() {
        this.chrome = false;
        this.chromium = false;
        this.firefox = false;
        this.ie = false;
        this.opera = false;
        this.safari = false;
    }
}
exports.default = InstalledBrowsers;
//# sourceMappingURL=InstalledBrowsers.js.map