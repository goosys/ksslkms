
var PublishFolder = "../public";
var AppFolder = "../ksslkms_app";
var SysFolder = "../ksslkms";
var fileBas = "base.xml";
var fileXsl = SysFolder+ "/base.xsl";

var sh = new ActiveXObject( "WScript.Shell" );
sh.CurrentDirectory = AppFolder;

var objBas = new ActiveXObject("Msxml2.DOMDocument");
var objDoc = new ActiveXObject("Msxml2.DOMDocument");
var objStl = new ActiveXObject("Msxml2.DOMDocument");
objDoc.async = false;
objDoc.validateOnParse = false;
objDoc.resolveExternals = true;

objBas.load(fileBas);
objStl.load(fileXsl);
objStl.documentElement.selectNodes("\/\/xsl:variable[\@name='ext']").item(0).text='html';

var sitemap = objBas.documentElement.selectNodes('//xc:SiteMap/xc:directory[@name!=\'hidden\']//*[@xml!=\'\']');

var FSO = WScript.CreateObject("Scripting.FileSystemObject");
FSO.DeleteFolder( PublishFolder );
FSO.CopyFolder( AppFolder, PublishFolder );
FSO.DeleteFile( PublishFolder+'/base.xml' );
FSO.DeleteFile( PublishFolder+'/update.xml' );

for ( var ii=0; ii<sitemap.length; ii++){
  var file = sitemap[ii].getAttribute('xml');
  objDoc.load( file+'.xml' );
  var txtXml = objDoc.transformNode(objStl).replace(/<br><\/br>/g,'<br\/>');

  with( WScript.CreateObject("ADODB.Stream") ){
    Type = 2;
    Charset = "UTF-8";
    Open();
    WriteText(txtXml);
    SaveToFile    ( PublishFolder+ "/"+ file+'.html' , 2 );
    FSO.DeleteFile( PublishFolder+ "/"+ file+'.xml' );
    Close();
  }
}
