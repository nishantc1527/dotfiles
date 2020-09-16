"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const child_process_1 = require("child_process");
const configuration_1 = require("./features/utils/configuration");
const common_1 = require("./common");
class Python {
    constructor(logger) {
        this.logger = logger;
        this.version = null;
        this.ready = false;
    }
    isReady() {
        return this.ready;
    }
    async setup(resource) {
        if (await this.checkPython(resource)) {
            await this.checkPreviewEngine(resource, false);
            await this.checkLinter(resource, true, false);
            this.ready = true;
        }
    }
    async checkPython(resource, showInformation = true) {
        const path = configuration_1.Configuration.getPythonPath(resource);
        if (path) {
            this.pythonPath = `"${path}"`;
            if (await this.getVersion()) {
                return true;
            }
        }
        this.logger.log("Cannot find Python.");
        if (showInformation) {
            var choice = await vscode.window.showErrorMessage("Please review Python installation on this machine before using this extension.", "Learn more...");
            if (choice === "Learn more...") {
                vscode.commands.executeCommand('vscode.open', vscode.Uri.parse('https://docs.restructuredtext.net/articles/prerequisites.html#install-python-for-most-features'));
            }
        }
        return false;
    }
    async checkPreviewEngine(resource, showWarning = true) {
        if (configuration_1.Configuration.getConfPath(resource) === '') {
            if (configuration_1.Configuration.getDocUtilDisabled()) {
                if (showWarning) {
                    await vscode.window.showWarningMessage("No preview. Preview engine docutil is disabled.");
                }
                return false;
            }
            if (!(await this.checkDocutilsInstall())) {
                var choice = await vscode.window.showInformationMessage("Preview engine docutil is not installed.", "Install", "Not now", "Do not show again");
                if (choice === "Install") {
                    this.logger.log("Started to install docutils...");
                    await this.installDocUtils();
                }
                else if (choice === "Do not show again") {
                    this.logger.log("Disabled docutil engine.");
                    await configuration_1.Configuration.setDocUtilDisabled();
                    if (showWarning) {
                        await vscode.window.showWarningMessage("No preview. Preview engine docutil is now disabled.");
                    }
                    return false;
                }
                else {
                    if (showWarning) {
                        await vscode.window.showWarningMessage("No preview. Preview engine docutil is not installed.");
                    }
                    return false;
                }
            }
        }
        else {
            const sphinx = configuration_1.Configuration.getSphinxPath(resource);
            if (configuration_1.Configuration.getSphinxDisabled()) {
                if (showWarning) {
                    await vscode.window.showWarningMessage("No preview. Preview engine sphinx is disabled.");
                }
                return false;
            }
            if (!(await this.checkSphinxInstall() || (sphinx != null && await common_1.fileExists(sphinx)))) {
                var choice = await vscode.window.showInformationMessage("Preview engine sphinx is not installed.", "Install", "Not now", "Do not show again");
                if (choice === "Install") {
                    this.logger.log("Started to install sphinx...");
                    await this.installSphinx();
                }
                else if (choice === "Do not show again") {
                    this.logger.log("Disabled sphinx engine.");
                    await configuration_1.Configuration.setSphinxDisabled();
                    if (showWarning) {
                        await vscode.window.showWarningMessage("No preview. Preview engine sphinx is now disabled.");
                    }
                    return false;
                }
                else {
                    if (showWarning) {
                        await vscode.window.showWarningMessage("No preview. Preview engine sphinx is not installed.");
                    }
                    return false;
                }
            }
        }
        return true;
    }
    async checkLinter(resource, showInformation = true, showWarning = true) {
        if (configuration_1.Configuration.getLinterDisabled()) {
            if (showWarning) {
                vscode.window.showWarningMessage("No linting. Linter is disabled.");
            }
            return false;
        }
        if (configuration_1.Configuration.getLinterName(resource) === "doc8") {
            const doc8 = configuration_1.Configuration.getLinterPath(resource);
            if (!(await this.checkDoc8Install() || (doc8 != null && await common_1.fileExists(doc8)))) {
                if (showInformation) {
                    var choice = await vscode.window.showInformationMessage("Linter doc8 is not installed.", "Install", "Not now", "Do not show again");
                    if (choice === "Install") {
                        this.logger.log("Started to install doc8...");
                        await this.installDoc8();
                    }
                    else if (choice === "Do not show again") {
                        this.logger.log("Disabled linter.");
                        await configuration_1.Configuration.setLinterDisabled();
                        vscode.window.showWarningMessage("No linting. Linter is now disabled.");
                        return false;
                    }
                    else {
                        vscode.window.showWarningMessage("No linting. Linter doc8 is not installed.");
                        return false;
                    }
                }
                else {
                    return false;
                }
            }
        }
        else if (configuration_1.Configuration.getLinterName(resource) === "rstcheck") {
            const rstcheck = configuration_1.Configuration.getLinterPath(resource);
            if (!(await this.checkRstCheckInstall() || (rstcheck != null && await common_1.fileExists(rstcheck)))) {
                if (showInformation) {
                    var choice = await vscode.window.showInformationMessage("Linter rstcheck is not installed.", "Install", "Not now", "Do not show again");
                    if (choice === "Install") {
                        this.logger.log("Started to install rstcheck...");
                        await this.installRstCheck();
                    }
                    else if (choice === "Do not show again") {
                        this.logger.log("Disabled linter.");
                        await configuration_1.Configuration.setLinterDisabled();
                        vscode.window.showWarningMessage("No linting. Linter is now disabled.");
                        return false;
                    }
                    else {
                        vscode.window.showWarningMessage("No linting. Linter rstcheck is not installed.");
                        return false;
                    }
                }
                else {
                    return false;
                }
            }
        }
        return true;
    }
    async installDocUtils() {
        try {
            await this.exec("-m", "pip", "install", "docutils");
            this.logger.log("Finished installing docutils");
        }
        catch (e) {
            this.logger.log("Failed to install docutils");
            vscode.window.showErrorMessage("Could not install docutils. Please run `pip install docutils` to use this " +
                "extension, or check your Python path.");
        }
    }
    async checkDocutilsInstall() {
        try {
            await this.exec("-c", '"import docutils;"');
            return true;
        }
        catch (e) {
            return false;
        }
    }
    async installDoc8() {
        try {
            await this.exec("-m", "pip", "install", "doc8");
            this.logger.log("Finished installing doc8");
        }
        catch (e) {
            this.logger.log("Failed to install doc8");
            vscode.window.showErrorMessage("Could not install doc8. Please run `pip install doc8` to use this " +
                "extension, or check your Python path.");
        }
    }
    async checkDoc8Install() {
        try {
            await this.exec("-c", '"import doc8.main;"');
            return true;
        }
        catch (e) {
            return false;
        }
    }
    async installRstCheck() {
        try {
            await this.exec("-m", "pip", "install", "rstcheck");
            this.logger.log("Finished installing rstcheck");
        }
        catch (e) {
            this.logger.log("Failed to install rstcheck");
            vscode.window.showErrorMessage("Could not install rstcheck. Please run `pip install rstcheck` to use this " +
                "extension, or check your Python path.");
        }
    }
    async checkRstCheckInstall() {
        try {
            await this.exec("-c", '"import rstcheck;"');
            return true;
        }
        catch (e) {
            return false;
        }
    }
    async installSphinx() {
        try {
            await this.exec("-m", "pip", "install", "sphinx", "sphinx-autobuild");
            this.logger.log("Finished installing sphinx");
        }
        catch (e) {
            this.logger.log("Failed to install sphinx");
            vscode.window.showErrorMessage("Could not install sphinx. Please run `pip install sphinx sphinx-autobuild` to use this " +
                "extension, or check your Python path.");
        }
    }
    async checkSphinxInstall() {
        try {
            await this.exec("-c", '"import sphinx;"');
            return true;
        }
        catch (e) {
            return false;
        }
    }
    async getVersion() {
        if (this.version !== null) {
            return true;
        }
        try {
            const version = await this.exec("-c", '"import sys; print(sys.version_info[0])"');
            switch (Number.parseInt(version)) {
                case 2:
                    this.version = 2;
                    return true;
                case 3:
                    this.version = 3;
                    return true;
            }
        }
        catch (e) { }
        return false;
    }
    exec(...args) {
        const cmd = [this.pythonPath, ...args];
        return new Promise((resolve, reject) => {
            this.logger.log(`Running cmd: ${this.pythonPath} ${args.join(" ")}`);
            child_process_1.exec(cmd.join(" "), (error, stdout, stderr) => {
                if (error) {
                    let errorMessage = [
                        error.name,
                        error.message,
                        error.stack,
                        "",
                        stderr.toString()
                    ].join("\n");
                    this.logger.log(errorMessage);
                    reject(errorMessage);
                }
                else {
                    this.logger.log("Successful exec");
                    resolve(stdout.toString());
                }
            });
        });
    }
}
exports.Python = Python;
//# sourceMappingURL=python.js.map