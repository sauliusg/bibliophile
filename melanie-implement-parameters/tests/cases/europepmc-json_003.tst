Test the '--count' option of europepmc-json script with only one result, queried
by its ID, fetched from the command line as an argument (using '--search'
option), using the default page size.

The post-processing just extracts the hitcount from Europe-pmc response (json
formated), and outputs it. We assume that the IDs will not change in the future,
so we always expect to get the same result for this query.
