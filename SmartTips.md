# Some tips I grab online.

1. Toggle light mode to dark mode in any website including pdf file.

* Source: (quora)[https://www.quora.com/How-can-I-read-PDF-in-night-mode-in-Microsoft-Edge]

* Copy this code lines into console by pressing F12
```css
var cover = document.createElement("div"); 
let css = ` 
    position: fixed; 
    pointer-events: none; 
    top: 0; 
    left: 0; 
    width: 100vw; 
    height: 100vh; 
    background-color: white; 
    mix-blend-mode: difference; 
    z-index: 1; 
` 
cover.setAttribute("style", css); 
document.body.appendChild(cover); 
```
