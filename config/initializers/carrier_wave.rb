# require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage    = :aws
    config.aws_bucket = ENV.fetch('S3_BUCKET')
    config.aws_acl    = 'public-read'

    config.aws_attributes = {
      expires: 1.week.from_now.httpdate,
      cache_control: 'max-age=604800'
    }

    config.aws_credentials = {
      # Configuration for Amazon S3
      access_key_id:        ENV.fetch('S3_ACCESS_KEY'),
      secret_access_key:    ENV.fetch('S3_SECRET_KEY'),
      region:               ENV.fetch('S3_REGION'),
      stub_responses:       Rails.env.test?
    }
  end
end

# if Rails.env.production?
#   CarrierWave.configure do |config|
#     config.fog_provider = 'fog/aws'
#     config.fog_credentials = {
#       # Configuration for Amazon S3
#       :provider              => 'AWS',
#       :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
#       :aws_secret_access_key => ENV['S3_SECRET_KEY'],
#       :region                => ENV['S3_REGION']
#     }
#     config.fog_directory     =  ENV['S3_BUCKET']
#   end
# end
