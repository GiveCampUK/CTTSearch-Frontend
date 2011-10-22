## Views

 * `layout.erb` - Main layout view.
 * `index.erb` - index page (homepage).
 * `result.erb` - Single result page (single entity)
 * `results.erb` - Search results page (entity grid, videos, text etc.)
 * `results_guided.erb` - Specialised Search results page for a "guided search". Only slightly different to `results.erb`.
 * `no_results.erb` - Page to display if no results can be found
 * `category_explore.erb` - Category exploration page. Shows sub-categories of any given category. (E.g. for the "comms" category, "email", "phone" etc. are shown on this page *?*)

## Embeddables (tiny sub views)

 * `popular_topics.erb` - Our popular categories. To be embedded in other pages.
 * `categories.erb` - Displays categories