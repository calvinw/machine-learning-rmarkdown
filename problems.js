var fs = require('fs');
var path = require('path');
var yaml = require('js-yaml');
var dirPath = path.resolve(__dirname); // path to your directory goes here
var filesList;
fs.readdir(dirPath, function(err, files){
  filesList = files.filter(function(e){
    return path.extname(e).toLowerCase() === '.rmd'
  });
    var id = 1;
    var arr = [];
  //console.log(filesList);
    //
    let googlecolabidsdata = fs.readFileSync('google-colab-ids.json');
    let googlecolabids = JSON.parse(googlecolabidsdata);
    let googledocxidsdata = fs.readFileSync('google-docx-ids.json');
    let googledocxids = JSON.parse(googledocxidsdata);

    for(f of filesList){
      var parsed = path.parse(f);
      var name = parsed.name;

      var htmlFile = name + '.html'
      var rmdFile = name + '.Rmd'
      var pdfFile = name + '.pdf'
      var ipynbFile = name + '.ipynb'
      var docxFile = name + '.docx'
	
      var googlecolabId = googlecolabids[name]; 
      var googledocxId = googledocxids[name]; 

	var item = {
	  id: name,
	  name: name,
	  children: [
	    { id: htmlFile , name: 'html', file: 'html' },
	    { id: rmdFile, name: 'Rmd', file: 'md' },
	    { id: pdfFile, name: 'pdf', file: 'pdf'},
	    { id: ipynbFile, name: 'ipynb', file: 'ipynb', googleId: googlecolabId},
	    { id: docxFile, name: 'docx', file: 'docx', googleId: googledocxId}
	  ]
	};
	arr.push(item);
	id++;
      //console.log(name);
    }
    console.log(JSON.stringify(arr, null, 2));
});
