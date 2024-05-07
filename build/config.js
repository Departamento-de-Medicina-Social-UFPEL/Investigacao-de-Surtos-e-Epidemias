
let confObj = JSON.parse(fs.readFileSync('config.json', "utf-8"));
console.log(confObj, 'confobj')
requirejs.config(conf.obj);

require(["casca", "router", "controller", "bson"], function (
    CascaApp,
    CascaAppRouter,
    CascaController
) {
    var goInit, router, status;
    router = new CascaAppRouter({
        controller: CascaController,
    });
    window.App = new CascaApp({
        appRouter: router,
    });
    unasus.pack.inicializar();
    if (!unasus.pack.getStatus()) {
        status = {
            status: "attended",
            percentage: 0,
            LTIvalue: 0,
        };
        unasus.pack.setStatus(status);
    }
    goInit = function () {
        var modularComponentsCasca;
        modularComponentsCasca = window.modulo.components.map(function (component) {
            return "js/components/" + component.folder + "/main";
        });
        return require(modularComponentsCasca, function () {
            var compArr, component, idx, name;
            compArr = window.modulo.components;
            for (idx in arguments) {
                component = arguments[idx];
                name = compArr[idx].folder;
                window.App.module(name, component);
            }
            return window.App.start();
        });
    }
    if (window.modulo) {
        return goInit();
    }

    var req;
    req = new XMLHttpRequest();
    req.open("GET", "payload.bson", true);
    req.responseType = "arraybuffer";
    req.onload = function (ObjectEvent) {
        var BSON;
        console.log(ObjectEvent);
        BSON = new bson().BSON;
        window.modulo = BSON.deserialize(new Uint8Array(req.response));
        return goInit();
    };
    return req.send();

});
