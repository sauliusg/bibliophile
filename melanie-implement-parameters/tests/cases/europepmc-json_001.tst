Test the '--count' option of europepmc-json script with a known number of
results (just four of them), queried by their IDs, fetched from a file given as
an argument, using the default page size.

The post-processing just extracts the hitcount from Europe-pmc response (json
formated), and outputs them sorted alphabetically. We assume that the IDs will
not change in the future, so we always expect to get the same result for this
query.
