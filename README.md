
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jamesdemo

The `jamesdemo` package contains a simple Shiny app that shows site
functionality of the **Joint Automatic Measurement and Evaluation System
(JAMES)**. The API endpoint `request_site` as defined by
[james](https://github.com/growthcharts/james) returns an URL that
points to a site with personalised child charts. The `jamesdemo` app
shows the site for a set of demo children. The
[jamesdemodata](https://github.com/growthcharts/jamesdemodata) package
stores the data of these children.

## Installation

The following statements will install the `jamesdemo` package

``` r
install.packages("remotes")
remotes::install_github("growthcharts/jamesdemo")
```

## Example

Within RStudio, view the website locally as follows:

``` r
library(jamesdemo)
go()
```

The app does not run in the internal RStudio viewer. Click on button
`Open in browser` to see it in action.

## Online version

You can spare yourself the trouble of installing the package, and visit
`JAMES tryout` at
<https://tnochildhealthstatistics.shinyapps.io/james_tryout/>.

## Resources

-   [james](https://github.com/growthcharts/james)
-   [jamesdemodata](https://github.com/growthcharts/jamesdemodata)
