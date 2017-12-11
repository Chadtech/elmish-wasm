var gulp = require("gulp");
var cp = require("child_process");
var util = require("gulp-util");


var paths = {
    compiler: "./compiler/Main.js"
}


gulp.task("compile", function () {
    var cmd = [
        "node",
        "./compiler/Main.js",
        "./source_elm/Main.elm"
    ].join(" ");

    cp.exec(cmd, function(error, stdout, stderr) {
        if (error) {
            error = (String(error)).slice(0, (String(error)).length - 1);
            (error.split("\n")).forEach(function(line) {
                util.log(util.colors.red(String(line)));
            });
        } else {
            stderr = stderr.slice(0, stderr.length - 1);
            (stderr.split("\n")).forEach(function(line) {
                util.log(util.colors.yellow(String(line)));
            });
        }
        stdout = stdout.slice(0, stdout.length - 1);
        (stdout.split("\n")).forEach(function(line) {
            util.log(util.colors.cyan("Compiler"), line);
        });
    });
});



gulp.task("watch", function(){
    gulp.watch(paths.compiler, ["compile"]);
});

gulp.task("default", ["watch", "compile" ]);