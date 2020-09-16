"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class WatchDog {
    constructor(interval) {
        this.id = -1;
        this.interval = interval;
    }
    feed(id) {
        clearTimeout(this.handle);
        this.id = id;
        console.log("feeded " + id);
        this.handle = setTimeout(() => {
            console.log("bark " + this.id);
        }, this.interval);
    }
}
exports.WatchDog = WatchDog;
//# sourceMappingURL=watchdog.js.map