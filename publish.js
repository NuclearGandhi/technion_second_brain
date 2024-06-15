/*
Since this site is made with Obsidian, we use this publish.js file to customize the site.
https://help.obsidian.md/Obsidian+Publish/Customize+your+site
*/


var fontStyle = document.createElement('style');
fontStyle.innerHTML = "@import url('https://fonts.googleapis.com/css2?family=Secular+One&display=swap');";
document.body.prepend(fontStyle);

// Site footer
document.getElementsByClassName('site-footer')[0].innerHTML = 'אף אחת מהזכויות שמורות ל<a href="https://github.com/NuclearGandhi">עידו פנג בנטוב</a> ©';

document.getElementsByClassName('outline-view-outer node-insert-event')[0].firstChild.lastChild.innerHTML = "תוכן עניינים"

setTimeout( function(){ applyAutoDirection(); }, 1000);

function applyAutoDirection() {
    const markdownPreviewSection = document.querySelector('.markdown-preview-section');

    console.log(markdownPreviewSection);
    if (markdownPreviewSection) {
        const elements = markdownPreviewSection.querySelectorAll('div, p, h1, h2, h3, h4, h5, h6');

        elements.forEach(element => {
            element.setAttribute('dir', 'auto');
        });
    }
}