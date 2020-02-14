# Utility functions for EDGE project
###########################################################################################

# Plotting


theme_interval <-
  function(ticklen = -0.25) {
    # This function adds Sigma-plot like theme elements to a ggplot object.
    # Use as an additional arg, eg:
    # ggplot() + theme_sigmaplot()
    
    intervalgrob <-
      theme(
        # Ticks inside
        axis.ticks.length.y.right = unit(ticklen, "cm"),
        axis.ticks.length.y.left = unit(ticklen, "cm"),
        
        # Adjust y text off of the ticks
        axis.text.y = element_text(
          hjust = 1,
          color = "black",
          margin = margin(
            t = 0,
            r = 10,
            b = 0,
            l = 0,
            unit = "pt"
          )
        ),

        # No title/text on right side (just ticks)
        axis.title.y.right = element_blank(),
        axis.text.y.right = element_blank(),
        
        # No ticks or labels on x axis
        axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        axis.title.x.top = element_blank(),
        
        # Panel details
        panel.border = element_rect(size = 1, fill = NA),
        panel.background = element_blank(),
        plot.margin = margin(0, 0.5, 0, 0, "cm"), # provide some buffer space on the right
        
        # Legend symbol background
        legend.key = element_rect(fill = NA)
      )
    return(intervalgrob)
  }


theme_lda <-
  function(ticklen = -0.25) {
    # This function adds Sigma-plot like theme elements to a ggplot object.
    # Use as an additional arg, eg:
    # ggplot() + theme_sigmaplot()
    
    ldagrob <-
      theme(
        # Ticks inside
        axis.ticks.length.y.right = unit(ticklen, "cm"),
        axis.ticks.length.y.left = unit(ticklen, "cm"),
        axis.ticks.length.x.bottom = unit(ticklen, "cm"),
        axis.ticks.length.x.top = unit(ticklen, "cm"),
        
        # Adjust y text off of the ticks
        axis.text.y = element_text(
          hjust = 1,
          color = "black",
          margin = margin(
            t = 0,
            r = 10,
            b = 0,
            l = 0,
            unit = "pt"
          )
        ),
        
        # Adjust y text off of the ticks
        axis.text.x = element_text(
          vjust = 1,
          color = "black",
          margin = margin(
            t = 10,
            r = 0,
            b = 0,
            l = 0,
            unit = "pt"
          )
        ),
        
        # No title/text on right side (just ticks)
        axis.title.y.right = element_blank(),
        axis.text.y.right = element_blank(),
        
        # No title/text on top (just ticks)
        axis.title.x.top = element_blank(),
        axis.text.x.top = element_blank(),
        
        # Panel details
        panel.border = element_rect(size = 1, fill = NA),
        panel.background = element_blank(),
        plot.margin = margin(0, 0.5, 0, 0, "cm"), # provide some buffer space on the right
        
        # Legend symbol background
        legend.key = element_rect(fill = NA, color = NA)
      )
    return(ldagrob)
  }