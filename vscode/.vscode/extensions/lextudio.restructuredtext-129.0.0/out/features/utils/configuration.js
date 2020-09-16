'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const fs = require("fs");
const path = require("path");
class Configuration {
    static getConflictingExtensions(resource = null) {
        return Configuration.loadAnySetting('conflictingExtensions', null, resource);
    }
    static getDocutilsWriter(resource = null) {
        return Configuration.loadSetting('docutilsWriter', 'html', resource);
    }
    static getDocutilsWriterPart(resource = null) {
        return Configuration.loadSetting('docutilsWriterPart', 'html_body', resource);
    }
    static getSphinxPath(resource = null) {
        return Configuration.loadSetting('sphinxBuildPath', null, resource);
    }
    static getConfPath(resource = null) {
        return Configuration.loadSetting('confPath', null, resource);
    }
    static getOutputFolder(resource = null) {
        return Configuration.loadSetting('builtDocumentationPath', null, resource);
    }
    static getPreviewName(resource = null) {
        return Configuration.loadSetting("preview.name", "sphinx", resource);
    }
    static getLinterName(resource = null) {
        return Configuration.loadSetting("linter.name", "rstcheck", resource);
    }
    static getLinterPath(resource = null) {
        return Configuration.loadSetting('linter.executablePath', null, resource);
    }
    static getExtraArgs(resource = null) {
        return Configuration.loadAnySetting('linter.extraArgs', null, resource);
    }
    static getRunType(resource = null) {
        return Configuration.loadAnySetting('linter.run', 'onType', resource);
    }
    static getPythonPath(resource = null) {
        // IMPORTANT: python3 does not work, so the default comes from Python extension.
        const primary = Configuration.loadSetting('pythonPath', 'python3', resource, true, 'python');
        // assume pythonPath is relative to workspace root.
        if (primary) {
            const workspaceRoot = Configuration.GetRootPath(resource);
            if (workspaceRoot) {
                const optional = path.join(workspaceRoot, primary);
                if (fs.existsSync(optional)) {
                    return optional;
                }
            }
        }
        return primary;
    }
    static getLinterDisabled(resource = null) {
        return Configuration.loadAnySetting('linter.disabled', true, null);
    }
    static getSphinxDisabled(resource = null) {
        return Configuration.loadAnySetting('preview.sphinx.disabled', true, null);
    }
    static getDocUtilDisabled(resource = null) {
        return Configuration.loadAnySetting('preview.docutil.disabled', true, null);
    }
    static getLanguageServerDisabled(resource = null) {
        return Configuration.loadAnySetting('languageServer.disabled', true, null);
    }
    static getSupportedPlatforms(resource = null) {
        return Configuration.loadAnySetting("languageServer.supportedPlatforms", [], null);
    }
    static getUpdateDelay(resource = null) {
        return Configuration.loadAnySetting("updateDelay", 3000, resource);
    }
    static async setConfPath(value, resource = null, insertMacro) {
        return await Configuration.saveSetting('confPath', value, resource, insertMacro);
    }
    static async setLinterDisabled(resource = null) {
        await Configuration.saveAnySetting('linter.disabled', true, resource);
    }
    static async setSphinxDisabled(resource = null) {
        await Configuration.saveAnySetting('preview.sphinx.disabled', true, resource);
    }
    static async setDocUtilDisabled(resource = null) {
        await Configuration.saveAnySetting('preview.docutil.disabled', true, resource);
    }
    static loadAnySetting(configSection, defaultValue, resource, header = 'restructuredtext') {
        return vscode_1.workspace.getConfiguration(header, resource).get(configSection, defaultValue);
    }
    static async saveAnySetting(configSection, value, resource, header = 'restructuredtext') {
        await vscode_1.workspace.getConfiguration(header, resource).update(configSection, value);
        return value;
    }
    static loadSetting(configSection, defaultValue, resource, expand = true, header = 'restructuredtext') {
        const result = this.loadAnySetting(configSection, defaultValue, resource, header);
        if (expand && result != null) {
            return this.expandMacro(result, resource);
        }
        return result;
    }
    static async saveSetting(configSection, value, resource, insertMacro = false, header = 'restructuredtext') {
        if (insertMacro) {
            value = this.insertMacro(value, resource);
        }
        return await this.saveAnySetting(configSection, value, resource, header);
    }
    static insertMacro(input, resource) {
        if (resource == null) {
            return input;
        }
        let path;
        if (!vscode_1.workspace.workspaceFolders) {
            path = vscode_1.workspace.rootPath;
        }
        else {
            let root;
            if (vscode_1.workspace.workspaceFolders.length === 1) {
                root = vscode_1.workspace.workspaceFolders[0];
            }
            else {
                root = vscode_1.workspace.getWorkspaceFolder(resource);
            }
            path = root.uri.fsPath;
        }
        if (input.startsWith(path)) {
            return input
                .replace(path, '${workspaceFolder}');
        }
        return input;
    }
    static expandMacro(input, resource) {
        if (input.indexOf('${') === -1) {
            return input;
        }
        let expanded;
        if (input.indexOf('${env:') > -1) {
            expanded = input.replace(/\$\{env\:(.+)\}/, (match, p1) => {
                const variable = process.env[p1];
                return variable == null ? '' : variable;
            });
        }
        else {
            expanded = input;
        }
        if (expanded.indexOf('${') > -1) {
            const path = this.GetRootPath(resource);
            if (path) {
                return expanded
                    .replace('${workspaceRoot}', path)
                    .replace('${workspaceFolder}', path);
            }
        }
        return expanded;
    }
    static GetRootPath(resource) {
        if (!vscode_1.workspace.workspaceFolders) {
            return vscode_1.workspace.rootPath;
        }
        let root;
        if (vscode_1.workspace.workspaceFolders.length === 1) {
            root = vscode_1.workspace.workspaceFolders[0];
        }
        else {
            if (resource == null) {
                return undefined;
            }
            root = vscode_1.workspace.getWorkspaceFolder(resource);
        }
        if (root) {
            return root.uri.fsPath;
        }
        return undefined;
    }
}
exports.Configuration = Configuration;
//# sourceMappingURL=configuration.js.map