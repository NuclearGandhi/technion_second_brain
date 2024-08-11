/*
Since this site is made with Obsidian, we use this publish.js file to customize the site.
https://help.obsidian.md/Obsidian+Publish/Customize+your+site
*/


var fontStyle = document.createElement('style');
fontStyle.innerHTML = "@import url('https://fonts.googleapis.com/css2?family=Secular+One&display=swap');";
document.body.prepend(fontStyle);

document.getElementsByClassName('site-footer')[0].innerHTML = 'אף אחת מהזכויות שמורות ל<a href="https://github.com/NuclearGandhi">עידו פנג בנטוב</a> ©';
document.getElementsByClassName('outline-view-outer node-insert-event')[0].firstChild.lastChild.innerHTML = "תוכן עניינים"
document.getElementsByClassName('nav-view')[0].setAttribute('style', 'visibility: hidden');

//Add to 'nav-vide-outer' div a custom div
var customDiv = document.createElement('div');

//Add html to the custom div
customDiv.innerHTML = `
<div style="
    font-size: var(--font-ui-medium);
    margin-left: 24px;
    margin-right: auto;
    margin-top: 24px;
    ">מצאתם טעות בעמוד? תפתחו <a href="https://github.com/NuclearGandhi/technion_second_brain/discussions">discussion</a> (בבקשה). שימו לב, רק אם תפתחו משתמש תוכלו לפתוח discussion. די מבאס.</div>
    `
document.getElementsByClassName('nav-view-outer')[0].prepend(customDiv);


// -- Auto direction
function applyAutoDirection() {
    const markdownPreviewSection = document.querySelector('.markdown-preview-section');

    setTimeout(function () {
            if (markdownPreviewSection) {
        const elements = markdownPreviewSection.querySelectorAll('table');
        if (elements.length) {
            elements.forEach(element => {
                element.setAttribute('dir', 'auto');
            });
        } else {
            applyAutoDirection();
        }
    }
    }, 1000);
}

applyAutoDirection();

navigation.addEventListener('navigate', () => {
    applyAutoDirection();
});


function setInnerBodyDirection(event) {

    // Change the direction of markdown-preview-section. If the div wasn't found, repeat after 1 second.
    const markdownPreviewSection = document.querySelector('.markdown-preview-section');
      if (markdownPreviewSection) {
        // If the url contains one of the following array of strings, the direction will be set to ltr
        const ltrPages = ['LSY', "MNF"];
        url = window.location.href;
        if (event) {
            url = event.destination.url;
        }
        if (ltrPages.some(page => url.includes(page))) {
            markdownPreviewSection.style.direction = 'ltr';
        } else {
            markdownPreviewSection.style.direction = 'rtl';
        }
     } else {
        setTimeout(() => {
             setInnerBodyDirection();
        }, 1000);
    }
}

function changeBacklinksTitle() {
    const backlinks = document.getElementsByClassName('backlinks');
    if (backlinks[0]) {
        backlinks[0].firstChild.lastChild.innerHTML = "קישורים לעמוד זה";
    } else {
        setTimeout(() => {
             changeBacklinksTitle();
        }, 1000);
    }
}

setInnerBodyDirection();
changeBacklinksTitle();

navigation.addEventListener('navigate', (event) => {
    setInnerBodyDirection(event);
    changeBacklinksTitle();
});
