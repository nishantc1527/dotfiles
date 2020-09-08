"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class Utils {
    // get the file extension
    static getExtension(filename) {
        const extension = filename.split('.');
        if (extension.length === 0) {
            return '';
        }
        return extension[extension.length - 1].toLowerCase();
    }
}
exports.default = Utils;
//# sourceMappingURL=Utils.js.map