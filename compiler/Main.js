var fs = require("fs");
var fn = process.argv[2];

var file = fs.readFileSync(fn, 'utf-8');


function log(a) {
    console.log(a);
    return a;
}

var error = [
    function(file) {
        var re = /module/;
        var result = re.exec(file);
        if (result === null || result.index === 0) {
            return {
                msg: "Youre module doesnt sart with the word \"module\"",
                sample: { 
                    text: /^.{0}(.*)/.exec(file)[0],
                    highlightChars: [],
                }
            }
        } else {
            return null;
        }
    }   
].reduce(function(sum, f) {
    if (sum === null) {
        return f(file);
    } else {
        return sum;
    }
}, null);

console.log("Error", error);