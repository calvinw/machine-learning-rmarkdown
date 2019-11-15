var fs = require('fs');
var path = require('path');
var dirPath = path.resolve(__dirname); // path to your directory goes here
var filesList;
fs.readdir(dirPath, function(err, files){
  filesList = files.filter(function(e){
    return path.extname(e).toLowerCase() === '.rmd'
  });

    //filesList = filesList.reverse();
    var id = 10;
    var filesArray = [];
    var colabsArray = [];
    var jupyterArray = [];
  //console.log(filesList);
    //

    for(f of filesList){
      var parsed = path.parse(f);
      var name = parsed.name;

      var htmlFile = name + '.html'
      var rmdFile = name + '.Rmd'
      var pdfFile = name + '.pdf'
      var ipynbFile = name + '.ipynb'
      //var docxFile = name + '.docx'
	
	var fileItem = {
	  id: id++,
	  name: name,
	  children: [
	    { id: id++, name: rmdFile, file: 'Rmd' },
	    { id: id++, name: htmlFile, file: 'html' },
	    { id: id++, name: pdfFile, file: 'pdf'},
	    { id: id++, name: ipynbFile, file: 'ipynb'}
	    //{ id: id++, name: docxFile, file: 'docx'}
	  ]
	};

	filesArray.push(fileItem);

	var colabItem = {
	     id: id++, 
	     name: name, 
	     file: 'colab'
	};
	colabsArray.push(colabItem);

	var jupyterItem = {
	     id: id++, 
	     name: name, 
	     file: 'jupyter'
	};
	jupyterArray.push(jupyterItem);
    }

    let myJson = [ 
	{ 
	    id: 1,
	    name: "Files",
	    children: filesArray 
	},
	{
	    id: 2,
	    name: "Colab Links",
	    children: colabsArray 
	},
	{
	    id: 3,
	    name: "Jupyter Links",
	    children: jupyterArray 
	},
    ];
		    
    console.log(JSON.stringify(myJson, null, 2));
});
