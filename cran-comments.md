
# Re-submission 2021-12-12

Dear Uwe,

Thank you for the quick feedback!
I adjusted the link URL in README to https://www.sqlite.org/index.html

Best regards,
Nikolaus

* README adjusted, link URL changed
* Package version updated to 0.2.1
  * DESCRIPTION file updated
  * NEWS.md file updated

## Test environments

* local
  * Windows 10, R 4.1.2
* rhub::check_for_cran()
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit
  * Ubuntu Linux 20.04.1 LTS, R-release, GCC
  * Fedora Linux, R-devel, clang, gfortran

## R CMD check results

* 0 errors
* 0 warnings
* 0 notes

# CRAN feedback 2021-12-12

```
Thanks, we see:


  Found the following (possibly) invalid URLs:
    URL: https://www.sqlite.org (moved to https://www.sqlite.org/index.html)
      From: README.md
      Status: 301
      Message: Moved Permanently

Please change http --> https, add trailing slashes, or follow moved content as appropriate.

Please fix and resubmit.

Best,
Uwe Ligges
```

# Submission 2021-12-11

* Package version 0.2.0
  * Addition of S3 class functionality
  * Addition of optional object ID
  * Addition of vignettes and extension of documentation
  * Addition of messages to functions

## Test environments

* local
  * Windows 10, R 4.1.2
* rhub::check_for_cran()
  * Windows Server 2008 R2 SP1, R-devel, 32/64 bit
  * Ubuntu Linux 20.04.1 LTS, R-release, GCC
  * Fedora Linux, R-devel, clang, gfortran

## R CMD check results

* 0 errors
* 0 warnings
* 0 notes
