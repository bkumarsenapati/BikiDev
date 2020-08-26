function passThroughToSF (ltiLocation)
{
    
    callingURL = encodeURIComponent(parent.document.URL)
    ltiURL = encodeURIComponent(ltiLocation)
    
    
    newlocation = "sfframe.html?loc=" + callingURL + "&ltiloc=" + ltiURL;
    var myWindow = window.open(newlocation)

}

