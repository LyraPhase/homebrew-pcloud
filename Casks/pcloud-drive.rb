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
  version "4.0.11"

  sha256 "3b7fe9d8e15a7352088140d3315f20bdcc4cc93bb66a641a8cf8bf76cde06bfc"
  pkg "pCloud Drive #{version.to_s} UNIVERSAL.pkg"
  code = "XZsM0O5ZJ3t7mlu0PahirlgvRfmLl0GNMWMy"

  def construct_url(code)
    require "net/http"
    require "json"
    api = "https://api.pcloud.com/"
    uri = URI(api + "getpublinkdownload?code=" + code)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    "https://" + data["hosts"][0] + data["path"]
  end

  url construct_url(code)

  livecheck do
    url "https://www.pcloud.com/release-notes/mac-os.html"
    strategy :page_match
    regex(%r{<b>(\d+(?:\.\d+)*)</b>}i)
  end

  name "pCloud Drive"
  homepage "https://www.pcloud.com/"
  desc "Client for the pCloud virtual cloud storage service"

  depends_on cask: "macfuse"

  uninstall quit:    "com.pcloud.pcloud.macos",
            pkgutil: "com.mobileinno.pkg.pCloudDrive"
end
