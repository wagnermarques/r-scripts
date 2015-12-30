##http://mazamascience.com/WorkingWithData/?p=
# Everglades example by Jonathan Callahan @ mazamascience.com

# This flag determines whether images are saved as png files

saveAsPng = TRUE

# You can use the '=' sign for assignment but please get used to the
# R convention '<-'. Some tools depend on consistent use '<-' to parse
# the R code you write.

saveAsPng <- TRUE

# A quick google on "Everglades data csv" and you can find this dataset
# of High Accuracy Elevation Data (HEAD) for the Everglades:

#   http://sofia.usgs.gov/exchange/desmond/desmondelev.html

# We will pick the bigger of the CSV files and read it in as a 'dataframe'.


# ------- READING IN DATA FROM A URL -------------------------------------------

cat("Reading in large Everglades file ...")
con <- url('http://sofia.usgs.gov/exchanget/gdesmond/haed/HAED_v01.csv')
everglades_df <- read.csv(con)


# ------- QUICK LOOK AT A DATAFRAME --------------------------------------------

dim(everglades_df)

# Nice! 57,395 records with 8 variables each.

# Now let's get an overview of the structure of this dataframe.

str(everglades_df)

# We have some 'factors' (aka 'categorical variables'):
#   SUR_METHOD, SUR_FILE, SUR_INFO, VEG_FS, Quad_Name
#
# And we have some 'numerics':
#   ELEV_M, X_UTM, Y_UTM

# Let's pull out and rename the variables that are likely to be interesting.


# ------- DEFINING VARIABLES ---------------------------------------------------

surveyMethod <- everglades_df$SUR_METHOD
elevation <- everglades_df$ELEV_M
habitat <- everglades_df$VEG_FS             # VEG_FS ?= "VEGetation Field Survey"
x <- everglades_df$X_UTM
y <- everglades_df$Y_UTM
quad <- everglades_df$Quad_Name

# Now let's check out each of the factors


# ------- QUICK SUMMARY OF VARIABLES -------------------------------------------

# factors
summary(surveyMethod)                       # 9277 airboat records
summary(habitat)                            # nice but Ouch! -- 40,725 records with ""
summary(quad)                               # nice list of quads with only one ""

# numeric
summary(elevation)                          # The Everglades are flat!

# OK, but we can learn so much more if we inspect things visually.


# ------- FIRST DATA VISUALIZATION:  HISTOGRAM & BOXPLOT -----------------------

# First we'll save the default graphical parameters so we can get back to them

old_par <- par()

# We probably want to work interactively at first but eventually we will
# want to write out image files.  Having this behavior controlled by a flag
# allows us to work in both worlds as we tweak graphical parameters to get
# things "just right".  Here we send graphics output to a .png file if the flag is set.

if (saveAsPng) {  png(file="Everglades_elevation.png",width=500,height=500) }

# We'll plot a histogram of elevation values.
# Then we will add a boxplot that crudely summarizes the histogram.
# We start by creating a layout for two plots with 70% of the vertical space
# going to the upper plot and 30% to the lower.

layout(matrix(seq(2)),heights=c(0.7,0.3))

# Note that the exact settings of various graphical parameters is determined 
# by a lot of trial and error.  Part of why it's nice to have things scripted.

# Here are the rest of the plotting commands.

par(
    bg="white", #cor do fundo
    fg="black", #cor das linhas do que ta sendo plotado

    xlab="X label",
    yLab="Y Label",
    
    col.main="yellow", # cor do titulo do rafico
    col.sub="blue", # cor do subtitulo (embaixo do grafico)
    col.lab="red", #cor dos labels
    col.axis="blue", #cor das marcacoes dos eixoa x e y

    pin=c(400,600), #plot dimensions (width, height) in inches 
    mar=c(0,4.1,4.1,2.1), #c(bottom, left, top, right)
    mgp=c(0,0,1)
)

## reduce size of lower margin

hist(elevation, breaks=100, axes=FALSE,          # plot a histogram with 100 bins
     main="Everglades Elevations",               # use this title
     xlab="", ylab="")                           # no axis labels
par(mar=c(5.1,4.1,0,2.1), mgp=c(3,0.5,0.0))      # adjust margins and axis location
boxplot(elevation, horizontal=TRUE, axes=FALSE)  # add a boxplot underneath
axis(1)                                          # add the x-axis 
mtext("elevation (m)", side=1,line=2.5, font=2)  # add the x-axis label
par(old_par)                                     # restore the original parameters

