#
# Cask:: pcloud-drive
# Recipe:: default
# Authors:: James Cuzella, Tom Gross
#
# Copyright:: © 🄯 2019-2020,  James Cuzella
# Copyright:: © 🄯 2019 Tom Gross
# License:: GPLv3.0
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


cask "pcloud-drive" do
  version "3.10.0"

  if Hardware::CPU.intel?
    sha256 "c98a3cf8994f335e8a7f548dbc975e7f894cf640ddbe27fe9838442352ecb39e"
    pkg "pCloud Drive #{version.to_s}.pkg"

    code = "XZdNfSXZciWjfoKaKUk2eIcL9ryR9uC9lscX"
  else
    sha256 "f28d9f6ef5144f9b2ff6603617601bdf0de09ac547de4b1c20a56348783c7049"
    pkg "pCloud Drive #{version.to_s} M1.pkg"

    code = "XZkafSXZdLkSWOtq4YhWcqqju4MKPfN5Lz00"
  end

  url do
    require "net/http"
    require "json"
    api = "https://api.pcloud.com/"
    uri = URI(api + "getpublinkdownload?code=" + code)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    "https://" + data["hosts"][0] + data["path"]
  end
  name "pCloud Drive"
  homepage "https://www.pcloud.com/"
  desc "Client for the pCloud virtual cloud storage service"

  depends_on cask: "macfuse"

  uninstall quit:    "com.pcloud.pcloud.macos",
            pkgutil: "com.mobileinno.pkg.pCloudDrive"
end
