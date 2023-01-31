library("shiny")
shinyUI(fluidPage(
  title = "Exclude Datapoints",
  
  plotOutput(
    "plot1", 
    dblclick = "plot1_dblclick",
    click = "plot1_click",
    brush = brushOpts(id = "plot1_brush", resetOnNew = TRUE)
  ),
  
  fluidRow(
    column(8,

      p('This app displays the Old Faithful Geyser data as duration of eruption 
        vs. waiting time between eruptions along with the linear regression line.
        
        Through interaction with the plot, points can be excluded from the 
        computation that generates the linear regression line. The linear model 
        will automatically update to reflect the current state of included points
        and zoom level.
        '),
      HTML("<ul>
              <li><b>To exclude/include a single point</b> Click on a single point
              to toggle its include state</li>
              <li><b>To toggle include state of a group of points</b> Click your 
              mouse and drag over the region of interest to select a group of 
              points, release mouse, then click on \"Toggle selected points\" to
              toggle the include state of every point within the selection.</li>
              <li><b>Reset all points</b> To reset to a default state that includes
              all points, click \"Reset all points\" </li>
              <li><b>To zoom in and out</b> Click your mouse and drag over the 
              region of interest, release mouse. While the mouse is pointed 
              within the selected region (it will turn into a hand symbol), 
              double click to zoom in. Double click again to zoom out. The 
              include state of points within the zoomed
              in region can be changed just the same as when in the zoomed out
              region</li>
           </ul>"),
    ),
    column(4,
           actionButton("exclude_toggle", "Toggle selected points"),
           actionButton("exclude_reset", "Reset all points"),
           br()
    )
  )
))


