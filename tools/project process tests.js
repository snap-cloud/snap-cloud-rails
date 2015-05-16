sep.forEach(function(i, num) {
    console.log(num);
    name = i[0].replace(/\//g, '--');
    dir = i[1] + '/' + name;
    data = i.slice(0, 4).join('\n');
    meta = fs.openSync(dir + '.txt', 'w+');
    fs.writeSync(meta, data);
    fs.closeSync(meta);
    proj = fs.openSync(dir + '.xml', 'w+');
    fs.writeSync(proj, i[5]);
    fs.closeSync(proj);
})