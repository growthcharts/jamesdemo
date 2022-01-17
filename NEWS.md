# jamesdemo 0.30.0

- Adds three info URL's
- Renew shinyapps connection

# jamesdemo 0.29.0

- Restricts sites to JAMES and localhost

# jamesdem0 0.28.1

- Adds proper version for `jamesdemodata` dependency

# jamesdemo 0.28.0

* Adds a menu to select bds schema 1.0, 1.1 or 2.0

# jamesdemo 0.27.0

* Renames the package to `jamesdemo`

# jamesdemo 0.26.2

* Replaces the built-in `extdata` directory by the `jamesdemodata` package

# jamesdemo 0.26.1

* Adds testfile test25.json with extreme D-scores at start

# jamesdemo 0.26.0

* Replaces deprecated `convert_bds_ind()` by `fetch_loc()`

# jamesdemo 0.25.0

* Adds DDI to `installed.cabinets` by updating from fat `donorloader` package
* Updates JSON files
* Changes anthropometric --> automatic
* Change json file to have an out-of-range gestational age

# jamesdemo 0.24.0

* Updates `installed.cabinets` using modernised `minihealth::donordata_to_individual()` 
that relies on`clopus::transform_z()` and `clopus::transform_y()` functions 

# jamesdemo 0.23.0

* Adds POPS data
* Updates SMOCC .json that correct for six erroneous BDS numbers

# jamesdemo 0.21.1 

* Add synthetic DOB to preterm and terneuzen JSON examples

# jamesdemo 0.21.0

* Refresh `installed.cabinets` and example JSON files to extra `gad` slot in `minihealth::individualBG` class

# jamesdemo 0.20.0

* Extend SMOCC JSON files to include DDI milestone responses

# jamesdemo 0.19.4

* Update JSON so that GA is in days

# jamesdemo 0.19.3

* Saves cleaner JSON examples files

# jamesdemo 0.19.2

* Updates `installed.cabinets` to `minihealth 0.71.0`

# jamesdemo 0.19.1

* Updates `installed.cabinets` so that `length(dsc@y)` matches `length(dsc@x)` 

# jamesdemo 0.19.0

* Adds testdata in `installed.cabinets` to include `dsc` field for smocc
* Adds a `NEWS.md` file to track changes to the package.
