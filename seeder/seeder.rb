pages << {
  page_type: "listings",
  method: "GET",
  headers: {"User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
  # url: "https://www.walmart.com/browse/new-in-movies/0/0?_refineresult=true&_be_shelf_id=1522545&search_sort=100&facet=shelf_id%3A1522545&povid=_Movies_cp_static_topnav_newreleases",
  url: "https://www.walmart.com/browse/movies-tv-shows/4096?facet=new_releases:Last+90+Days",
  fetch_type: "browser",
  force_fetch: true
}