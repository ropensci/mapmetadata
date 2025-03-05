
# mapmetadata <a href="https://ropensci.github.io/mapmetadata/"><img src="man/figures/logo.png" align="right" height="180" alt="mapmetadata website" /></a>

<!-- badges: start -->
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.14605021.svg)](https://doi.org/10.5281/zenodo.10581499)
[![All Contributors](https://img.shields.io/badge/all_contributors-8-orange.svg?style=flat-square)](#contributors-)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Status at rOpenSci Software Peer Review](https://badges.ropensci.org/674_status.svg)](https://github.com/ropensci/software-review/issues/674)
[![R-CMD-check](https://github.com/ropensci/mapmetadata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ropensci/mapmetadata/actions/workflows/R-CMD-check.yaml)
[![pkgcheck](https://github.com/ropensci/mapmetadata/workflows/pkgcheck/badge.svg)](https://github.com/ropensci/mapmetadata/actions?query=workflow%3Apkgcheck)
[![codecov](https://codecov.io/gh/ropensci/mapmetadata/graph/badge.svg?token=59S2QVG7CQ)](https://codecov.io/gh/ropensci/mapmetadata)
<!-- badges: end -->

## What is the `mapmetadata` package?

For researchers working with health datasets, there are many great resources that summarise features about these datasets (often termed metadata) and how to access them. Access to metadata can help researchers plan projects prior to gaining full access to health datasets. Learn more about health metadata in our [Health Metadata article hosted on the package website](https://docs.ropensci.org/mapmetadata/articles/HealthMetadata.html).

One comprehensive open resource is the [Health Data Research Gateway](https://healthdatagateway.org/search?search=&datasetSort=latest&tab=Datasets), managed by [Health Data Research UK](https://www.hdruk.ac.uk/) in collaboration with the [UK Health Data Research Alliance](https://ukhealthdata.org/). The gateway can help a researcher address questions such as: *What datasets are available? What are the features of these datasets? Which datasets fit my research? How do I access these datasets? How have these datasets been used by the community before, and do they link to others? What publications, or other resources exist, using these datasets?* 

This `mapmetadata` package uses structural metadata files, downloaded from the Health Data Research Gateway. In theory, any metadata file with the same structure as the the files downloaded from this gateway can be used with this package. The `mapmetadata` package goes beyond just browsing structural metadata, and helps a researcher interact with this metadata and map it to their research domains/concepts. Firstly, it creates a plot (see example below) displaying number of variables in each table, number of tables, and the completeness of the metadata (i.e. whether the description for each variable in a table exists). 

Secondly, it helps the researcher address the question *Which variables map onto with my research domains?*  (e.g. socioeconomic, childhood adverse events, diagnoses, culture and community). The package guides users in mapping each variable into predefined research domains. Research domains could otherwise be called concepts or latent variables. To speed up this manual mapping process, the package automatically categorises variables that frequently occur in health datasets (e.g. ID, Sex, Age). The package also accounts for variables that appear across multiple tables within a dataset and allows users to copy their categorisations to ensure consistency. The output files can be used in later analyses to filter and visualise variables by category.

## Getting started with `mapmetadata`

### Installation and set-up

Run in the R console: 

```r
install.packages("mapmetadata", repos = "https://ropensci.r-universe.dev")
```

Load the library:

``` r
library(mapmetadata)
```

### Demo (using the `R Studio` IDE)

There are three main functions you can interact with: `metadata_map`, `map_compare`, and `map_convert`. For more information on any function, type `?function_name`. 

The main function is `metadata_map` and you can run it in demo mode using the files located in the [inst/inputs](https://github.com/ropensci/mapmetadata/tree/main/inst/inputs) directory:

``` r
metadata_map()
``` 
Terminology used in this package: a *dataset* can contain one or more *tables* which contains multiple column *variables*. It creates a plot at the dataset level, and guides you through an interactive session at the table level, to sort table variables into pre-defined categories/domains. 

In the R console you should see:

```
ℹ Running demo mode using package data files
ℹ Using the default look-up table in data/look-up.rda
ℹ Processing dataset '360_NCCHD' containing 13 tables

ℹ A bar plot should have opened in your browser (also saved to your project directory).
Use this bar plot, and the information on the HDRUK Gateway, to guide your mapping approach.

Enter the table number you want to process: 
```

You can exit here (with Clt-C or Esc) to just get this summary plot, which is saved to your project directory. All outputs from this `metadata_map` function are saved to your project directory. You can change the save location by adjusting the `output_dir` argument (an argument means the information given to a function, to alter how it runs). For example `metadata_map(output_dir = 'username/sub_directory')`.

<img src="https://raw.githubusercontent.com/ropensci/mapmetadata/main/inst/outputs/BAR_360_NCCHD_2025-02-14-18-14-01.png" alt="example bar plot showing number of variables for each table alongside counts of whether variables have missing descriptions">

If you continue to the mapping stage, you will see all the tables in this dataset are listed. Select the 4th table for demo purposes:

```
Enter the table number you want to process: 

 1: BLOOD_TEST          2: BREAST_FEEDING       3: CHE_HEALTHYCHILDWALESPROGRAMME
 4: CHILD               5: CHILD_BIRTHS         6: CHILD_MEASUREMENT_PROGRAM     
 7: CHILD_TRUST         8: EXAM                 9: IMM                           
10: PATH_BLOOD_TESTS    11: PATH_SPCM_DETAIL    12: REFR_IMM_VAC                  
13: SIG_COND                        

Selection: 4
```

Add a note for processing this table:

```
ℹ Processing Table 4 of 13 (CHILD)

Optional note about this table: Demo run
```
This table has 35 variables (see 'n of 35' below) but the demo run will only process the first 5 variables (by default). If it skips over a variable (as is the case with 1, 2 and 3) this means it has been auto-categorised. Variable 4 has not been auto-categorised and is asking you to categorise it. You will be asked to categorise a variable with one (or more) of the numbers shown in the [key that has appeared in your plots tab](https://github.com/ropensci/mapmetadata/tree/main/inst/outputs/plots_tab_demo_domains.png). We input '8' which means 'Health Info' as defined by the key. The demo simplifies domains for demonstration purposes; for a research study, your domains are likely to be much more specific e.g. ‘Prenatal, antenatal, neonatal and birth’ or ‘Health behaviours and diet’. 

```
ℹ Table variable 1 of 35 (5 left to process)
ℹ Table variable 2 of 35 (4 left to process)
ℹ Table variable 3 of 35 (3 left to process)
ℹ Table variable 4 of 35 (2 left to process)

VARIABLE ----->  APGAR_1 

DESCRIPTION ----->  APGAR 1 score. This is a measure of a baby's physical state at birth with particular reference to asphyxia - taken at 1 minute. Scores 3 and below are generally regarded as critically low; 4-6 fairly low, and 7-10 generally normal. Field can contain high amount of unknowns/non-entries. 

DATA TYPE ----->  CHARACTER 

Categorise variable into domain(s). E.g. 3 or 3,4: 8
Categorisation note (or press enter to continue): level of asphyxia at birth
Response to be saved is ' 8 '. Would you like to re-do? (y/n): n
```
Repeat the categorisation for the 5th variable to finish. You will then be asked to review the categorisations:

- First, you will be shown the auto-categorisations and asked if you want to manually edit them (i.e. override the auto categorisation). 

    - 'ALF' refers to ‘Anonymous Linking Field’ - this field is used within datasets that have been anonymised and encrypted for inclusion within [SAIL Databank](https://saildatabank.com/governance/privacy-by-design/).
    
- Second, you will be asked if you want to review your own categorisations. Select Yes(1) and follow the instructions.

You can use the output file from the `metadata_map()` function as input for subsequent analysis to filter and visualise variables by research domain. For more information on custom inputs (metadata file, domain list and lookup) and how to understand the outputs, see the [mapmetadata tutorial](https://ropensci.github.io/mapmetadata/articles/mapmetadata.html) page on the package website. 

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](https://github.com/ropensci/mapmetadata/blob/main/LICENSE.md) file for details.  
For more information, refer to [GNU General Public License](https://www.gnu.org/licenses/gpl-3.0.en.html).

## Code of Conduct 

Please note that this package is released with a [Contributor
Code of Conduct](https://ropensci.org/code-of-conduct/). 
By
contributing to this project, you agree to abide by its terms.

## Citation

To cite `mapmetadata` in publications:

> Stickland R (2025). mapmetadata: map health metadata onto predefined research domains. R package version 4.0.0.

A BibTeX entry for LaTeX users:

```r         
  @Manual{,
    title = {mapmetadata: map health metadata onto predefined research domains},
    author = {Rachael Stickland},
    year = {2025},
    note = {R package version 4.0.0},
    doi = {https://doi.org/10.5281/zenodo.10581499}, 
  }
```

## Contributing

We welcome contributions to `mapmetadata`. Please read our [Contribution Guidelines](https://github.com/ropensci/mapmetadata/blob/main/CONTRIBUTING.md) for details on how to contribute.

-   **Report Issues**: Found a bug? Have a feature request? Report it on [GitHub Issues](https://github.com/ropensci/mapmetadata/issues).
-   **Submit Pull Requests**: Follow our [Contribution Guidelines](https://github.com/ropensci/mapmetadata/blob/main/CONTRIBUTING.md) for pull requests.
-   **Feedback**: Share your thoughts by opening an issue.

### Contributors ✨

Thanks go to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="http://linkedin.com/in/rstickland-phd"><img src="https://avatars.githubusercontent.com/u/50215726?v=4?s=100" width="100px;" alt="Rachael Stickland"/><br /><sub><b>Rachael Stickland</b></sub></a><br /><a href="#content-RayStick" title="Content">🖋</a> <a href="https://github.com/ropensci/mapmetadata/commits?author=RayStick" title="Documentation">📖</a> <a href="#maintenance-RayStick" title="Maintenance">🚧</a> <a href="#ideas-RayStick" title="Ideas, Planning, & Feedback">🤔</a> <a href="#projectManagement-RayStick" title="Project Management">📆</a> <a href="https://github.com/ropensci/mapmetadata/pulls?q=is%3Apr+reviewed-by%3ARayStick" title="Reviewed Pull Requests">👀</a> <a href="https://github.com/ropensci/mapmetadata/commits?author=RayStick" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://batool-almarzouq.netlify.app/"><img src="https://avatars.githubusercontent.com/u/53487593?v=4?s=100" width="100px;" alt="Batool Almarzouq"/><br /><sub><b>Batool Almarzouq</b></sub></a><br /><a href="#userTesting-BatoolMM" title="User Testing">📓</a> <a href="https://github.com/ropensci/mapmetadata/pulls?q=is%3Apr+reviewed-by%3ABatoolMM" title="Reviewed Pull Requests">👀</a> <a href="#ideas-BatoolMM" title="Ideas, Planning, & Feedback">🤔</a> <a href="#projectManagement-BatoolMM" title="Project Management">📆</a> <a href="https://github.com/ropensci/mapmetadata/commits?author=BatoolMM" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/Rainiefantasy"><img src="https://avatars.githubusercontent.com/u/43926907?v=4?s=100" width="100px;" alt="Mahwish Mohammad"/><br /><sub><b>Mahwish Mohammad</b></sub></a><br /><a href="#userTesting-Rainiefantasy" title="User Testing">📓</a> <a href="https://github.com/ropensci/mapmetadata/pulls?q=is%3Apr+reviewed-by%3ARainiefantasy" title="Reviewed Pull Requests">👀</a> <a href="#ideas-Rainiefantasy" title="Ideas, Planning, & Feedback">🤔</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/DDelbarre"><img src="https://avatars.githubusercontent.com/u/108824056?v=4?s=100" width="100px;" alt="Daniel Delbarre"/><br /><sub><b>Daniel Delbarre</b></sub></a><br /><a href="#ideas-DDelbarre" title="Ideas, Planning, & Feedback">🤔</a> <a href="#userTesting-DDelbarre" title="User Testing">📓</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/NidaZiaS"><img src="https://avatars.githubusercontent.com/u/142920412?v=4?s=100" width="100px;" alt="NidaZiaS"/><br /><sub><b>NidaZiaS</b></sub></a><br /><a href="#ideas-NidaZiaS" title="Ideas, Planning, & Feedback">🤔</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://masalmon.eu/"><img src="https://avatars.githubusercontent.com/u/8360597?v=4?s=100" width="100px;" alt="Maëlle Salmon"/><br /><sub><b>Maëlle Salmon</b></sub></a><br /><a href="#ideas-maelle" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/ropensci/mapmetadata/commits?author=maelle" title="Code">💻</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://philosopher-analyst.netlify.app/"><img src="https://avatars.githubusercontent.com/u/39963221?v=4?s=100" width="100px;" alt="Zoë Turner"/><br /><sub><b>Zoë Turner</b></sub></a><br /><a href="#ideas-Lextuga007" title="Ideas, Planning, & Feedback">🤔</a> <a href="#userTesting-Lextuga007" title="User Testing">📓</a></td>
    </tr>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://ymansiaux.github.io/yohann-data"><img src="https://avatars.githubusercontent.com/u/49268931?v=4?s=100" width="100px;" alt="Yohann Mansiaux"/><br /><sub><b>Yohann Mansiaux</b></sub></a><br /><a href="#ideas-ymansiaux" title="Ideas, Planning, & Feedback">🤔</a> <a href="#userTesting-ymansiaux" title="User Testing">📓</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://allcontributors.org/) specification. Contributions of any kind are welcome!

## Acknowledgements ✨

Thanks to the [MELD-B research project](https://www.southampton.ac.uk/publicpolicy/support-for-policymakers/policy-projects/Current%20projects/meld-b.page) and the [SAIL Databank](https://saildatabank.com/) team for ideas and feedback. Thanks to the [Health Data Research Gateway](https://healthdatagateway.org/en), and the participating data providers, for hosting open metadata.

This project was created by the [AI for Multiple Long Term Conditions Research Support Facility (AIM-RSF)](https://www.turing.ac.uk/research/research-projects/ai-multiple-long-term-conditions-research-support-facility). AIM RSF is funded by the NIHR Artificial Intelligence for Multiple Long-Term Conditions (AIM) programme (NIHR202647). The views expressed are those of the author(s) and not necessarily those of the NIHR or the Department of Health and Social Care.


