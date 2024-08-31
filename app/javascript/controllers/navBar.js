var htmlbody = document.getElementById("root");
var navBarBtn = document.getElementById("nav-bar-btn");
var navBarList = document.getElementById("nav-bar-list");


navBarBtn.addEventListener("click", (e) =>{
    if(navBarList.className.includes("hide"))
        navBarList.className = "nav-bar-list display"
    else
       navBarList.className = "nav-bar-list hide"
})

htmlbody.addEventListener("click", (e) =>{
    console.log(e.target.className)
    if(!e.target.className.includes("display"))
      navBarList.className = "nav-bar-list hide"
})
