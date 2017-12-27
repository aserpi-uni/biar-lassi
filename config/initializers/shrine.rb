Shrine.plugin :activerecord
Shrine.plugin :backgrounding
Shrine.plugin :cached_attachment_data
Shrine.plugin :delete_raw
Shrine.plugin :logging
Shrine.plugin :processing
Shrine.plugin :remove_attachment
Shrine.plugin :versions

if ENV['RAILS_ENV'] == 'production'
  require 'shrine/storage/cloudinary'

  Cloudinary.config(
    cloud_name: ENV['CLOUDINARY_CLOUD_NAME'],
    api_key:    ENV['CLOUDINARY_API_KEY'],
    api_secret: ENV['CLOUDINARY_API_SECRET']
  )

  Shrine.storages = {
    cache: Shrine::Storage::Cloudinary.new(prefix: 'cache'),
    store: Shrine::Storage::Cloudinary.new(prefix: 'store')
  }
else
  require 'shrine/storage/file_system'

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store')
  }
end

Shrine::Attacher.promote { |data| PromoteImageJob.perform_now(data) }
Shrine::Attacher.delete { |data| DeleteImageJob.perform_now(data) }
