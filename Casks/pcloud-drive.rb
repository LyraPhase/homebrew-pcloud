cask "pcloud-drive" do
  version "3.9.4"
  sha256 "05e6ed62185d689688894096e0b9c32ee9256b77d4f4e1503d60dbfec1b5c593"

  url do
    require "net/http"
    require "json"
    api = "https://api.pcloud.com/"
    code = "XZxCdakZRh9qTwDrTU57A4KXw5E2CVMnLrDV"
    uri = URI(api + "getpublinkdownload?code=" + code)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    data["hosts"][0] + data["path"]
  end
  name "pCloud Drive"
  homepage "https://www.pcloud.com/"

  depends_on cask: "osxfuse"

  pkg "pCloud Drive 3.9.4.pkg"

  uninstall quit:    "com.pcloud.pcloud.macos",
            pkgutil: "com.mobileinno.pkg.pCloudDrive"
end
