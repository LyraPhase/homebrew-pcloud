cask 'pcloud-drive' do
  version '3.8.4'
  sha256 'c5c29785d6584d5c35da340e01687dc479949bce10cd7545ffef6b1f0e18bcd0'

  url do
    require 'net/http'
    require 'json'
    api = 'https://api.pcloud.com/'
    code = 'XZYOy4kZNOeMXcp5GkFAEbmG8Uh5eVl35j4k'
    uri = URI(api + 'getpublinkdownload?code=' + code)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    data['hosts'][0] + data['path']
  end
  name 'pCloud Drive'
  homepage 'https://www.pcloud.com/'

  depends_on cask: 'osxfuse'

  pkg 'pCloud Drive 3.8.4.pkg'

  uninstall quit:    'com.pcloud.pcloud.macos',
            pkgutil: 'com.mobileinno.pkg.pCloudDrive'
end
