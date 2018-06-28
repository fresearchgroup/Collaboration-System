function CheckReason(val){
 var element=document.getElementById('reasontext');
 if(val=='Others'){
   element.style.display='block';
   element.setAttribute("required", "");
 }
 else{  
   element.style.display='none';
   element.removeAttribute("required");
}
}
