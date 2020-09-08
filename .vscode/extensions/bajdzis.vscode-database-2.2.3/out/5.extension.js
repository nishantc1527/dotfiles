exports.ids = [5];
exports.modules = {

/***/ 40:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "a", function() { return AbstractServer; });
/* harmony import */ var vscode__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(0);
/* harmony import */ var vscode__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(vscode__WEBPACK_IMPORTED_MODULE_0__);

class AbstractServer {
    constructor() {
        this.type = this.typeName;
        this.fieldsToConnect = [];
        this.currentDatabase = null;
        this.OutputChannel = null;
    }
    /**
     * @return {string} - name server
     */
    getName() {
        if (this.name) {
            return this.name;
        }
        return `${this.username}@${this.host} (${this.typeName})`;
    }
    /**
     * @param {OutputChannel} OutputChannel - VS Code Output Channel
     */
    setOutput(OutputChannel) {
        this.OutputChannel = OutputChannel;
    }
    /**
     * @param {string} msg - text message to show
     */
    outputMsg(msg) {
        if (this.OutputChannel !== null) {
            this.OutputChannel.appendLine(msg);
        }
    }
    /**
     * @return {Promise<object>} - object with some data to save
     */
    getDataToRestore() {
        return vscode__WEBPACK_IMPORTED_MODULE_0__["window"].showQuickPick([
            { label: 'Yes' },
            { label: 'No' }
        ], {
            matchOnDescription: false,
            placeHolder: 'Save password in setting? (plain text)'
        }).then((output) => {
            const data = {
                type: this.type,
                name: this.getName(),
                host: this.host + ':' + this.port,
                username: this.username,
                database: this.currentDatabase,
            };
            if (output && output.label === 'Yes') {
                data.password = this.password;
            }
            return data;
        });
    }
    /**
     * @param {object} fields - result getDataToRestore() function
     * @return {Promise}
     */
    restoreConnection(fields) {
        if (!fields.username) {
            fields.username = fields.user;
        }
        if (fields.password === undefined) {
            return new Promise((resolve) => {
                vscode__WEBPACK_IMPORTED_MODULE_0__["window"].showInputBox({ value: '', prompt: fields.name, placeHolder: 'Password', password: true })
                    .then((password) => {
                    fields.password = password;
                    this.connectPromise(fields).then(resolve);
                });
            });
        }
        return this.connectPromise(fields);
    }
    /**
     * @param {object} fields - object with fields from *.prototype.fieldsToConnect
     * @return {Promise}
     */
    // eslint-disable-next-line no-unused-vars
    connectPromise(fields) {
        return Promise.reject('No implement connectPromise');
    }
    /**
     * @param {string} sql - query
     * @return {Promise}
     */
    // eslint-disable-next-line no-unused-vars
    queryPromise(sql, params) {
        return Promise.reject('No implement queryPromise');
    }
    // eslint-disable-next-line no-unused-vars
    changeDatabase(name) {
        return Promise.reject('No implement changeDatabase');
    }
    /**
     * @param {string} sql - queries separate ;
     * @return {string[]}
     */
    splitQueries(sqlMulti) {
        const quotes = /^((?:[^"`']*?(?:(?:"(?:[^"]|\\")*?(?<!\\)")|(?:'(?:[^']|\\')*?(?<!\\)')|(?:`(?:[^`]|\\`)*?(?<!\\)`)))*?[^"`']*?)/;
        const queries = [], delimiter = ';';
        let match = [];
        const splitRegex = new RegExp(quotes.source + delimiter);
        while ((match = sqlMulti.match(splitRegex)) !== null) {
            queries.push(match[1]); //push the split query into the queries array
            sqlMulti = sqlMulti.slice(match[1].length + delimiter.length); //remove split query from sql string
        }
        queries.push(sqlMulti); //push last query which could have no delimiter
        //remove empty queries
        return queries.filter((sql) => {
            if (!sql) {
                return false;
            }
            const notEmpty = (sql.trim().replace(/(\r\n|\n|\r)/gm, '') !== '');
            return notEmpty ? true : false;
        });
    }
    /**
     * @param {string} sql - a SQL string
     * @return {string} - the SQL string without comments
     */
    removeComments(sql) {
        const quotes = /^((?:[^"`']*?(?:(?:"(?:[^"]|\\")*?(?<!\\)")|(?:'(?:[^']|\\')*?(?<!\\)')|(?:`(?:[^`]|\\`)*?(?<!\\)`)))*?[^"`']*?)/;
        const cStyleComments = new RegExp(quotes.source + '/\\*.*?\\*/');
        const doubleDashComments = new RegExp(quotes.source + '--.*(\r\n|\n|\r)?');
        while (sql.match(cStyleComments))
            sql = sql.replace(cStyleComments, '$1');
        while (sql.match(doubleDashComments))
            sql = sql.replace(doubleDashComments, '$1$2');
        return sql;
    }
    /**
     * @param {object} currentStructure - save new structure to this params
     */
    // eslint-disable-next-line no-unused-vars
    refrestStructureDataBase(currentStructure) {
        return Promise.resolve({});
    }
    /**
     * @return {Promise<string[], Error|string>}
     */
    getDatabase() {
        return Promise.resolve([]);
    }
    /**
     * @param {string} tableName
     * @return {string} a quoted identifier table name
     */
    getIdentifiedTableName(tableName) {
        return tableName;
    }
    /**
     * @param {string} tableName
     * @return {string} a SQL SELECT statement
     */
    getSelectTableSql(tableName, limit = 50) {
        return `SELECT * FROM ${this.getIdentifiedTableName(tableName)} LIMIT ${limit}`;
    }
}
AbstractServer.prototype.typeName = 'Unknow';
AbstractServer.prototype.fieldsToConnect = [];


/***/ }),

/***/ 56:
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "MySQLType", function() { return MySQLType; });
/* harmony import */ var vscode__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(0);
/* harmony import */ var vscode__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(vscode__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _AbstractServer__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(40);
/* harmony import */ var mysql__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(46);
/* harmony import */ var mysql__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(mysql__WEBPACK_IMPORTED_MODULE_2__);



class MySQLType extends _AbstractServer__WEBPACK_IMPORTED_MODULE_1__[/* AbstractServer */ "a"] {
    constructor() {
        super();
        this.type = 'mysql';
        this.host = 'Empty';
        this.port = '3306';
        this.username = 'Empty';
        this.password = 'Empty';
        this.socket = '';
    }
    /**
     * @param {object} fields
     * @return {Promise}
     */
    connectPromise({ host, username, password, socket, insecureAuth }) {
        const [hostName, port = '3306'] = host.split(':');
        this.host = hostName;
        this.port = port;
        this.username = username;
        this.password = password;
        const setting = {
            host: this.host,
            port: parseInt(port, 10),
            user: username,
            password: password,
            insecureAuth: insecureAuth
        };
        if (socket) {
            this.socket = hostName;
            setting.socketPath = this.host;
            delete setting.host;
            delete setting.port;
        }
        return new Promise((resolve, reject) => {
            this.connection = Object(mysql__WEBPACK_IMPORTED_MODULE_2__["createConnection"])(setting);
            this.connection.connect((err) => {
                if (err) {
                    reject(err.message);
                }
                else {
                    resolve();
                }
            });
        });
    }
    /**
     * @deprecated new implement is queryPromise
     * @param {string} sql
     * @param {function} func - callback
     */
    query(sql, func) {
        this.queryPromise(sql).then(func).catch((errMsg) => {
            vscode__WEBPACK_IMPORTED_MODULE_0__["window"].showErrorMessage(errMsg);
            this.outputMsg(errMsg);
        });
    }
    /**
     * @param {string} sql
     * @return {Promise}
     */
    queryPromise(sql) {
        return new Promise((resolve, reject) => {
            if (!this.connection) {
                reject('connection is undefined');
                return;
            }
            this.connection.query(sql, (err, rows) => {
                if (err) {
                    reject(err.message);
                    return;
                }
                resolve(rows);
            });
        });
    }
    /**
     * @return {Promise<string[], Error>}
     */
    getDatabase() {
        return new Promise((resolve, reject) => {
            this.queryPromise('SHOW DATABASES').then((results) => {
                const allDatabase = [];
                for (let i = 0; i < results.length; i++) {
                    allDatabase.push(results[i].Database);
                }
                resolve(allDatabase);
            }).catch(reject);
        });
    }
    /**
     * @param {string} name - name Database
     * @return {Promise}
     */
    changeDatabase(name) {
        return new Promise((resolve, reject) => {
            this.queryPromise('USE `' + name + '`').then(() => {
                this.currentDatabase = name;
                resolve();
            }).catch((err) => {
                this.currentDatabase = null;
                reject(err);
            });
        });
    }
    /**
     * @param {string} sql - queries
     * @return {string[]}
     */
    splitQueries(sqlMulti) {
        const quotes = /^((?:[^"`']*?(?:(?:"(?:[^"]|\\")*?(?<!\\)")|(?:'(?:[^']|\\')*?(?<!\\)')|(?:`(?:[^`]|\\`)*?(?<!\\)`)))*?[^"`']*?)/;
        const delimiterRegex = /^(?:\r\n|[ \t\r\n])*DELIMITER[\t ]*(.*?)(?:\r\n|\n|\r|$)/i;
        let match = [];
        const queries = [];
        let delimiter = ';';
        let splitRegex = new RegExp(quotes.source + delimiter);
        while (match !== null) {
            const delimiterCommand = sqlMulti.match(delimiterRegex);
            if (delimiterCommand !== null) { //if to change delimiter
                delimiter = delimiterCommand[1].replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); //change delimiter
                splitRegex = new RegExp(quotes.source + delimiter);
                sqlMulti = sqlMulti.slice(delimiterCommand[0].length); //remove delimiter from sql string
            }
            else {
                match = sqlMulti.match(splitRegex); //split sql string
                if (match !== null) {
                    queries.push(match[1]); //push the split query into the queries array
                    sqlMulti = sqlMulti.slice(match[1].length + delimiter.length); //remove split query from sql string
                }
            }
        }
        queries.push(sqlMulti); //push last query which could have no delimiter
        //remove empty queries
        return queries.filter((sql) => {
            if (!sql) {
                return false;
            }
            const notEmpty = (sql.trim().replace(/(\r\n|\n|\r)/gm, '') !== '');
            return notEmpty ? true : false;
        });
    }
    /**
     * @param {string} sql - a SQL string
     * @return {string} - the SQL string without comments
     */
    removeComments(sql) {
        const quotes = /^((?:[^"`']*?(?:(?:"(?:[^"]|\\")*?(?<!\\)")|(?:'(?:[^']|\\')*?(?<!\\)')|(?:`(?:[^`]|\\`)*?(?<!\\)`)))*?[^"`']*?)/;
        const cStyleComments = new RegExp(quotes.source + '/\\*.*?\\*/');
        const doubleDashComments = new RegExp(quotes.source + '--(?:(?:[ \t]+.*(\r\n|\n|\r)?)|(\r\n|\n|\r)|$)');
        const hashComments = new RegExp(quotes.source + '#.*(\r\n|\n|\r)?');
        while (sql.match(cStyleComments))
            sql = sql.replace(cStyleComments, '$1');
        while (sql.match(doubleDashComments))
            sql = sql.replace(doubleDashComments, '$1$2$3');
        while (sql.match(hashComments))
            sql = sql.replace(hashComments, '$1$2');
        return sql;
    }
    /**
     * @return {Promise}
     */
    refrestStructureDataBase() {
        const currentStructure = {};
        const tablePromise = [];
        return new Promise((resolve, reject) => {
            this.queryPromise('SHOW tables').then(results => {
                for (let i = 0; i < results.length; i++) {
                    const key = Object.keys(results[i])[0];
                    const tableName = results[i][key];
                    const promise = new Promise((resolve, reject) => {
                        this.queryPromise('SHOW COLUMNS FROM ' + tableName).then((column) => {
                            resolve({
                                column: column,
                                tableName: tableName
                            });
                        }).catch(reject);
                    });
                    tablePromise.push(promise);
                }
                Promise.all(tablePromise).then((data) => {
                    for (let i = 0; i < data.length; i++) {
                        const columnStructure = data[i].column;
                        const tableName = data[i].tableName;
                        currentStructure[tableName] = columnStructure;
                    }
                    resolve(currentStructure);
                }).catch(reject);
            }).catch(reject);
        });
    }
    /**
     * @param {string} tableName
     * @return {string} a quoted identifier table name
     */
    getIdentifiedTableName(tableName) {
        return `\`${tableName}\``;
    }
    /**
     * @param {string} tableName
     * @return {string} a SQL SELECT statement
     */
    getSelectTableSql(tableName) {
        return `SELECT * FROM ${this.getIdentifiedTableName(tableName)}`;
    }
}
MySQLType.prototype.typeName = 'MySql';
MySQLType.prototype.fieldsToConnect = [
    {
        type: 'text',
        defaultValue: 'localhost',
        name: 'host',
        title: 'Host',
        info: '(e.g host, 127.0.0.1, with port 127.0.0.1:3333)'
    },
    {
        type: 'checkbox',
        defaultValue: false,
        name: 'socket',
        title: 'via socket',
        info: '(if you want to connect via socket, enter socketPath in the host field)'
    },
    {
        type: 'checkbox',
        defaultValue: false,
        name: 'insecureAuth',
        title: 'insecure auth',
        info: '(Allow connecting to MySQL instances that ask for the old (insecure) authentication method)'
    },
    {
        type: 'text',
        defaultValue: 'root',
        name: 'username',
        title: 'Username',
        info: '(e.g root/user)'
    },
    {
        type: 'password',
        name: 'password',
        defaultValue: '',
        title: 'Password',
        info: ''
    }
];
/* harmony default export */ __webpack_exports__["default"] = (MySQLType);


/***/ })

};;
//# sourceMappingURL=5.extension.js.map