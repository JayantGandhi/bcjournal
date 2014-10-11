CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = ENV['AWS_S3_BUCKET']
  config.aws_acl    = :public_read
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {
    access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  }
end