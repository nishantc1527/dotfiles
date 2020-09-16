exports.ids = [7];
exports.modules = {

/***/ "./src/extension/engine/postgresslsql.ts":
/*!***********************************************!*\
  !*** ./src/extension/engine/postgresslsql.ts ***!
  \***********************************************/
/*! exports provided: PostgreSSLSQLType, default */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "PostgreSSLSQLType", function() { return PostgreSSLSQLType; });
/* harmony import */ var pg__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! pg */ "./node_modules/pg/lib/index.js");
/* harmony import */ var pg__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(pg__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var fs__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! fs */ "fs");
/* harmony import */ var fs__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(fs__WEBPACK_IMPORTED_MODULE_1__);
/* harmony import */ var _postgresql__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! ./postgresql */ "./src/extension/engine/postgresql.ts");



class PostgreSSLSQLType extends _postgresql__WEBPACK_IMPORTED_MODULE_2__["PostgreSQLType"] {
    constructor() {
        super();
        this.ca = '';
        this.key = '';
        this.cert = '';
    }
    getName() {
        if (this.name) {
            return this.name;
        }
        return `${this.host}:${this.port} (${this.typeName})`;
    }
    /**
     * @param {object} fields
     * @return {Promise}
     */
    connectPromise({ host, database, schema, key, cert, ca }) {
        const [hostName, port = '5432'] = host.split(':');
        this.host = hostName;
        this.port = port;
        this.database = database;
        this.schema = schema;
        this.ca = ca;
        this.key = key;
        this.cert = cert;
        const connection = new pg__WEBPACK_IMPORTED_MODULE_0__["Pool"]({
            database: this.database,
            host: this.host,
            port: parseInt(port, 10),
            max: 10,
            idleTimeoutMillis: 30000,
            ssl: {
                rejectUnauthorized: false,
                ca: Object(fs__WEBPACK_IMPORTED_MODULE_1__["readFileSync"])(ca).toString(),
                key: Object(fs__WEBPACK_IMPORTED_MODULE_1__["readFileSync"])(key).toString(),
                cert: Object(fs__WEBPACK_IMPORTED_MODULE_1__["readFileSync"])(cert).toString(),
            }
        });
        return new Promise((resolve, reject) => {
            connection.connect((err, client, release) => {
                this.connection = connection;
                this.release = release;
                this.release();
                if (err) {
                    reject(err);
                    return;
                }
                resolve();
            });
            connection.on('error', reject);
        });
    }
    /**
     * @return {object} - object with some data to save
     */
    getDataToRestore() {
        return Promise.resolve({
            type: this.type,
            name: this.name,
            host: this.host + ':' + this.port,
            ca: this.ca,
            key: this.key,
            cert: this.cert,
            database: this.currentDatabase,
        });
    }
    /**
     * @param {object} fields - result getDataToRestore() function
     * @return {Promise}
     */
    restoreConnection(fields) {
        return this.connectPromise(fields);
    }
}
PostgreSSLSQLType.prototype.typeName = 'Postgre SQL (SSL)';
PostgreSSLSQLType.prototype.fieldsToConnect = [
    {
        type: 'text',
        defaultValue: 'localhost',
        name: 'host',
        title: 'Host',
        info: '(e.g host, 127.0.0.1, with port 127.0.0.1:3333)'
    },
    {
        type: 'text',
        defaultValue: 'postgres',
        name: 'database',
        title: 'Database',
        info: ''
    },
    {
        type: 'text',
        defaultValue: 'public',
        title: 'Schema',
        name: 'schema',
        info: ''
    },
    {
        type: 'text',
        defaultValue: '',
        name: 'ca',
        title: 'CA',
        info: '(Server certificates - path to `root.crt`)'
    },
    {
        type: 'text',
        defaultValue: '',
        title: 'KEY',
        name: 'key',
        info: '(Client key - path to `client.key`)'
    },
    {
        type: 'text',
        defaultValue: '',
        title: 'CERT',
        name: 'cert',
        info: '(Client certificates - path to `client.crt`)'
    }
];
/* harmony default export */ __webpack_exports__["default"] = (PostgreSSLSQLType);


/***/ })

};;
//# sourceMappingURL=7.extension.js.map