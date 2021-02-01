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
  version "3.9.10"
  sha256 "1279444a3d773103c0864eafd6b64e9090b14ebc87a19845d9417dbda24072fd"

  url do
    require "net/http"
    require "json"
    api = "https://api.pcloud.com/"
    code = "XZ36mmXZyQgWjRYW7RuJ27omklH6E7O5fiU7"
    uri = URI(api + "getpublinkdownload?code=" + code)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    "https://" + data["hosts"][0] + data["path"]
  end
  name "pCloud Drive"
  homepage "https://www.pcloud.com/"
  desc "Client for the pCloud virtual cloud storage service"

  depends_on cask: "osxfuse"

  pkg "pCloud Drive #{version.to_s}.pkg"

  uninstall quit:    "com.pcloud.pcloud.macos",
            pkgutil: "com.mobileinno.pkg.pCloudDrive"
end
