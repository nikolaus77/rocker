
# Submission package version 0.3.0

* Addition of unit tests, 'testthat' package, and coverage determination, 'codecov'
* Use 'sodium' package for encryption of credentials
* Addition of further tests of function parameters
* Addition of validateCon / validateQuery functionality
* Addition of onLostNull parameter to validation functions: isValidDrv(), isValidDrv() and isValidDrv()
* Improved handling of three dots (...) parameter
* Updated print() function
* Extension of documentation

## Test environments

* local
  * Windows 10, R 4.1.2
* GitHub / Actions
  * macOS-latest (release)
  * windows-latest (release)
  * ubuntu-latest (devel)
  * ubuntu-latest (release)
  * ubuntu-latest (oldrel-1)
* devtools::check_win_devel()
  * x86_64-w64-mingw32 (64-bit), R Under development (unstable) (2022-01-03 r81439 ucrt)
* devtools::check_win_release()
  * x86_64-w64-mingw32 (64-bit), R version 4.1.2 (2021-11-01)
* devtools::check_mac_release()
  * r-release-macosx-arm64|4.1.1|macosx|macOS 11.5.2 (20G95)|Mac mini|Apple M1|
* rhub::check_on_linux() 
  * Debian Linux, R-release, GCC
* rhub::check_on_ubuntu()
  * Ubuntu Linux 20.04.1 LTS, R-release, GCC
* rhub::check_on_fedora()
  * Fedora Linux, R-devel, GCC
* rhub::check_on_windows()
  * Windows Server 2008 R2 SP1, R-release, 32/64 bit

## R CMD check results

* 0 errors
* 0 warnings
* 0 notes
