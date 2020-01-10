/**
 * @name onNavBarResize On Navigation Bar Resize
 * @description The purpose of this function is set the display mode of nav bar when the
 * window is resized.
 */
function onNavBarResize()
{
  var header = document.getElementsByTagName("header")[0];
  var navBarItemsListElement = document.getElementById("NavigationBarItemsList");
  
  if(header.offsetWidth > 1350 || document.navBarExpanded)
  {
    navBarItemsListElement.style.display = "block";
  }
  else
  {
    navBarItemsListElement.style.display = "none";
  }
}

/**
 * @name registerNavBarEvents This function will register all the event listeners that are related to the navigation
 * bar.
 */
function initNavBar()
{
  /**
   * Custom boolean is used to indicate the state of the navigation bar on small screens
   * When the navigation bar drop down button is pressed, it toggles between true and false.
   * This is used so the state is retained.
   */
  document.navBarExpanded = false;
  window.onresize = onNavBarResize;
}

function navBarDropDownButtonClick()
{
  var navBarItemsListElement = document.getElementById("NavigationBarItemsList");

  if(!navBarItemsListElement) 
  {
    console.error("Error: No element with id 'NavigationBarItemsList' has been found.");
    return;
  }
  
  //Determine if display is none or not. Also, intially on phones it is not defined (see elements in dev menu).
  if(navBarItemsListElement.style.display === "none" || !navBarItemsListElement.style.display)
  {
    //Menu is collapsed so need to expand it.
    navBarItemsListElement.style.display = "block";
    document.navBarExpanded = true;
  }
  else
  {
    navBarItemsListElement.style.display = "none";
    document.navBarExpanded = false;
  }
}

initNavBar();