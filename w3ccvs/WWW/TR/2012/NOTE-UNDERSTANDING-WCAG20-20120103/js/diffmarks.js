<!--
//  Scriptlets code written by Jeremy Edmiston
//  The functions have been adapted from various sources
//  and re-written to provide maximum flexibility
//  and compatability with various browsers.

// Modified by Ben Caldwell October 2007.  

//Global Declarations
var ie = (document.all) ? true : false;

// Only show the controls if jvbascript is turned on
function jscheck(){
	document.getElementById('diffexp').style.display = "block";
}

function toggleClass(objClass){
//  This function will toggle obj visibility of an Element
//  based on Element's Class
//  Works with IE and Mozilla based browsers

  if (getElementByClass(objClass).style.display=="none"){
    showClass(objClass)
  }else{
    hideClass(objClass)
  }
}

function hideClass(objClass){
//  This function will hide Elements by object Class
//  Works with IE and Mozilla based browsers

var elements = (ie) ? document.all : document.getElementsByTagName('*');
  for (i=0; i<elements.length; i++){
    if (elements[i].className==objClass){
      elements[i].style.display="none"
    }
  }
}

function showClass(objClass){
//  This function will show Elements by object Class
//  Works with IE and Mozilla based browsers
var elements = (ie) ? document.all : document.getElementsByTagName('*');
  for (i=0; i<elements.length; i++){
    if (elements[i].className==objClass){
      elements[i].style.display="inline"
    }
  }
}


// Custom class to set styles for remove all edits


function showClean(objClass){
//  This function will show Elements by object Class
//  Works with IE and Mozilla based browsers
var elements = (ie) ? document.all : document.getElementsByTagName('*');
  for (i=0; i<elements.length; i++){
    if (elements[i].className==objClass){
      elements[i].style.background="transparent"
    }
  }
}

function showAdd(objClass){
//  This function will show Elements by object Class
//  Works with IE and Mozilla based browsers
var elements = (ie) ? document.all : document.getElementsByTagName('*');
  for (i=0; i<elements.length; i++){
    if (elements[i].className==objClass){
      elements[i].style.backgroundColor="#ffc"
    }
  }
}

function showChange(objClass){
//  This function will show Elements by object Class
//  Works with IE and Mozilla based browsers
var elements = (ie) ? document.all : document.getElementsByTagName('*');
  for (i=0; i<elements.length; i++){
    if (elements[i].className==objClass){
      elements[i].style.backgroundColor="#99FF99"
    }
  }
}

function toggleID(objID){
//  This function will toggle obj visibility of an Element
//  based on Element's ID
//  Works with IE and Mozilla based browsers
var element = (ie) ? document.all(objID) : document.getElementById(objID);
  if (element.style.display=="none"){
    showID(objID)
  }else{
    hideID(objID)
  }
}

function hideID(objID){
//  This function will hide Elements by object ID
//  Works with IE and Mozilla based browsers
var element = (ie) ? document.all(objID) : document.getElementById(objID);
  element.style.display="none"
}

function showID(objID){
//  This function will show Elements by object ID
//  Works with IE and Mozilla based browsers
var element = (ie) ? document.all(objID) : document.getElementById(objID);
  element.style.display="block"
}

function getElementByClass(objClass){
//  This function is similar to 'getElementByID' since there
//  is no inherent function to get an element by it's class
//  Works with IE and Mozilla based browsers
var elements = (ie) ? document.all : document.getElementsByTagName('*');
  for (i=0; i<elements.length; i++){
    //alert(elements[i].className)
    //alert(objClass)
    if (elements[i].className==objClass){
    return elements[i]
    }
  }
}
 // -->