Tests the response of the script to a file whose content is not URL-encoded,
and the option '--url-encode' is not given. It should return :
$0: WARNING, the search term '${SEARCH_TERMS}' contains spaces and will not work
$0: WARNING, please URL-encode your search term or use '--url-encode' option
$0: WARNING, will skip the '${SEARCH_TERMS}' search term