if (saveAsPng) { dev.off() }                     # end plotting, write file

# The boxplot is basically a 1-dimensional represtantation of the histogram.


# ------- BOXPLOTS BY CATEGORY -------------------------------------------------

# Now that we know what boxplots are, let's break up the data by factor.
# Several functions understand the notation "data ~ factor" and do something smart.

if (saveAsPng) {  png(file="Everglades_elevationByHabitat.png",width=500,height=500) }

par(mar=c(3.1,12.1,4.1,2.1), las=1)              # big left margin, horizontal labels
boxplot(elevation ~ habitat, horizontal=TRUE)    # add a multi-category boxplot
title("Distribution of Elevation by Habitat Type")
par(old_par)                                     # restore the original parameters

if (saveAsPng) { dev.off() }                     # end plotting, write file

# What if we tried this with all of the Quads?

if (saveAsPng) {  png(file="Everglades_elevationByQuad1.png",width=500,height=500) }

par(mar=c(3.1,12.1,4.1,2.1), las=1)              # big left margin, horizontal labels
boxplot(elevation ~ quad, horizontal=TRUE)
title("Distribution of Elevation by Quad Name")
par(old_par)                                     # restore the original parameters

if (saveAsPng) { dev.off() }                     # end plotting, write file

# OK, that's ugly.

# What if we leave off the outliers and shrink the size of the labels
# and make the plot 750 pixels high?

if (saveAsPng) {  png(file="Everglades_elevationByQuad2.png",width=500,height=750) }

par(mar=c(3.1,12.1,4.1,2.1), las=1)              # big left margin, horizontal labels
boxplot(elevation ~ quad, horizontal=TRUE, outline=FALSE, cex.axis=0.7)
title("Distribution of Elevation by Quad Name")
par(old_par)                                     # restore the original parameters

if (saveAsPng) { dev.off() }                     # end plotting, write file

# It's almost readable!


# ------- MASKS AND INDICES ----------------------------------------------------

# You can subset variables by using VAR[...].
# If ... contains a vector of integers, VAR[...] will interpret ... as indices and
# will return the values of VAR found at those indices.
# If ... contains a vector of logicals of the same length as VAR, VAR[...] will
# be used to 'mask' VAR, returning the values of VAR where ... is TRUE.

# Create some 'masks' to help us subset the data.

# Survey methods:
airboat_mask <- surveyMethod == "airboat"

# Habitats of interest:
missingHabitat_mask <- habitat == ""
alligatorHole_mask <- habitat == "Alligator Hole"

# Lets look at those quads again and list the ones with animal names.

quadNames <- levels(quad)                        # extract the 'factor' levels
quadNames

# We can use grep() to find the indices where quadNames matches a string
# and then print out the quadNames at these indices

shark_in_quad_name_indices <- grep('shar',quadNames,ignore.case=TRUE)
quadNames[shark_in_quad_name_indices]

# Or we can just do all that in a single line

quadNames[grep('gator',quadNames,ignore.case=TRUE)]
quadNames[grep('plover',quadNames,ignore.case=TRUE)]
quadNames[grep('flamingo',quadNames,ignore.case=TRUE)]

# Let's create logical masks for the following quads:

flamingoQuad_mask <- quad == "Flamingo"
gatorHookSwampQuad_mask <- quad == "Gator Hook Swamp"
sharkPointQuad_mask <- quad == "Shark Point"

# What else can we do? We want to interrogate this dataset.


# ------- SUBSETTING DATA WITH MASKS -------------------------------------------

# Let's look at habitat around gator holes.

# In one line we will find all of the quads that contain "Alligator Holes". 
# Working from the innermost part of the expression toward the outside:
#   1) mask (aka filter) quads for those with habitat == "Alligator Holes"
#   2) convert the resulting quads from  class 'factor' to class 'character'
#   3) return only the unique values

quads_with_gator_holes <- unique(as.character(quad[alligatorHole_mask]))
quads_with_gator_holes


# ------- PIE CHART SHOWING CATEGORY ABUNDANCE ---------------------------------

# Now we create a table of gator habitat values:
#   1) create another mask that checks against any of these quad names
#   2) subset the habitat variable with this mask
#   3) create a table of habitats found in those quads
#   4) display the habitats as a pie chart

