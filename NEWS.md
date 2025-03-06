mapmetadata 4.0.1 (2025-03-06)
=========================

After peer-review with rOpenSci this package was accepted 🎆 and transferred to the rOpenSci GitHub organisation to be hosted and promoted. Mostly, this release contains documentation changes to reflect this repo transfer. Code functionality is unaltered. 

### MINOR IMPROVEMENTS
* test: use function factory instead of {mockery} by @maelle in https://github.com/ropensci/mapmetadata/pull/207
* Small edits on messages by @Lextuga007 in https://github.com/ropensci/mapmetadata/pull/212
* Contribution types updated in https://github.com/ropensci/mapmetadata/pull/209 and https://github.com/ropensci/mapmetadata/pull/208
* Links corrected from 'aim-rsf' organisation to 'ropensci' in https://github.com/ropensci/mapmetadata/pull/219, https://github.com/ropensci/mapmetadata/pull/217 and https://github.com/ropensci/mapmetadata/pull/220

mapmetadata 4.0.0 (2025-02-17)
=========================

Thanks to the brilliant reviewer comments via the rOpenSci software review (https://github.com/ropensci/software-review/issues/674), this release makes some major improvements to the clarity and functionality of the package.   See this issue for a summary of the changes: https://github.com/ropensci/mapmetadata/issues/184

Many of these changes relate to making the package easier to use, as there is a heavy dependence on user interaction, improving validation and testing, and complying with R package best practices. 

mapmetadata 3.0.0 (2025-01-06)
=========================

Thanks in part to helpful rOpenSci editor comments (https://github.com/ropensci/software-review/issues/674) this release makes some improvements to the package, making it more suitable for the rOpenSci software review process, which will be based on this new release going forward.

### BREAKING CHANGES

* The package name has changed from browseMetadata to mapmetadata. mapmetadata better reflects the function of this package and complies with formatting best practice for R package naming
* Combined the browse function into the map function to simplify package use for the user
* Changed some function names to match object_verb convention
* Now using csv (not json) as the the metadata input to reflect the new structure from Health Data Research Gateway
* Removed some custom functions, because utils already offered these! (or very similar)

### NEW FEATURES

* Clearer and more detailed user documentation in README and package website 

### MINOR IMPROVEMENTS

* Logo has been replaced to reflect new package name
* Updated DESCRIPTION file to directly mention Health Data Research Gateway as a data source for this package, normalised the DESCRIPTION file formatting
* Open up the html output file automatically in the user's browser, insteading of prompting the user to do this manually
* Internal functions no longer listed on the package website, only user functions
* Handle temp directories better in unit tests, by using `withr::local_tempdir()`
* Improved unit tests by using `testthat::local_mocked_bindings`   


browseMetadata 2.0.2 (2024-12-12)
=========================

🥳 Submitted this release to rOpenSci: https://github.com/ropensci/software-review/issues/674

### NEW FEATURES

* Addition of pkgcheck workflow
* Added more units test to get the code coverage to exceed minimum standard (>75%)

### MINOR IMPROVEMENTS

* Added bug fix location to DESCRIPTION
* Added pkgcheck workflow badge to README
* Inidicated internal functions by using @internal tag
* Simplified the pkgdown file using the internal tag
* Updated pull request template
* Added examples to functions that did not have them 
  


