Test the '--count' option of europepmc-json script with a known number of
results, queried by their IDs, fetched from the command line as arguments (using
'--search' option and one paper's ID) plus four from an input file given as an
argument, using the default page size.

The post-processing just extracts the hitcount from Europe-pmc response (json
formated), and outputs it. We assume that the IDs will not change in the future,
so we always expect to get the same result for this query.
