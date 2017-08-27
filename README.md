# R graphics

## What's here

In this folder are step-by-step tutorials for learning to do graphics in R. These are html files, which means you should be able to open them in a browser window and even print them if you want.

These guides assume you've installed R and R Studio, and have done some of the first Swirl tutorials. If you haven't, skip down to the "Learning R" section of this readme file to find links and advice on getting up and running.

The html files are numbered and - especially the later ones - build on things you learn from previous files. You can view them as a website here: https://dailyherald.github.io/R_graphics/

They're not yet all done, but here's what will be included:

* From 01 to 06, we look at R's basic plotting tools. For exploring data yourself, or just for practice, these are good to know. However, their design isn't great for print or online. And, it takes some work to get a decent graphic out of them. 

* At 07, we start working with ggplot2, the R graphics library that takes a sophisticated approach to graphics. 08_qplot is part of ggplot - q stands for quick, and it's meant to create quick visualizations that help you understand the data. Qplot is an excellent way of quickly looking at your data, and it's a lot easier to use than the basic plots. Along with ggplot2, qplot should replace all those basic plots.

* From 08 through 14, we learn to create the most common graphic types - bar charts, stacked bar charts, grouped bar charts, line and area charts. We also learn how to create color and black-and-white pdfs suitable for print publication and color png files for online. 

* 15 demonstrates how to explore relationships between data using qplot scatter plots and finally creating a publication-ready scatter plot that shows what we found.

* From 16 on, we'll show how to do some less used graphic types like box plots and heat maps.

* Finally, M01 and on looks at R's ability to do maps - specifically choropleth maps.

In addition to the html files, in the folder called "scripts" there are the  scripts and data associated with each tutorial as well as the markdown files assocated with each html file.

In the folder called "Completed" are graphics that have been done and published. At some point, we'll an html tutorial for those as well but at the least they'll be heavily annotated.

All these files are geared to creating publication-quality for the web and print - specifically two-column wide graphics for the Daily Herald. The tutorials are part of our effort to give our staff the opportunity to develop new skills.

That said, these tutorials should be of interest to anyone looking to learn how to create graphics for themselves using R.

## Credits and resources

I am by no means an expert in R. Here's the resouces I learned from in creating these files:

### Learning R

Swirl is a set of interactive - free - tutorials that will take you through the basics of learning R and R-studio.  http://swirlstats.com/  To install it, type: `install.packages("swirl")` in the R console. It'll download and install it for you. 

To run swirl, type: `library(swirl)` and that will activate the tutorials.

I'm also going through this Udemy class: https://www.udemy.com/r-programming/ I find it to be a nice compliment to the swirl tutorials.

If you've never done a Udemy class, the first time you go to their website and look at a specific class, it'll offer that class to you for a drastically reduced price. This r-programming class was only $10. 

### Other resources - graphics

I found these tutorials invaluable for developing our R scripts for graphics
http://t-redactyl.io/tag/r-graphing-tutorials.html

This is an excellent introduction to R for reporters. 
https://paldhous.github.io/NICAR/2017/r-analysis.html
This was taught at NICAR 2017, but the step-by-step worksheet is fairly easy to follow.

Want to see how 538 does their graphics? They use R, and they're putting all their code online for free. Here's a description of what they're doing:
https://cran.r-project.org/web/packages/fivethirtyeight/vignettes/fivethirtyeight.html

And here's the R scripts and datasets they examined
https://github.com/rudeboybert/fivethirtyeight/tree/master/data-raw

Here's the book on data science and R, with one of the authors being the person who created the visualization library ggplo2
http://r4ds.had.co.nz/

Here's a free book on advanced R:
http://adv-r.had.co.nz/

David Montgomery of the Pioneer Press shared this analysis of police data, from working the data to visualizing it: https://github.com/pioneerpress/code/tree/master/st-anthony-police

He's constantly doing little things to develop his skills - just like an athlete will work out every day. Here's where he has that, some of it fun:
https://github.com/dhmontgomery/personal-work


### Other resources - mapping

There's a way bigger challenge doing maps in R, especially if you don't have experience in GIS at all. 

Here's an extensive online tutorial to get started with mapping and R: https://github.com/Robinlovelace/Creating-maps-in-R/blob/master/README.md
It had some rough parts, but I worked through it and my annotations may help:  https://github.com/dailyherald/R-work/blob/master/mapping/mapping.R

This was a good compliment to the above: http://www.computerworld.com/article/3038270/data-analytics/create-maps-in-r-in-10-fairly-easy-steps.html

Another step by step here: https://reubenfb.github.io/mapping_in_r/presentation.html#/

This is just plain beautiful to look at, but it also has good information on working your data so you can do chloropleth maps with custom breaks: https://timogrossenbacher.ch/2016/12/beautiful-thematic-maps-with-ggplot2-only/#discrete-classes-with-quantile-scale

This may be a good compliment to the above: http://www.kevjohnson.org/making-maps-in-r/

More info on the scales package: https://www.rdocumentation.org/packages/scales/versions/0.4.1

Looks like the Financial Times is going to start sharing R tutorials:
https://github.com/ft-interactive/R-tutorials
The first one up is on joining data to shapefiles. FYI, shapefiles are one of the ways mapping information is stored. So, for instance, we have shapefiles for all the counties in Illinois that can be used to show average income by county or median age. 

### Other resources - advanced

I took this one on doing interactives with R at NICAR 2017. I would say it's a little advanced, but it used things we use here at the DH for our interactive maps and graphics.  
https://paldhous.github.io/NICAR/2017/r-to-javascript.html

This is a weekend project - take some time and just go through this as an exercise: Andrew Ba Tran examines police stun gun use in Connecticut. He works the data, and examines it visually with charts and maps all generated in R. This was for a NICAR session. https://trendct.github.io/data/2016/06/stun-guns/

This is amazing: Washington Post shared all the data and R scripts they used to break this major story: "Jared Kushner and his partners used a program meant for job-starved areas to build a luxury skyscraper "
https://github.com/wpinvestigative/kushner_eb5_census