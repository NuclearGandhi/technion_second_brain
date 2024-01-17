/*
Since this site is made with Obsidian, we use this publish.js file to customize the site.
https://help.obsidian.md/Obsidian+Publish/Customize+your+site
*/

// Customize navigation order

let navOrderAsc = ["README"]; // These go on top
let navOrderDsc = []; // These go at the bottom

// Items not mentioned go in between in alphabetical order

var siteLeft = document.querySelector('.site-body-left-column');
var siteNav = siteLeft.querySelector('.nav-view-outer');
var navContainer = siteNav.querySelector('.tree-item').querySelector('.tree-item-children');

var fontStyle = document.createElement('style');
fontStyle.innerHTML = "@import url('https://fonts.googleapis.com/css2?family=Secular+One&display=swap');";
document.body.prepend(fontStyle);

// Edit this node in Github
// var markdownStrip = document.getElementsByClassName("markdown-preview-view")[0];

// var editInGithub = document.createElement("div");
// editInGithub.setAttribute("class", "edit-in-github");
// editInGithub.innerHTML = '<a data-tooltip-position="top" rel="noopener" class="external-link" title="github edit note" href="" target="_blank">Edit In GitHub </a>';
// editInGithub.addEventListener('click', function (e) {
//     var url = window.location.href;
//     var path = url.replace("https://notes.idofangbentov.site/", "");
//     var removedPlus = path.replace("+", " ");
//     window.open('https://github.dev/NuclearGandhi/technion_second_brain/blob/master/' + removedPlus + '.md', '_blank')
//     return false;
// });
// markdownStrip.prepend(editInGithub);

// Site footer
document.getElementsByClassName('site-footer')[0].innerHTML = 'אף אחת מהזכויות שמורות ל<a href="https://github.com/NuclearGandhi">עידו פנג בנטוב</a> ©';

document.getElementsByClassName('outline-view-outer node-insert-event')[0].firstChild.lastChild.innerHTML = "תוכן עניינים"