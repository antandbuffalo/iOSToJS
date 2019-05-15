function contentLoaded() {
    console.log("content loaded");
}
contentLoaded();

function showAlert() {
    alert("hello");
    console.log("i should show alert");
    var red = parseInt(Math.random() * 255);
    var green = parseInt(Math.random() * 255);
    var blue = parseInt(Math.random() * 255);
    document.getElementById("title").style.backgroundColor = 'rgb(' + red + ', ' + green + ', ' + blue + ')';
    window.webkit.messageHandlers.test.postMessage("Hello, world!");
    
}