gatorHoleQuad_mask <- quad %in% quads_with_gator_holes
gatorHabitat <- habitat[gatorHoleQuad_mask]
gatorHabitat_table <- table(gatorHabitat)

if (saveAsPng) {  png(file="Everglades_gatorHabitat1.png",width=500,height=500) }

pie(gatorHabitat_table)
title("Habitat types in quadrangles with alligator holes")
par(old_par)                                     # restore the original parameters

if (saveAsPng) { dev.off() }                     # end plotting, write file

# With default parameters, it's ugly as sin.


# ------- PRETTIER PIE CHART:  DONUT CHART -------------------------------------

# After a little trial and error we can clean it up with the following:
#   1) omit any habitats representing < 50 sample sites
#   2) sort from low to high

mainGatorHabitat <- sort(gatorHabitat_table[gatorHabitat_table > 50])
mainGatorHabitat

# Before we start plotting, let's review the named colors we have to choose from

colors()

# Better yet, just pull up a browser and point it at:
#   http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# Now choose colors and plot

habitat_cols <- c("burlywood1","forestgreen","burlywood3","darkolivegreen3",
                  "cadetblue4","sienna3","cadetblue3","darkkhaki")

if (saveAsPng) {  png(file="Everglades_gatorHabitat2.png",width=500,height=500) }

pie(mainGatorHabitat, col=habitat_cols, border='white', cex=1.2)

# Now let's turn it into a 'donut plot' with a legend in the middle.
      
par(new=TRUE)                                    # add a new plot on top of the old one

# NOTE:  This has to be the most counterintuitive setting ever!!!
# NOTE:  Use "new=TRUE" to keep working on the old plot.
# NOTE:  Use "new=FALSE" to start a new one.

pie(c(1), labels=NA, border='white', radius=0.4) # a blank white circle
text(0,0,labels="Gator\nHabitat", cex=2, font=2) # text in the middle
par(old_par)                                     # restore the original parameters

if (saveAsPng) { dev.off() }                     # end plotting, write file

# Awesome!

# Now we're going to create our Everglades vacation map and highlight areas of interest.


# ------- PLOTTING POINTS:  GRAPHICAL TWEAKS -----------------------------------

# We'll create masks for the 'gator habitat' we discovered
treeIsland_mask <- habitat == "Tree Island"
willowShrub_mask <- habitat == "Willow Shrub"
treeIsland_mask <- habitat == "Tree Island"
shrub_mask <- habitat == "Shrub"
wetPrarie_mask <- habitat == "Wet Prarie"
floatingEmergent_mask <- habitat == "Floating Emergent"
cattail_mask <- habitat == "Cattail"
slough_mask <- habitat == "Slough"

# This plot will be a little bigger to accommodate everything.
# A lot of 'cex' tweaking may be needed for different combinations of
# image size & system fonts.

standard_definition_ratio <- 4/3
height <- 550
width <- height * standard_definition_ratio

if (saveAsPng) {  png(file="Everglades_poster.png",width=width,height=height) }

# First, we plot all of the locations with a 'missing value' color.
# Then we overlay the locations of "AHF" and "airboat" surveys in grey.

plot(x, y, pch=15, axes=FALSE, xlab="", ylab="", cex=0.1, col='antiquewhite2', asp=1)
points(x[!missingHabitat_mask], y[!missingHabitat_mask], pch=15, cex=0.2, col="grey90")
points(x[airboat_mask], y[airboat_mask], pch=15, cex=0.2, col="grey85")


# ------- SIMPLE 'FOR' LOOPS -----------------------------------------------------

# Now add overlays for our habitats of interest.
# This will require a little programming (but not much).
# Remember:  we already created the "habitat_cols" for the pie plot.

habitatMask_list <- list(treeIsland_mask, willowShrub_mask, treeIsland_mask,
                         shrub_mask, wetPrarie_mask, floatingEmergent_mask,
                         cattail_mask, slough_mask)
i <- 0
for (mask in habitatMask_list) {
  i <- i + 1
  points(x[mask], y[mask], pch=15, cex=0.3, col=habitat_cols[i])
}

# Now put those nasty gator holes on top with a big, bold letter 'G'.

