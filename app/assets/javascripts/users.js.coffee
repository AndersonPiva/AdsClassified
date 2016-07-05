$ ->
  $('#user_search').typeahead
    name: "user"
    remote: "/search/autocomplete?query=%QUERY"

$ ->
  $('a.load-more-advertisements').on 'inview', (e, visible) ->
    return unless visible

    $.getScript $(this).attr('href')
