Test how the europepmc-json fetches the known number of results (just
four of them), queried by their IDs, using page size = 3 as an option.

The post-processing just extracts the record IDs from the EuropePMC
response, and outputs them sorted alphabetically. We assume that the
IDs will not change in the future, so we always expect to get the same
result for this query.
