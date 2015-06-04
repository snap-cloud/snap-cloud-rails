#! /usr/bin/env node

var fs = require('fs');

var data = fs.readFileSync('snap/Media100Users.txt');

var ROW_DELIM = '\u0003';
var COL_DELIM = '\u0002';
var items = [];
var temp = '';
console.log('reading...');
for (var i = 0; i < data.length; i += 1) {
    var byte = data.toString('utf-8', i ,i+1);
    if (byte === ROW_DELIM) {
	items.push(temp);
	console.log(items.length);
	temp = '';
    } else {
	temp += byte;
    }
}

delete data;