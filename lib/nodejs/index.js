const data = require('./crawdata.json');
const fs = require('fs');
var result = [];
var data1 = {};
fs.readFile('./crawdata.json', 'utf-8', (err, jsonString) => {
    if (err) {
        console.log(err);
    } else {
        try {
            const data = JSON.parse(jsonString);
            var aData = data.__collections__.words;
            console.log(aData.length);
            var i = 1;
            for (var i = 0; i < aData.length; i++) {

                aData[i]["__collections__"] = {};
                // data1 = { i: data.__collections__.words[i], }
                data1[i] = aData[i];
                // console.log(data1);

            }
            result.push(data1);
            fs.writeFile('./newData.json', JSON.stringify(result), err => {
                if (err) {
                    console.log(err);
                } else {
                    console.log('write ok');
                }
            })

        } catch (err) {
            console.log('Error parsing JSON', err);
        }
    }
})
// console.log(data);