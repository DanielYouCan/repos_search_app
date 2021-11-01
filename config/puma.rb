workers Integer(ENV['WEB_CONCURRENCY'] || 2)

max_threads = Integer(ENV['WEB_MAX_THREADS'] || 8)
threads max_threads, max_threads

env = ENV.fetch('SINATRA_ENV') { 'development' }
environment env

port ENV.fetch('PUMA_PORT', 3000)

preload_app! if env == 'production'
