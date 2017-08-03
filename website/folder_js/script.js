var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  if (n > x.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";  
  }
  x[slideIndex-1].style.display = "block";  
}
/////////////////////////////
/////////////////////////////
var slidesindex = 1;
showdiv(slidesindex);

function plusdiv(n) {
  showdiv(slidesindex += n);
}

function showdiv(n) {
  var i;
  var x = document.getElementsByClassName("slide");
  if (n > x.length) {slidesindex = 1}    
  if (n < 1) {slidesindex = x.length}
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";  
  }
  x[slidesindex-1].style.display = "block";  
}