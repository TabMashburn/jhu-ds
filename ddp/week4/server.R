library(shiny)
library(UsingR)
data(faithful)

shinyServer(
  function(input, output) {
    # For storing which rows have been excluded
    vals <- reactiveValues(
      keeprows = rep(TRUE, nrow(faithful))
    )
    
    ranges <- reactiveValues(x = NULL, y = NULL)
    

    output$plot1 <- renderPlot({
      # Plot the kept and excluded points as two separate data sets
      keep <- faithful[ vals$keeprows, , drop = FALSE]
      exclude <- faithful[!vals$keeprows, , drop = FALSE]
      
      ggplot(keep, aes(waiting, eruptions)) + 
        geom_point(size = 2.5) +
        geom_smooth(method = lm, fullrange = TRUE, color = "black") +
        geom_point(data = exclude, shape = 21, fill = NA, color = "black", alpha = 0.25) +
        coord_cartesian(xlim = ranges$x, ylim = ranges$y, expand = FALSE) +
        xlab("Waiting time between eruptions (min)") +
        ylab("Duration of eruption (min)")
    })
  
    # When a double-click happens, check if there's a brush on the plot.
    # If so, zoom to the brush bounds; if not, reset the zoom.
    observeEvent(input$plot1_dblclick, {
      brush <- input$plot1_brush
      if (!is.null(brush)) {
        ranges$x <- c(brush$xmin, brush$xmax)
        ranges$y <- c(brush$ymin, brush$ymax)
      } else {
        ranges$x <- NULL
        ranges$y <- NULL
      }
    })
    
    # Toggle points that are clicked
    observeEvent(input$plot1_click, {
      res <- nearPoints(faithful, input$plot1_click, allRows = TRUE)
      vals$keeprows <- xor(vals$keeprows, res$selected_)
    })
    
    # Toggle points that are brushed, when button is clicked
    observeEvent(input$exclude_toggle, {
      res <- brushedPoints(faithful, input$plot1_brush, allRows = TRUE)
      vals$keeprows <- xor(vals$keeprows, res$selected_)
    })
    
    # Reset all points
    observeEvent(input$exclude_reset, {
      vals$keeprows <- rep(TRUE, nrow(faithful))
    })
    
      
  }
)