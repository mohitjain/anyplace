child :pagination do
  node(:limit_value) { locals[:pagination_object].limit_value }
  node(:total_pages) { locals[:pagination_object].total_pages }
  node(:current_page) { locals[:pagination_object].current_page }
  node(:next_page) { locals[:pagination_object].next_page }
  node(:prev_page) { locals[:pagination_object].prev_page }
  node(:first_page?) { locals[:pagination_object].first_page? }
  node(:last_page?) { locals[:pagination_object].last_page? }
  node(:out_of_range?) { locals[:pagination_object].out_of_range? }
end
