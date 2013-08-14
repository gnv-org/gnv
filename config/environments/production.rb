IdeoSf72::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = true

  # -We don't set s-maxage on static assets because we don't mind them being cached on
  # CDN for 1 day. This is because Rails changes the hashes appendended to the assets when they are updated,
  # so cache is invalidated indirectly.
  # -"public" makes assests available to be cached by intermediate cache layers (CDN and Memcache)
  # -"max-age" sets time in seconds for assets to be cached on browser and on Memcache (not on CDN)
  config.static_cache_control = "public, max-age=20"

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += ['*.js', '*.css']

  client = Dalli::Client.new
  config.action_dispatch.rack_cache = {
    :metastore    => client,
    :entitystore  => client,
    :allow_reload => false
  }
end
