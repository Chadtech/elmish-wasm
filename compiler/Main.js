var fs = require("fs");

var fn = process.argv[2];

console.log(process.argv);

var file = fs.readFileSync(fn, 'utf-8');


var re = /module/;

console.log(re.exec(file));

var errors = [
	function()
]