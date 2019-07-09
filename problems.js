var fs = require('fs');
var path = require('path');
var dirPath = path.resolve(__dirname); // path to your directory goes here
var filesList;
fs.readdir(dirPath, function(err, files){
  filesList = files.filter(function(e){
    return path.extname(e).toLowerCase() === '.rmd'
  });
    var id = 1;
    var arr = [];
  //console.log(filesList);
    for(f of filesList){
      var parsed = path.parse(f);
      var name = parsed.name;

      var htmlFile = name + '.html'
      var rmdFile = name + '.Rmd'
      var pdfFile = name + '.pdf'
      var ipynbFile = name + '.ipynb'
      var webserverURL = "http://localhost:3000/";
      var jupyterURL = "http://localhost:8888/notebooks/";

	var item = {
	  id: name,
	  name: name,
	  children: [
	    { id: htmlFile , page: webserverURL + htmlFile, name: 'html', file: 'html' },
	    { id: rmdFile, page: webserverURL + rmdFile, name: 'Rmd', file: 'md' },
	    { id: pdfFile, page: webserverURL + pdfFile, name: 'pdf', file: 'pdf'},
//	    { id: ipynbFile, page: jupyterURL + ipynbFile, name: 'ipynb', file: 'notebook'}
	  ]
	};
	arr.push(item);
	id++;
      //console.log(name);
    }
    console.log("var jsonItems =");
    console.log(JSON.stringify(arr, null, 2));
});
