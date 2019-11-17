# frozen_string_literal: true

Ransack.configure do |config|
  # Name the search_key `:query` instead of the default `:q`
  # config.search_key = :q

  # Raise if an unknown predicate, condition or attribute is passed
  config.ignore_unknown_conditions = false

  # Ransack sanitizes many values in your custom scopes into booleans.
  # [1, '1', 't', 'T', 'true', 'TRUE'] all evaluate to true.
  # [0, '0', 'f', 'F', 'false', 'FALSE'] all evaluate to false.
  # Accept my custom scope values as what they are.
  # config.sanitize_custom_scope_booleans = false

  # By default, Ransack displays sort order indicator arrows in sort links.
  # Hide sort link order indicators globally across the application
  # config.hide_sort_order_indicators = true

  # Globally set the up arrow to an icon,
  # and the down and default arrows to unicode.
  # config.custom_arrows = {
  #   up_arrow:   '<i class="fa fa-long-arrow-up"></i>',
  #   down_arrow: 'U+02193',
  #   default_arrow: 'U+11047'
  # }
end
