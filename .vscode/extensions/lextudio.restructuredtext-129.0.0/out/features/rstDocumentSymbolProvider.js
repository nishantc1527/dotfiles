"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
class rstDocumentSymbolProvider {
    titleEval(document, i) {
        const titleRx = /^\s*(=|-|~|`|#|"|\^|\+|\*|:|\.|'|_|\+)\1{3,}$/;
        const blankRx = /^\s*$/;
        ;
        let l1 = document.lineAt(i);
        let l2 = document.lineAt(i + 1);
        let info = {
            isTitle: false,
            jump: 1,
            line: null,
            mark: ''
        };
        if (!blankRx.test(l1.text) && !titleRx.test(l1.text) && titleRx.test(l2.text)) {
            info = {
                isTitle: true,
                jump: 2,
                line: l1,
                mark: l2.text.substr(0, 1) + 'U' // underline styled title
            };
        }
        else if (i < document.lineCount - 2
            && titleRx.test(l1.text)
            && !blankRx.test(l2.text)
            && !titleRx.test(l2.text)
            && titleRx.test(document.lineAt(i + 2).text)) {
            info = {
                isTitle: true,
                jump: 3,
                line: l2,
                mark: l1.text.substr(0, 1) + 'OU' // overline+underline styled title
            };
        }
        return info;
    }
    provideDocumentSymbols(document, token) {
        return new Promise((resolve, reject) => {
            let symbols = [];
            let nodes = [[symbols, 0], [, 1]]; // symbol operation cache
            let markRegistry = []; // storage for marks in order.
            let tid = 0;
            let i = 0;
            while (i < document.lineCount - 1) {
                let info = this.titleEval(document, i);
                let titleLevel = markRegistry.indexOf(info['mark']);
                if (info['isTitle'] === true) {
                    if (titleLevel === -1) {
                        markRegistry.push(info['mark']);
                    }
                    titleLevel = markRegistry.indexOf(info['mark']);
                    let line = info['line'];
                    let smb = new vscode.DocumentSymbol(line.text, 'H' + String(titleLevel + 1), vscode.SymbolKind.Field, // determines the outline-item icon 
                    line.range, line.range);
                    for (let j = nodes.length - 1; j >= 0; j--) // reversed-direction scan to proof unconventional header orders.
                     {
                        if (nodes[j][1] > titleLevel) {
                            nodes.pop();
                        }
                        else {
                            nodes[nodes.length - 1][0].push(smb);
                            nodes.push([smb.children, titleLevel + 1]);
                            break;
                        }
                    }
                }
                i = i + info['jump'];
            }
            console.log(markRegistry);
            resolve(symbols);
        });
    }
}
exports.rstDocumentSymbolProvider = rstDocumentSymbolProvider;
//# sourceMappingURL=rstDocumentSymbolProvider.js.map