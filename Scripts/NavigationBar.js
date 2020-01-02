function navBarDropDownButtonClick()
{
  var navBarItemsListElement = document.getElementsByClassName("NavigationBarItemsList")[0];

  if(!navBarItemsListElement) 
  {
    console.error("Error: No nav bar items list found.");
    return;
  }

  //Determine if display is none or not. Also, intially on phones it is not defined (see elements in dev menu).
  if(navBarItemsListElement.style.display === "none" || !navBarItemsListElement.style.display)
  {
    //Menu is collapsed so need to expand it.
    navBarItemsListElement.style.display = "block";
  }
  else
  {
    navBarItemsListElement.style.display = "none";
  }
}