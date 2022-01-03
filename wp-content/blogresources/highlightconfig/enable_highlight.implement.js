$(document).ready(function() {
//hljs.configure({useBR: true});//this does NOT work, the original code should contains <br>, see https://github.com/isagalaev/highlight.js/issues/860
//$('cc').each(function(){
//   $(this).wrap('<pre></pre>');
//});
$('pre cc').each(function(i, block) {
   hljs.highlightBlock(block);
});
});