points(x[alligatorHole_mask], y[alligatorHole_mask], pch=16, cex=2.5, col="white")
points(x[alligatorHole_mask], y[alligatorHole_mask], pch='G', cex=0.9, col="red", font=2)

# Let's draw boxes around our quads of interest with a little more programming

quadMask_list <- list(flamingoQuad_mask, gatorHookSwampQuad_mask, sharkPointQuad_mask)
quad_cols <- c('black','black','black')
quad_labels <- c('Flamingo','Gator Hook Swamp','Shark Point')
i <- 0
for (mask in quadMask_list) {
  i <- i + 1
  w <- min(x[mask])
  e <- max(x[mask])
  s <- min(y[mask])
  n <- max(y[mask])
  rect(e,s,w,n, lwd=2, border=quad_cols[i])
  text_x <- w
  text_y <- (s+n)/2
  text(text_x, text_y, labels=quad_labels[i], col=quad_cols[i], pos=2)
}
par(old_par)                                     # restore the original parameters


# ------- PASTING MORE PLOTS ON TOP --------------------------------------------

# Now let's add elevation information for these three quads.

# Note that the primitive graphics functions like points(), rect() and text()
# draw on top of existing plots.  When we use higher level plotting functions
# like hist() we need to set "par(new=TRUE)" to continue in 'overplot' mode.

par(new=TRUE, fig=c(0.05,0.30,0.40,0.47), mar=c(0,0,0,0), cex=0.5, xpd=NA)
hist(elevation[gatorHookSwampQuad_mask], breaks=seq(-3,3,.2), 
     axes=FALSE,  main="",xlab="", ylab="", xpd=NA)
axis(side=1)

par(new=TRUE, fig=c(0.08,0.33,0.26,0.33), mar=c(0,0,0,0), cex=0.5, xpd=NA)
hist(elevation[sharkPointQuad_mask], breaks=seq(-3,3,.2), 
     axes=FALSE,  main="",xlab="", ylab="", xpd=NA)
axis(side=1)

par(new=TRUE, fig=c(0.15,0.40,0.15,0.21), mar=c(0,0,0,0), cex=0.5, xpd=NA)
hist(elevation[flamingoQuad_mask], breaks=seq(-3,3,.2), 
     axes=FALSE, main="",xlab="", ylab="")
axis(side=1)
mtext("elevation (m)", side=1, line=4, xpd=NA)

par(old_par)                                     # restore the original parameters

# Now we'll add our gator habitat plot from before in the space in the upper left.

par(new=TRUE, fig=c(0.0,0.4,0.55,0.95), mar=c(1,1,1,3))
pie(mainGatorHabitat, col=habitat_cols, border='white', cex=1.0, xpd=NA)
par(new=TRUE)
pie(c(1), labels=NA, border='white', radius=0.4) # a blank white circle
text(0,0,labels="G", col='mistyrose', cex=4, font=2)
text(0,0,labels="Gator\nHabitat", cex=1.2, font=2) # text in the middle
par(old_par)                                       # restore the original parameters


# ------- TEXT ANNOTATIONS -----------------------------------------------------

# Now for some final annotations 

# Set the graphics parameter for 'full bleed' -- don't cut off at the margins 
par(xpd=NA) 

# Diagonal, 'serif' text
text(0.48, 0.3, labels="U N C H A R T E D", family='serif',
     col='grey70', cex=1.4, font=2, srt=-45)

# Cheesy shadow effect
nudge <- 0.004
text(0.7+nudge, 1.0-nudge, labels="Visit the Everglades!", 
     pos=3, col='grey80', cex=3, font=4)
text(0.7, 1.0, labels="Visit the Everglades!", pos=3, cex=3, font=4)

text(0.7+nudge, 0.0-nudge, labels="Use R!", 
     pos=4, col='grey80', cex=2.5, font=4, family='serif')
text(0.7, 0.0, labels="Use R!", pos=4, cex=2.5, font=4, family='serif')

# Italic
text(0.70, 0.5, labels="Enjoy 'Gator' habitat.", pos=4, cex=1.2, font=3)
text(0.70, 0.43, labels="Explore uncharted swamps.", pos=4, cex=1.2, font=3)
text(0.70, 0.36, labels="Avoid elevation sickness.", pos=4, cex=1.2, font=3)

par(old_par)                                     # restore the original parameters
if (saveAsPng) { dev.off() }                     # end plotting, write file
